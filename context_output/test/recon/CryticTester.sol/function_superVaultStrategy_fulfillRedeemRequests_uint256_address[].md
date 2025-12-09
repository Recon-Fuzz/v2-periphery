# Function: superVaultStrategy_fulfillRedeemRequests(uint256,address[])

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVaultStrategy_fulfillRedeemRequests(uint256,address[])`
- **Visibility**: public
- **Source Range**: 3241:676:646
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// @dev Property: superVaultStrategy does not incur loss on fulfillment
function superVaultStrategy_fulfillRedeemRequests(uint256 redeemShares, address[] memory controllers) public updateGhostsWithOpType(OpType.FULFILL) {
    uint256 assetBalanceBefore = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _executeRedeemFulfillment(redeemShares, controllers);
    uint256 assetBalanceAfter = IERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    gte(assetBalanceAfter, assetBalanceBefore, "strategy incurs loss on fulfillment");
    fulfillRedeemRequestsSuccess = true;
}
```

## Related Implementations

### _executeRedeemFulfillment(uint256,address[])

- **Kind**: internal
- **Source**: 6403:1563:646
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:_executeRedeemFulfillment(uint256,address[])`

```solidity
function _executeRedeemFulfillment(uint256 totalRedeemShares, address[] memory requestingUsers) internal {
    (uint256 expectedAssetsOut, address hookAddress, bytes memory hookData) = _convertSVStoUnderlyingShares(totalRedeemShares);
    address[] memory hooks = new address[](1);
    hooks[0] = hookAddress;
    bytes[] memory hooksDataArray = new bytes[](1);
    hooksDataArray[0] = hookData;
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = expectedAssetsOut;
    bytes[] memory hookCalldata = new bytes[](1);
    hookCalldata[0] = hookData;
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(hookAddress).inspect(hookData);
    superVaultStrategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: new bytes32[][](1), strategyProofs: new bytes32[][](1)}));
    uint256[] memory totalAssetsOut = calculateLiquidityOnlyFulfillment(superVaultStrategy, superVault.asset(), requestingUsers);
    superVaultStrategy.fulfillRedeemRequests(requestingUsers, totalAssetsOut);
}
```

### _convertSVStoUnderlyingShares(uint256)

- **Kind**: internal
- **Source**: 12634:2444:646
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:_convertSVStoUnderlyingShares(uint256)`

```solidity
function _convertSVStoUnderlyingShares(uint256 redeemShares) internal view returns (uint256 expectedAssetsOrSharesOut, address hookAddress, bytes memory hookData) {
    address underlyingVault = _getYieldSource();
    YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(underlyingVault);
    uint256 sharesAsAssetsFromSV = superVault.convertToAssets(redeemShares);
    uint256 underlyingShares;
    if (activeYieldSourceType == YieldSourceType.ERC4626) {
        underlyingShares = IERC20(underlyingVault).balanceOf(address(superVaultStrategy));
        expectedAssetsOrSharesOut = IERC4626(underlyingVault).previewRedeem(underlyingShares);
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
- **Source**: 347:182:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a >= b)) {
        emit Log(reason);
        assert(false);
    }
}
```

### updateGhostsWithOpType(enum OpType)

- **Kind**: modifier
- **Source**: 1353:125:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:updateGhostsWithOpType(enum OpType)`

```solidity
modifier updateGhostsWithOpType(OpType op) {
    _currentOp = op;
    __before();
    _;
    __after();
}
```

### __before()

- **Kind**: internal
- **Source**: 1484:781:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__before()`

```solidity
function __before() internal {
    _before.naivePPS = _calculateNaivePPS();
    _before.summedTotalShares = _sumTotalShares();
    _before.summedTotalAssets = _sumStrategyAssets();
    _before.summedPendingRedeem = _sumRequestedRedemptions();
    _before.pendingUserAssets[_getActor()] = _getPendingAsAssets();
    _before.claimableUserAssets[_getActor()] = _getClaimableAsAssets();
    _before.state[_getActor()] = superVaultStrategy.getSuperVaultState(_getActor());
    _before.superVaultShares[_getActor()] = superVault.balanceOf(_getActor());
    _before.strategyAssetBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _before.oraclePPS = superVaultAggregator.getPPS(address(superVaultStrategy));
}
```

### _calculateNaivePPS()

- **Kind**: internal
- **Source**: 3812:638:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_calculateNaivePPS()`

```solidity
/// @notice Calculates the naive price per share by summing all assets across strategy and yield sources
///  @dev inspired by the share price calculation from BaseSuperVaultTest::_updateSuperVaultPPS
///  @return naivePPS The calculated price per share (scaled by 1e18)
function _calculateNaivePPS() internal view returns (uint256 naivePPS) {
    uint256 totalSupply = superVault.totalSupply();
    if (totalSupply == 0) {
        return 0;
    }
    uint256 totalAssets = _sumStrategyAssets();
    naivePPS = (totalAssets * superVault.PRECISION()) / totalSupply;
    return naivePPS;
}
```

### _sumStrategyAssets()

- **Kind**: internal
- **Source**: 4456:764:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumStrategyAssets()`

```solidity
function _sumStrategyAssets() public view returns (uint256) {
    address asset = superVault.asset();
    uint256 totalAssets;
    totalAssets += IERC20(asset).balanceOf(address(superVaultStrategy));
    address[] memory yieldSources = _getYieldSources();
    for (uint256 i = 0; i < yieldSources.length; i++) {
        if (yieldSources[i] != address(0)) {
            totalAssets += IERC20(asset).balanceOf(yieldSources[i]);
        }
    }
    return totalAssets;
}
```

### _sumTotalShares()

- **Kind**: internal
- **Source**: 3160:365:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumTotalShares()`

```solidity
/// @dev total shares in the system is the sum of shares in the escrow and held by all users
function _sumTotalShares() internal view returns (uint256) {
    address[] memory actors = _getActors();
    uint256 totalShares;
    totalShares += superVault.balanceOf(address(superVaultEscrow));
    for (uint256 i; i < actors.length; i++) {
        totalShares += superVault.balanceOf(actors[i]);
    }
    return totalShares;
}
```

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

### _sumRequestedRedemptions()

- **Kind**: internal
- **Source**: 5226:324:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumRequestedRedemptions()`

```solidity
function _sumRequestedRedemptions() internal view returns (uint256) {
    address[] memory actors = _getActors();
    uint256 totalRequested;
    for (uint256 i; i < actors.length; i++) {
        totalRequested += superVault.pendingRedeemRequest(0, actors[i]);
    }
    return totalRequested;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

### _getPendingAsAssets()

- **Kind**: internal
- **Source**: 5556:293:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_getPendingAsAssets()`

```solidity
function _getPendingAsAssets() internal view returns (uint256) {
    uint256 pendingRedemptions = superVault.pendingRedeemRequest(0, _getActor());
    uint256 pendingRedemptionsAsAssets = superVault.convertToAssets(pendingRedemptions);
    return pendingRedemptionsAsAssets;
}
```

### _getClaimableAsAssets()

- **Kind**: internal
- **Source**: 5855:305:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_getClaimableAsAssets()`

```solidity
function _getClaimableAsAssets() internal view returns (uint256) {
    uint256 claimableRedemptions = superVault.claimableRedeemRequest(0, _getActor());
    uint256 claimableRedemptionsAsAssets = superVault.convertToAssets(claimableRedemptions);
    return claimableRedemptionsAsAssets;
}
```

### __after()

- **Kind**: internal
- **Source**: 2271:770:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__after()`

```solidity
function __after() internal {
    _after.naivePPS = _calculateNaivePPS();
    _after.summedTotalShares = _sumTotalShares();
    _after.summedTotalAssets = _sumStrategyAssets();
    _after.summedPendingRedeem = _sumRequestedRedemptions();
    _after.pendingUserAssets[_getActor()] = _getPendingAsAssets();
    _after.claimableUserAssets[_getActor()] = _getClaimableAsAssets();
    _after.state[_getActor()] = superVaultStrategy.getSuperVaultState(_getActor());
    _after.superVaultShares[_getActor()] = superVault.balanceOf(_getActor());
    _after.strategyAssetBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _after.oraclePPS = superVaultAggregator.getPPS(address(superVaultStrategy));
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **SuperVault::asset()**

## State Variable Reads

- **__yieldSource** (`address`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## State Variable Writes

- **_currentOp** (`enum OpType`)
- **_before** (`struct BeforeAfter.Vars`)
- **_after** (`struct BeforeAfter.Vars`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.superVaultStrategy_fulfillRedeemRequests(uint256,address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets._executeRedeemFulfillment(uint256,address[]) (NodeID: 1)
  │   💬 Args: [redeemShares, controllers]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AdminTargets._convertSVStoUnderlyingShares(uint256) (NodeID: 2)
  │ │   💬 Args: [totalRedeemShares]
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
  │ └─ [2] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateLiquidityOnlyFulfillment(contract ISuperVaultStrategy,address,address[]) (NodeID: 16)
  │     💬 Args: [superVaultStrategy, superVault.asset(), requestingUsers]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 17)
  │       💬 Args: [controllers, theoreticalAssets, totalTheoretical, strategyBalance]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 18)
  │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │     │       💬 Args: [_sendLogPayloadView]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 21)
  │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 22)
  │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 23)
  │     │ │     💬 Args: [rounding]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 24)
  │     │     💬 Args: [x, y, denominator]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 25)
  │     │   │   💬 Args: [x, y]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 26)
  │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 27)
  │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │     │         👁️  Def: internal
  │     │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 28)
  │     │           💬 Args: [condition]
  │     │           👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 29)
  │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 30)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 31)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 32)
  │   💬 Args: [assetBalanceAfter, assetBalanceBefore, "strategy incurs loss on fulfillment"]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhostsWithOpType(enum OpType) (NodeID: 33)
      💬 Args: [OpType.FULFILL]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 34)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 35)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 36)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 37)
    │ │       💬 Args: [no args]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 38)
    │ │         💬 Args: [_yieldSources]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 39)
    │ │           💬 Args: [set._inner]
    │ │           👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 40)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 41)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 42)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 43)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 44)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 45)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 46)
    │ │       💬 Args: [_yieldSources]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 47)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 48)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 49)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 50)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 51)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 52)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 53)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 54)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 55)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 56)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 57)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 58)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 59)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 60)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 61)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 62)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 63)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 64)
      │     💬 Args: [no args]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 65)
      │       💬 Args: [no args]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 66)
      │         💬 Args: [_yieldSources]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 67)
      │           💬 Args: [set._inner]
      │           👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 68)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 69)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 70)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 71)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 72)
      │   💬 Args: [no args]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 73)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 74)
      │       💬 Args: [_yieldSources]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 75)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 76)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 77)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 78)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 79)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 80)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 81)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 82)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 83)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 84)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 85)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 86)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 87)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 88)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 89)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: superVaultStrategy does not incur loss on fulfillment
