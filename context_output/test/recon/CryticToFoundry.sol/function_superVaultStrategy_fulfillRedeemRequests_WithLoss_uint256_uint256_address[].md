# Function: superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256,uint256,address[])

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256,uint256,address[])`
- **Visibility**: public
- **Source Range**: 4073:748:646
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// @dev Same as superVaultStrategy_fulfillRedeemRequests but with lowered exepectedAssetsOrSharesOut so that hook
///  execution goes through
function superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256 lossOnWithdraw, uint256 redeemShares, address[] memory controllers) public {
    uint256 assetBalanceBefore = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _executeRedeemFulfillmentWithLoss(lossOnWithdraw, redeemShares, controllers);
    uint256 assetBalanceAfter = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    gte(assetBalanceAfter, assetBalanceBefore, "strategy incurs loss on fulfillment");
    fulfillRedeemRequestsSuccess = true;
}
```

## Related Implementations

### _executeRedeemFulfillmentWithLoss(uint256,uint256,address[])

- **Kind**: internal
- **Source**: 7972:798:646
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:_executeRedeemFulfillmentWithLoss(uint256,uint256,address[])`

```solidity
function _executeRedeemFulfillmentWithLoss(uint256 lossOnWithdraw, uint256 totalRedeemShares, address[] memory requestingUsers) internal {
    (uint256 expectedAssets, , ) = _convertSVStoUnderlyingShares_WithLoss(totalRedeemShares, lossOnWithdraw);
    _executeRedeemHooksWithLoss(totalRedeemShares, lossOnWithdraw);
    uint256[] memory expectedAssetsArr = new uint256[](1);
    expectedAssetsArr[0] = expectedAssets;
    uint256[] memory totalAssetsOut = calculateAdjustedFulfillment(superVaultStrategy, requestingUsers, expectedAssetsArr);
    superVaultStrategy.fulfillRedeemRequests(requestingUsers, totalAssetsOut);
}
```

### _convertSVStoUnderlyingShares_WithLoss(uint256,uint256)

- **Kind**: internal
- **Source**: 10010:2618:646
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:_convertSVStoUnderlyingShares_WithLoss(uint256,uint256)`

```solidity
function _convertSVStoUnderlyingShares_WithLoss(uint256 redeemShares, uint256 lossOnWithdraw) internal view returns (uint256 expectedAssetsOrSharesOut, address hookAddress, bytes memory hookData) {
    address underlyingVault = _getYieldSource();
    YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(underlyingVault);
    uint256 sharesAsAssetsFromSV = superVault.convertToAssets(redeemShares);
    uint256 underlyingShares;
    if (activeYieldSourceType == YieldSourceType.ERC4626) {
        underlyingShares = IERC20(underlyingVault).balanceOf(address(superVaultStrategy));
        uint256 expectedAssets = IERC4626(underlyingVault).previewRedeem(underlyingShares);
        expectedAssetsOrSharesOut = expectedAssets - ((expectedAssets * lossOnWithdraw) / 10_000);
        hookAddress = address(redeem4626Hook);
        hookData = abi.encodePacked(bytes32(0), underlyingVault, address(superVaultStrategy), underlyingShares, false);
    } else if (activeYieldSourceType == YieldSourceType.ERC5115) {
        uint256 assetsPerShare = IStandardizedYield(underlyingVault).previewRedeem(superVault.asset(), 1e18);
        underlyingShares = Math.mulDiv(sharesAsAssetsFromSV, 1e18, assetsPerShare, Math.Rounding.Ceil);
        expectedAssetsOrSharesOut = IStandardizedYield(underlyingVault).previewRedeem(superVault.asset(), underlyingShares);
        hookAddress = address(redeem5115Hook);
        hookData = abi.encodePacked(bytes32(0), underlyingVault, address(superVaultStrategy), underlyingShares, false);
    } else {
        underlyingShares = MockERC7540Tester(underlyingVault).previewWithdraw(sharesAsAssetsFromSV);
        expectedAssetsOrSharesOut = MockERC7540Tester(underlyingVault).previewRedeem(underlyingShares);
        hookAddress = address(redeem7540Hook);
        hookData = abi.encodePacked(bytes32(0), underlyingVault, underlyingShares, false);
    }
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

### _executeRedeemHooksWithLoss(uint256,uint256)

- **Kind**: internal
- **Source**: 8776:1228:646
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:_executeRedeemHooksWithLoss(uint256,uint256)`

```solidity
function _executeRedeemHooksWithLoss(uint256 totalRedeemShares, uint256 lossOnWithdraw) internal {
    (, address hookAddress, bytes memory hookData) = _convertSVStoUnderlyingShares_WithLoss(totalRedeemShares, lossOnWithdraw);
    address[] memory hooks = new address[](1);
    hooks[0] = hookAddress;
    bytes[] memory hooksDataArray = new bytes[](1);
    hooksDataArray[0] = hookData;
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = 1;
    bytes[] memory hookCalldata = new bytes[](1);
    hookCalldata[0] = hookData;
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(hookAddress).inspect(hookData);
    superVaultStrategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: new bytes32[][](1), strategyProofs: new bytes32[][](1)}));
}
```

### calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])

- **Kind**: internal
- **Source**: 6811:1305:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])`

```solidity
///  @notice Complete workflow to calculate adjusted totalAssetsOut for fulfillRedeemRequests
///  @dev This function combines theoretical preview calculations with actual executeHooks
///       output to produce adjusted fulfillment amounts. This is the main function to use
///       when you need to fulfill redemption requests while accounting for execution losses.
///       Workflow:
///       1. Get theoretical net assets for all controllers via batch preview
///       2. Calculate total available assets from executeHooks output
///       3. Adjust theoretical amounts pro-rata to match available assets
///       4. Return adjusted array ready for fulfillRedeemRequests as totalAssetsOut
///       NOTE: The returned amounts represent totalAssetsOut (pre-fee) for fulfillRedeemRequests.
///       Fees are calculated and deducted internally based on full theoretical amounts,
///       ensuring fees are never reduced due to execution losses.
///  @param strategy The SuperVault strategy contract
///  @param controllers Sorted/unique controller addresses with pending redemptions
///  @param expectedAssetsFromHooks Array of assets expected from executeHooks (from expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Final totalAssetsOut array for fulfillRedeemRequests call (pre-fee amounts)
function calculateAdjustedFulfillment(ISuperVaultStrategy strategy, address[] memory controllers, uint256[] memory expectedAssetsFromHooks) internal view returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (expectedAssetsFromHooks.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    (uint256 totalTheoreticalAssets, uint256[] memory theoreticalAssets) = strategy.previewExactRedeemBatch(controllers);
    uint256 totalAvailableAssets = 0;
    for (uint256 i = 0; i < expectedAssetsFromHooks.length; i++) {
        console2.log("Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]);
        totalAvailableAssets += expectedAssetsFromHooks[i];
    }
    fulfillRedeemTotalAssetsOut = calculateFulfillRedeemTotalAssetsOut(controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets);
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### gte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 312:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertGe(a, b, reason);
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 17502:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left < right) {
        vm.assertGe(left, right, err);
    }
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **SuperVault::asset()**

## State Variable Reads

- **__yieldSource** (`address`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256,uint256,address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets._executeRedeemFulfillmentWithLoss(uint256,uint256,address[]) (NodeID: 1)
  │   💬 Args: [lossOnWithdraw, redeemShares, controllers]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AdminTargets._convertSVStoUnderlyingShares_WithLoss(uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [totalRedeemShares, lossOnWithdraw]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 3)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Setup._getYieldSourceTypeFromAddress(address) (NodeID: 4)
  │ │ │   💬 Args: [underlyingVault]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 5)
  │ │ │     💬 Args: [no args]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 6)
  │ │ │       💬 Args: [_yieldSources]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 7)
  │ │ │         💬 Args: [set._inner]
  │ │ │         👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 8)
  │ │     💬 Args: [sharesAsAssetsFromSV, 1e18, assetsPerShare, Math.Rounding.Ceil]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 9)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 10)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 11)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 12)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 13)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 14)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 15)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AdminTargets._executeRedeemHooksWithLoss(uint256,uint256) (NodeID: 16)
  │ │   💬 Args: [totalRedeemShares, lossOnWithdraw]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: AdminTargets._convertSVStoUnderlyingShares_WithLoss(uint256,uint256) (NodeID: 17)
  │ │     💬 Args: [totalRedeemShares, lossOnWithdraw]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 18)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Setup._getYieldSourceTypeFromAddress(address) (NodeID: 19)
  │ │   │   💬 Args: [underlyingVault]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 20)
  │ │   │     💬 Args: [no args]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 21)
  │ │   │       💬 Args: [_yieldSources]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 22)
  │ │   │         💬 Args: [set._inner]
  │ │   │         👁️  Def: private
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 23)
  │ │       💬 Args: [sharesAsAssetsFromSV, 1e18, assetsPerShare, Math.Rounding.Ceil]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 24)
  │ │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 25)
  │ │     │     💬 Args: [rounding]
  │ │     │     👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 26)
  │ │         💬 Args: [x, y, denominator]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 27)
  │ │       │   💬 Args: [x, y]
  │ │       │   👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 28)
  │ │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 29)
  │ │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │             👁️  Def: internal
  │ │           └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 30)
  │ │               💬 Args: [condition]
  │ │               👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[]) (NodeID: 31)
  │     💬 Args: [superVaultStrategy, requestingUsers, expectedAssetsArr]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 32)
  │   │   💬 Args: ["Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 35)
  │       💬 Args: [controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 36)
  │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 37)
  │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 38)
  │     │       💬 Args: [_sendLogPayloadView]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 39)
  │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 40)
  │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 41)
  │     │ │     💬 Args: [rounding]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 42)
  │     │     💬 Args: [x, y, denominator]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 43)
  │     │   │   💬 Args: [x, y]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 44)
  │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 45)
  │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │     │         👁️  Def: internal
  │     │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 46)
  │     │           💬 Args: [condition]
  │     │           👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 47)
  │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 48)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 49)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 50)
      💬 Args: [assetBalanceAfter, assetBalanceBefore, "strategy incurs loss on fulfillment"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 51)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Same as superVaultStrategy_fulfillRedeemRequests but with lowered exepectedAssetsOrSharesOut so that hook
 execution goes through
