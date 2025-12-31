# Function: fulfillRedeemRequests(address[],uint256[])

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `fulfillRedeemRequests(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 13823:2016:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function fulfillRedeemRequests(address[] calldata controllers, uint256[] calldata totalAssetsOut) external nonReentrant() {
    _isManager(msg.sender);
    _validateStrategyState(_getSuperVaultAggregator());
    uint256 len = controllers.length;
    if ((len == 0) || (totalAssetsOut.length != len)) revert INVALID_ARRAY_LENGTH();
    FulfillRedeemVars memory vars;
    vars.currentPPS = getStoredPPS();
    if (vars.currentPPS == 0) revert INVALID_PPS();
    for (uint256 i; i < len; ++i) {
        if ((i > 0) && (controllers[i] <= controllers[i - 1])) revert CONTROLLERS_NOT_SORTED_UNIQUE();
        uint256 pendingShares = superVaultState[controllers[i]].pendingRedeemRequest;
        vars.totalRequestedShares += pendingShares;
        if (pendingShares == 0) revert ZERO_SHARE_FULFILLMENT_DISALLOWED();
        _processExactFulfillmentBatch(controllers[i], totalAssetsOut[i], vars.currentPPS, pendingShares);
        vars.totalNetAssetsOut += totalAssetsOut[i];
    }
    vars.strategyBalance = _getTokenBalance(address(_asset), address(this));
    if (vars.strategyBalance < vars.totalNetAssetsOut) {
        revert INSUFFICIENT_LIQUIDITY();
    }
    ISuperVault(_vault).burnShares(vars.totalRequestedShares);
    if (vars.totalNetAssetsOut > 0) {
        _asset.safeTransfer(ISuperVault(_vault).escrow(), vars.totalNetAssetsOut);
    }
    emit RedeemRequestsFulfilled(controllers, vars.totalRequestedShares, vars.currentPPS);
}
```

## Related Implementations

### _isManager(address)

- **Kind**: internal
- **Source**: 35413:195:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isManager(address)`

```solidity
/// @notice Internal function to check if a manager is authorized
///  @param manager_ The manager to check
function _isManager(address manager_) internal view {
    if (!_getSuperVaultAggregator().isAnyManager(manager_, address(this))) {
        revert MANAGER_NOT_AUTHORIZED();
    }
}
```

### _getSuperVaultAggregator()

- **Kind**: internal
- **Source**: 35041:251:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_getSuperVaultAggregator()`

```solidity
/// @notice Internal function to get the SuperVaultAggregator
///  @return The SuperVaultAggregator
function _getSuperVaultAggregator() internal view returns (ISuperVaultAggregator) {
    address aggregatorAddress = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_VAULT_AGGREGATOR());
    return ISuperVaultAggregator(aggregatorAddress);
}
```

### _validateStrategyState(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 47789:269:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_validateStrategyState(contract ISuperVaultAggregator)`

```solidity
/// @notice Validates full pps state by checking pause, stale, and PPS update status
///  @dev Used for operations that require current PPS for calculations:
///       - handleOperations4626Deposit: Needs PPS to calculate shares from assets
///       - handleOperations4626Mint: Needs PPS to validate asset requirements
///       - fulfillRedeemRequests: Needs current PPS to calculate assets from shares
///  @param aggregator The SuperVaultAggregator contract
function _validateStrategyState(ISuperVaultAggregator aggregator) internal view {
    if (_isPaused(aggregator)) revert STRATEGY_PAUSED();
    if (_isPPSStale(aggregator)) revert STALE_PPS();
    if (_isPPSNotUpdated(aggregator)) revert PPS_EXPIRED();
}
```

### _isPaused(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 45919:148:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPaused(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the strategy is currently paused
///  @dev This calls SuperVaultAggregator.isStrategyPaused to determine pause status
///  @return True if the strategy is paused, false otherwise
function _isPaused(ISuperVaultAggregator aggregator) internal view returns (bool) {
    return aggregator.isStrategyPaused(address(this));
}
```

### _isPPSStale(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 46256:144:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPPSStale(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the PPS is stale
///  @dev This calls SuperVaultAggregator.isPPSStale to determine stale status
///  @return True if the PPS is stale, false otherwise
function _isPPSStale(ISuperVaultAggregator aggregator) internal view returns (bool) {
    return aggregator.isPPSStale(address(this));
}
```

### _isPPSNotUpdated(contract ISuperVaultAggregator)

- **Kind**: internal
- **Source**: 46667:635:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPPSNotUpdated(contract ISuperVaultAggregator)`

```solidity
/// @notice Checks if the PPS is not updated
///  @dev This checks if the PPS has not been updated since the `ppsExpiration` time
///  @param aggregator The SuperVaultAggregator contract
///  @return True if the PPS is not updated, false otherwise
function _isPPSNotUpdated(ISuperVaultAggregator aggregator) internal view returns (bool) {
    uint256 lastPPSUpdateTimestamp = aggregator.getLastUpdateTimestamp(address(this));
    return (block.timestamp - lastPPSUpdateTimestamp) > ppsExpiration;
}
```

### getStoredPPS()

- **Kind**: internal
- **Source**: 24587:126:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:getStoredPPS()`

```solidity
/// @inheritdoc ISuperVaultStrategy
function getStoredPPS() public view returns (uint256) {
    return _getSuperVaultAggregator().getPPS(address(this));
}
```

### _processExactFulfillmentBatch(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 33193:1550:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_processExactFulfillmentBatch(address,uint256,uint256,uint256)`

```solidity
/// @notice Process exact fulfillment for batch processing
///  @dev Handles all accounting updates for fulfilled redemption:
///       1. Validates slippage bounds (minAssets <= actual <= theoretical)
///       2. Updates weighted average withdraw price across multiple fulfillments
///       3. Clears pending state and makes assets claimable
///       4. Resets cancellation flags
///  @dev SECURITY: Bounds validation ensures manager cannot underfill/overfill
///  @dev ACCOUNTING: Average withdraw price uses weighted formula to track historical execution prices
///  @param controller Controller address
///  @param totalAssetsOut Total assets available for this controller (from executeHooks)
///  @param currentPPS Current price per share
///  @param pendingShares Pending shares for this controller (passed to avoid re-reading from storage)
function _processExactFulfillmentBatch(address controller, uint256 totalAssetsOut, uint256 currentPPS, uint256 pendingShares) internal {
    SuperVaultState storage state = superVaultState[controller];
    uint16 slippageBps = (state.redeemSlippageBps > 0) ? state.redeemSlippageBps : DEFAULT_REDEEM_SLIPPAGE_BPS;
    uint256 theoreticalAssets = pendingShares.mulDiv(currentPPS, PRECISION, Math.Rounding.Floor);
    uint256 minAssetsOut = SuperVaultAccountingLib.computeMinNetOut(pendingShares, state.averageRequestPPS, slippageBps, PRECISION);
    if ((totalAssetsOut < minAssetsOut) || (totalAssetsOut > theoreticalAssets)) {
        revert BOUNDS_EXCEEDED(minAssetsOut, theoreticalAssets, totalAssetsOut);
    }
    state.averageWithdrawPrice = SuperVaultAccountingLib.calculateAverageWithdrawPrice(state.maxWithdraw, state.averageWithdrawPrice, pendingShares, totalAssetsOut, PRECISION);
    state.pendingRedeemRequest = 0;
    state.maxWithdraw += totalAssetsOut;
    state.averageRequestPPS = 0;
    state.pendingCancelRedeemRequest = false;
    state.claimableCancelRedeemRequest = 0;
    emit RedeemClaimable(controller, totalAssetsOut, pendingShares, state.averageWithdrawPrice);
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

### computeMinNetOut(uint256,uint256,uint16,uint256)

- **Kind**: internal
- **Source**: 1421:454:531
- **Link**: `src/libraries/SuperVaultAccountingLib.sol:SuperVaultAccountingLib:computeMinNetOut(uint256,uint256,uint16,uint256)`

```solidity
/// @notice Compute minimum acceptable assets (slippage floor)
///  @param requestedShares Number of shares being redeemed
///  @param averageRequestPPS PPS at time of request (slippage anchor)
///  @param slippageBps User's slippage tolerance in basis points
///  @param precision Precision constant for PPS calculations
///  @return minAssetsOut User's minimum acceptable assets
function computeMinNetOut(uint256 requestedShares, uint256 averageRequestPPS, uint16 slippageBps, uint256 precision) internal pure returns (uint256 minAssetsOut) {
    uint256 expectedAssets = requestedShares.mulDiv(averageRequestPPS, precision, Math.Rounding.Floor);
    minAssetsOut = expectedAssets.mulDiv(BPS_PRECISION - slippageBps, BPS_PRECISION, Math.Rounding.Floor);
}
```

### calculateAverageWithdrawPrice(uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2333:954:531
- **Link**: `src/libraries/SuperVaultAccountingLib.sol:SuperVaultAccountingLib:calculateAverageWithdrawPrice(uint256,uint256,uint256,uint256,uint256)`

```solidity
/// @notice Calculate updated average withdraw price
///  @param currentMaxWithdraw Current max withdrawable assets
///  @param currentAverageWithdrawPrice Current average withdraw price
///  @param requestedShares New shares being fulfilled
///  @param fulfilledAssets Assets received from fulfilling the redeem request
///  @param precision Precision constant
///  @return newAverageWithdrawPrice Updated average withdraw price
function calculateAverageWithdrawPrice(uint256 currentMaxWithdraw, uint256 currentAverageWithdrawPrice, uint256 requestedShares, uint256 fulfilledAssets, uint256 precision) internal pure returns (uint256 newAverageWithdrawPrice) {
    uint256 existingShares;
    uint256 existingAssets;
    if ((currentMaxWithdraw > 0) && (currentAverageWithdrawPrice > 0)) {
        existingShares = currentMaxWithdraw.mulDiv(precision, currentAverageWithdrawPrice, Math.Rounding.Floor);
        existingAssets = currentMaxWithdraw;
    }
    uint256 newTotalShares = existingShares + requestedShares;
    uint256 newTotalAssets = existingAssets + fulfilledAssets;
    if (newTotalShares > 0) {
        newAverageWithdrawPrice = newTotalAssets.mulDiv(precision, newTotalShares, Math.Rounding.Floor);
    }
    return newAverageWithdrawPrice;
}
```

### _getTokenBalance(address,address)

- **Kind**: internal
- **Source**: 45299:145:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_getTokenBalance(address,address)`

```solidity
/// @notice Internal function to get the token balance of an account
///  @param token Address of the token
///  @param account Address of the account
///  @return Token balance of the account
function _getTokenBalance(address token, address account) private view returns (uint256) {
    return IERC20(token).balanceOf(account);
}
```

### nonReentrant()

- **Kind**: modifier
- **Source**: 3361:103:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 3470:384:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
    if ($._status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    $._status = ENTERED;
}
```

### _getReentrancyGuardStorage()

- **Kind**: internal
- **Source**: 2395:183:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_getReentrancyGuardStorage()`

```solidity
function _getReentrancyGuardStorage() private pure returns (ReentrancyGuardStorage storage $) {
    assembly {
        $.slot := ReentrancyGuardStorageLocation
    }
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 3860:283:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
    $._status = NOT_ENTERED;
}
```

## External Calls

- **ISuperVault::burnShares(uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **ISuperVault::escrow()**
- **ISuperVaultAggregator::isAnyManager(address,address)**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **ISuperVaultAggregator::isStrategyPaused(address)**
- **ISuperVaultAggregator::isPPSStale(address)**
- **ISuperVaultAggregator::getLastUpdateTimestamp(address)**
- **ISuperVaultAggregator::getPPS(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_vault** (`address`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **ppsExpiration** (`uint256`)
- **DEFAULT_REDEEM_SLIPPAGE_BPS** (`uint16`)
- **PRECISION** (`uint256`)
- **BPS_PRECISION** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.fulfillRedeemRequests(address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isManager(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._validateStrategyState(contract ISuperVaultAggregator) (NodeID: 3)
  │   💬 Args: [_getSuperVaultAggregator()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 7)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPaused(contract ISuperVaultAggregator) (NodeID: 4)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSStale(contract ISuperVaultAggregator) (NodeID: 5)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSNotUpdated(contract ISuperVaultAggregator) (NodeID: 6)
  │     💬 Args: [aggregator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy.getStoredPPS() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 9)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._processExactFulfillmentBatch(address,uint256,uint256,uint256) (NodeID: 10)
  │   💬 Args: [controllers[i], totalAssetsOut[i], vars.currentPPS, pendingShares]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 11)
  │ │   💬 Args: [pendingShares, currentPPS, PRECISION, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 12)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 13)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 14)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 15)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 16)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 17)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 18)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultAccountingLib.computeMinNetOut(uint256,uint256,uint16,uint256) (NodeID: 19)
  │ │   💬 Args: [pendingShares, state.averageRequestPPS, slippageBps, PRECISION]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 20)
  │ │ │   💬 Args: [requestedShares, averageRequestPPS, precision, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 21)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 22)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 23)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 24)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 25)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 26)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 27)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 28)
  │ │     💬 Args: [expectedAssets, BPS_PRECISION - slippageBps, BPS_PRECISION, Math.Rounding.Floor]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 29)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 30)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 31)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 32)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 33)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 34)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 35)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultAccountingLib.calculateAverageWithdrawPrice(uint256,uint256,uint256,uint256,uint256) (NodeID: 36)
  │     💬 Args: [state.maxWithdraw, state.averageWithdrawPrice, pendingShares, totalAssetsOut, PRECISION]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 37)
  │   │   💬 Args: [currentMaxWithdraw, precision, currentAverageWithdrawPrice, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 38)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 39)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 40)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 41)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 42)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 43)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 44)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 45)
  │       💬 Args: [newTotalAssets, precision, newTotalShares, Math.Rounding.Floor]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 46)
  │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 47)
  │     │     💬 Args: [rounding]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 48)
  │         💬 Args: [x, y, denominator]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 49)
  │       │   💬 Args: [x, y]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 50)
  │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 51)
  │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 52)
  │               💬 Args: [condition]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getTokenBalance(address,address) (NodeID: 53)
  │   💬 Args: [address(_asset), address(this)]
  │   👁️  Def: private
  └─ [1] 🔒 MODIFIER: ReentrancyGuardUpgradeable.nonReentrant() (NodeID: 54)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantBefore() (NodeID: 55)
    │   💬 Args: [no args]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 56)
    │     💬 Args: [no args]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantAfter() (NodeID: 57)
        💬 Args: [no args]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 58)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Fulfills pending redeem requests with exact total assets per controller (pre-fee).
 @dev PRE: Off-chain sort/unique controllers. Call executeHooks(sum(totalAssetsOut)) first.
 @dev Social: totalAssetsOut[i] = theoreticalGross[i] (full). Selective: totalAssetsOut[i] < theoreticalGross[i].
 @dev NOTE: totalAssetsOut includes fees - actual net amount received is calculated internally after fee
 deduction. @param controllers Ordered/unique controllers with pending requests.
 @param totalAssetsOut Total PRE-FEE assets available for each controller[i] (from executeHooks).
