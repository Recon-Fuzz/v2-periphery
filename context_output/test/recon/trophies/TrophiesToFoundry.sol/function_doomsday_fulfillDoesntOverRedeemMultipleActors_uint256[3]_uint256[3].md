# Function: doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3],uint256[3])

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3],uint256[3])`
- **Visibility**: public
- **Source Range**: 10219:2582:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Property: fulfillRedeemRequests doesn't redeem more than requested for multiple actors
function doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3] memory sharesToMint, uint256[3] memory actorIndexes) public stateless() {
    address[] memory actors = _getActors();
    if (actors.length < 3) return;
    address[] memory testActors = new address[](3);
    uint256[] memory requestedShares = new uint256[](3);
    uint256[] memory sharesBefore = new uint256[](3);
    uint256 totalRequestedShares;
    for (uint256 i = 0; i < 3; i++) {
        testActors[i] = actors[actorIndexes[i] % actors.length];
        if (sharesToMint[i] > 0) {
            vm.prank(testActors[i]);
            superVault.mint(sharesToMint[i], testActors[i]);
        }
        sharesBefore[i] = superVault.maxRedeem(testActors[i]);
        requestedShares[i] = sharesBefore[i];
        if (requestedShares[i] > 0) {
            vm.prank(testActors[i]);
            superVault.requestRedeem(requestedShares[i], testActors[i], testActors[i]);
        }
        totalRequestedShares += requestedShares[i];
    }
    ISuperVaultStrategy.ExecuteArgs memory executeArgs = _createMultiActorExecuteArgs(testActors, requestedShares);
    uint256 totalPendingBefore;
    for (uint256 i = 0; i < 3; i++) {
        totalPendingBefore += superVault.pendingRedeemRequest(0, testActors[i]);
    }
    superVaultStrategy.executeHooks(executeArgs);
    uint256[] memory totalAssetsOut = calculateLiquidityOnlyFulfillment(superVaultStrategy, asset, testActors);
    superVaultStrategy.fulfillRedeemRequests(testActors, totalAssetsOut);
    uint256 totalPendingAfter;
    for (uint256 i = 0; i < 3; i++) {
        totalPendingAfter += superVault.pendingRedeemRequest(0, testActors[i]);
    }
    lte(totalPendingBefore - totalPendingAfter, totalRequestedShares, "Total shares redeemed must not exceed sum of requested shares");
}
```

## Related Implementations

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

### _createMultiActorExecuteArgs(address[],uint256[])

- **Kind**: internal
- **Source**: 20391:1579:647
- **Link**: `test/recon/targets/DoomsdayTargets.sol:DoomsdayTargets:_createMultiActorExecuteArgs(address[],uint256[])`

```solidity
/// @dev Helper function to create ExecuteArgs for multiple actors
function _createMultiActorExecuteArgs(address[] memory controllers, uint256[] memory amounts) internal view returns (ISuperVaultStrategy.ExecuteArgs memory) {
    uint256 numActors = controllers.length;
    address[] memory hooks = new address[](numActors);
    bytes[] memory hookCalldata = new bytes[](numActors);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](numActors);
    bytes32[][] memory globalProofs = new bytes32[][](numActors);
    bytes32[][] memory strategyProofs = new bytes32[][](numActors);
    for (uint256 i = 0; i < numActors; i++) {
        hooks[i] = _getRedeemHookForType(_getYieldSourceTypeFromAddress(_getYieldSource()));
        if (_getYieldSourceTypeFromAddress(_getYieldSource()) == YieldSourceType.ERC4626) {
            hookCalldata[i] = abi.encodePacked(bytes32(0), _getYieldSource(), address(superVaultStrategy), amounts[i], false);
        } else {
            hookCalldata[i] = abi.encodePacked(bytes32(0), _getYieldSource(), amounts[i], false);
        }
        expectedAssetsOrSharesOut[i] = amounts[i];
        globalProofs[i] = new bytes32[](0);
        strategyProofs[i] = new bytes32[](0);
    }
    return ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: globalProofs, strategyProofs: strategyProofs});
}
```

### _getRedeemHookForType(enum YieldSourceType)

- **Kind**: internal
- **Source**: 15868:440:631
- **Link**: `test/recon/Setup.sol:Setup:_getRedeemHookForType(enum YieldSourceType)`

```solidity
function _getRedeemHookForType(YieldSourceType sourceType) internal view returns (address) {
    if (sourceType == YieldSourceType.ERC4626) {
        return address(redeem4626Hook);
    } else if (sourceType == YieldSourceType.ERC5115) {
        return address(redeem5115Hook);
    } else if (sourceType == YieldSourceType.ERC7540) {
        return address(redeem7540Hook);
    }
    return address(0);
}
```

### _getYieldSourceTypeFromAddress(address)

- **Kind**: internal
- **Source**: 16819:836:631
- **Link**: `test/recon/Setup.sol:Setup:_getYieldSourceTypeFromAddress(address)`

```solidity
/// @dev Helper function to determine yield source type from address
function _getYieldSourceTypeFromAddress(address yieldSource) internal view returns (YieldSourceType) {
    address[] memory yieldSources = _getYieldSources();
    for (uint256 i = 0; i < yieldSources.length; i++) {
        if (yieldSources[i] == yieldSource) {
            if (i == 0) return YieldSourceType.ERC4626;
            if (i == 1) return YieldSourceType.ERC5115;
            if (i == 2) return YieldSourceType.ERC7540;
        }
    }
    return YieldSourceType.ERC4626;
}
```

### _getYieldSource()

- **Kind**: internal
- **Source**: 1548:192:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSource()`

```solidity
/// @notice Returns the current active yield source
function _getYieldSource() internal view returns (address) {
    if (__yieldSource == address(0)) {
        revert YieldSourceNotSetup();
    }
    return __yieldSource;
}
```

### _getYieldSources()

- **Kind**: internal
- **Source**: 1799:115:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSources()`

```solidity
/// @notice Returns all yield sources being used
function _getYieldSources() internal view returns (address[] memory) {
    return _yieldSources.values();
}
```

### calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[])

- **Kind**: internal
- **Source**: 9108:1178:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[])`

```solidity
///  @notice Calculate adjusted netAssetsOut for liquidity-only fulfillment (no executeHooks)
///  @dev This function handles cases where fulfillRedeemRequests is called directly from
///       strategy asset balance without prior executeHooks call. It uses the strategy's
///       current asset balance as the available liquidity and adjusts theoretical amounts
///       accordingly to prevent INSUFFICIENT_LIQUIDITY errors.
///       Use this function for tests that:
///       - Have free assets sitting in strategy balance
///       - Don't call executeHooks before fulfillment
///       - Want to fulfill from strategy liquidity directly
///  @param strategy The SuperVault strategy contract
///  @param asset The underlying asset contract
///  @param controllers Sorted/unique controller addresses with pending redemptions
///  @return fulfillRedeemTotalAssetsOut Final totalAssetsOut array for fulfillRedeemRequests call
function calculateLiquidityOnlyFulfillment(ISuperVaultStrategy strategy, address asset, address[] memory controllers) internal view returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if (controllers.length == 0) {
        revert EMPTY_ARRAYS();
    }
    uint256 strategyBalance = IERC20(asset).balanceOf(address(strategy));
    (uint256 totalTheoretical, uint256[] memory theoreticalAssets) = strategy.previewExactRedeemBatch(controllers);
    if (strategyBalance >= totalTheoretical) {
        return theoreticalAssets;
    }
    fulfillRedeemTotalAssetsOut = calculateFulfillRedeemTotalAssetsOut(controllers, theoreticalAssets, totalTheoretical, strategyBalance);
    return fulfillRedeemTotalAssetsOut;
}
```

### calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)

- **Kind**: internal
- **Source**: 2792:2430:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)`

```solidity
///  @notice Adjusts netAssetsOut arrays to match actual available assets from executeHooks
///  @dev This function handles the precision mismatch between theoretical fulfillment amounts
///       (calculated at current PPS) and actual assets obtained from executeHooks (which may
///       have rounding losses). The shortfall is distributed pro-rata based on each controller's
///       theoretical redemption amount.
///       Example scenario:
///       - Controller A: 800 theoretical assets (80% of total)
///       - Controller B: 200 theoretical assets (20% of total)
///       - Total theoretical: 1000 assets
///       - Available from hooks: 998 assets (2 wei loss)
///       - Adjusted A: 798.4 → 798 assets (1.6 wei loss)
///       - Adjusted B: 199.6 → 199 assets (0.4 wei loss)
///  @param controllers Array of controller addresses (must be sorted/unique)
///  @param theoreticalAssets Array of theoretical assets per controller from previewExactRedeem
///  @param totalTheoreticalAssets Total theoretical assets (sum of theoreticalAssets, from
///  previewExactRedeemBatch)
///  @param totalAvailableAssets Actual assets available from executeHooks (sum of expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Array adjusted to match available liquidity, sum <= totalAvailableAssets
function calculateFulfillRedeemTotalAssetsOut(address[] memory controllers, uint256[] memory theoreticalAssets, uint256 totalTheoreticalAssets, uint256 totalAvailableAssets) internal pure returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (theoreticalAssets.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    if (controllers.length != theoreticalAssets.length) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    fulfillRedeemTotalAssetsOut = new uint256[](controllers.length);
    if (totalTheoreticalAssets == 0) {
        revert ZERO_TOTAL_THEORETICAL();
    }
    if (totalAvailableAssets >= totalTheoreticalAssets) {
        return theoreticalAssets;
    }
    if (totalAvailableAssets > totalTheoreticalAssets) {
        revert INSUFFICIENT_AVAILABLE_ASSETS();
    }
    console2.log("Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets);
    uint256 totalAdjusted = 0;
    for (uint256 i = 0; i < theoreticalAssets.length; i++) {
        fulfillRedeemTotalAssetsOut[i] = theoreticalAssets[i].mulDiv(totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor);
        totalAdjusted += fulfillRedeemTotalAssetsOut[i];
    }
    uint256 remainder = totalAvailableAssets - totalAdjusted;
    if (remainder > 0) {
        console2.log("Remainder kept in vault as free assets:", remainder);
    }
    return fulfillRedeemTotalAssetsOut;
}
```

### log(string,uint256,uint256)

- **Kind**: internal
- **Source**: 11745:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### lte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 567:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:lte(uint256,uint256,string)`

```solidity
function lte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertLe(a, b, reason);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 16150:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left > right) {
        vm.assertLe(left, right, err);
    }
}
```

### stateless()

- **Kind**: modifier
- **Source**: 6192:68:631
- **Link**: `test/recon/Setup.sol:Setup:stateless()`

```solidity
/// Makes a handler have no side effects
///  The fuzzer will call this anyway, and because it reverts it will be removed from shrinking
///  Replace the "withGhosts" with "stateless" to make the code clean
modifier stateless() {
    _;
    revert("stateless");
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVault::mint(uint256,address)**
- **SuperVault::maxRedeem(address)**
- **SuperVault::requestRedeem(uint256,address,address)**
- **SuperVault::pendingRedeemRequest(uint256,address)**
- **SuperVaultStrategy::executeHooks(struct ISuperVaultStrategy.ExecuteArgs)**
- **SuperVaultStrategy::fulfillRedeemRequests(address[],uint256[])**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **redeem4626Hook** (`contract Redeem4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]
- **redeem5115Hook** (`contract Redeem5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Redeem5115VaultHook.sol/contract_Redeem5115VaultHook.md]
- **redeem7540Hook** (`contract Redeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Redeem7540VaultHook.sol/contract_Redeem7540VaultHook.md]
- **__yieldSource** (`address`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3],uint256[3]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 2)
  │     💬 Args: [_actors]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 3)
  │       💬 Args: [set._inner]
  │       👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: DoomsdayTargets._createMultiActorExecuteArgs(address[],uint256[]) (NodeID: 4)
  │   💬 Args: [testActors, requestedShares]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Setup._getRedeemHookForType(enum YieldSourceType) (NodeID: 5)
  │ │   💬 Args: [_getYieldSourceTypeFromAddress(_getYieldSource())]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Setup._getYieldSourceTypeFromAddress(address) (NodeID: 6)
  │ │     💬 Args: [_getYieldSource()]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 10)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 7)
  │ │       💬 Args: [no args]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 8)
  │ │         💬 Args: [_yieldSources]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 9)
  │ │           💬 Args: [set._inner]
  │ │           👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: Setup._getYieldSourceTypeFromAddress(address) (NodeID: 11)
  │ │   💬 Args: [_getYieldSource()]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 15)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 12)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 13)
  │ │       💬 Args: [_yieldSources]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 14)
  │ │         💬 Args: [set._inner]
  │ │         👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 16)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 17)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[]) (NodeID: 18)
  │   💬 Args: [superVaultStrategy, asset, testActors]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 19)
  │     💬 Args: [controllers, theoreticalAssets, totalTheoretical, strategyBalance]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 20)
  │   │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 23)
  │   │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 24)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 25)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 26)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 27)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 28)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 29)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 30)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 31)
  │       💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 32)
  │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 33)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.lte(uint256,uint256,string) (NodeID: 34)
  │   💬 Args: [totalPendingBefore - totalPendingAfter, totalRequestedShares, "Total shares redeemed must not exceed sum of requested shares"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 35)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.stateless() (NodeID: 36)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@dev Property: fulfillRedeemRequests doesn't redeem more than requested for multiple actors
