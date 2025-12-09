# Function: skimPerformanceFee()

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `skimPerformanceFee()`
- **Visibility**: external
- **Source Range**: 16079:3534:513

## Implementation

```solidity
/// @notice Skim performance fees based on per-share High Water Mark
///  @dev Can be called by any manager when vault PPS has grown above HWM
///  @dev Uses PPS-based HWM which eliminates redemption-related vulnerabilities
function skimPerformanceFee() external nonReentrant() {
    _isManager(msg.sender);
    ISuperVaultAggregator aggregator = _getSuperVaultAggregator();
    _validateStrategyState(aggregator);
    uint256 lastUnpause = aggregator.getLastUnpauseTimestamp(address(this));
    if (block.timestamp < (lastUnpause + POST_UNPAUSE_SKIM_TIMELOCK)) {
        revert SKIM_TIMELOCK_ACTIVE();
    }
    IERC4626 vault = IERC4626(_vault);
    uint256 totalSupplyLocal = vault.totalSupply();
    if (totalSupplyLocal == 0) return;
    uint256 currentPPS = aggregator.getPPS(address(this));
    if (currentPPS == 0) revert INVALID_PPS();
    uint256 hwmPps = vaultHwmPps;
    if (currentPPS <= hwmPps) {
        return;
    }
    uint256 ppsGrowth = currentPPS - hwmPps;
    uint256 profit = Math.mulDiv(ppsGrowth, totalSupplyLocal, PRECISION, Math.Rounding.Floor);
    if (profit == 0) return;
    uint256 fee = Math.mulDiv(profit, feeConfig.performanceFeeBps, BPS_PRECISION, Math.Rounding.Ceil);
    if (fee == 0) return;
    uint256 sfFee = Math.mulDiv(fee, SUPER_GOVERNOR.getFee(FeeType.PERFORMANCE_FEE_SHARE), BPS_PRECISION, Math.Rounding.Floor);
    uint256 recipientFee = fee - sfFee;
    if (_getTokenBalance(address(_asset), address(this)) < fee) revert NOT_ENOUGH_FREE_ASSETS_FEE_SKIM();
    _safeTokenTransfer(address(_asset), SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.TREASURY()), sfFee);
    _safeTokenTransfer(address(_asset), feeConfig.recipient, recipientFee);
    emit PerformanceFeeSkimmed(fee, sfFee);
    uint256 ppsReduction = Math.mulDiv(fee, PRECISION, totalSupplyLocal, Math.Rounding.Floor);
    if (ppsReduction >= currentPPS) revert INVALID_PPS();
    uint256 newPPS = currentPPS - ppsReduction;
    if (newPPS == 0) revert INVALID_PPS();
    vaultHwmPps = newPPS;
    emit HWMPPSUpdated(newPPS, currentPPS, profit, fee);
    aggregator.updatePPSAfterSkim(newPPS, fee);
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

### _safeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 44923:164:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_safeTokenTransfer(address,address,uint256)`

```solidity
/// @notice Internal function to safely transfer tokens
///  @param token Address of the token
///  @param recipient Address to receive the tokens
///  @param amount Amount of tokens to transfer
function _safeTokenTransfer(address token, address recipient, uint256 amount) private {
    if (amount > 0) IERC20(token).safeTransfer(recipient, amount);
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

- **ISuperVaultAggregator::getLastUnpauseTimestamp(address)**
- **IERC4626::totalSupply()**
- **ISuperVaultAggregator::getPPS(address)**
- **ISuperGovernor::getFee(enum FeeType)**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::TREASURY()**
- **ISuperVaultAggregator::updatePPSAfterSkim(uint256,uint256)**

## State Variable Reads

- **POST_UNPAUSE_SKIM_TIMELOCK** (`uint256`)
- **_vault** (`address`)
- **vaultHwmPps** (`uint256`)
- **PRECISION** (`uint256`)
- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **BPS_PRECISION** (`uint256`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **ppsExpiration** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **vaultHwmPps** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.skimPerformanceFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isManager(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 3)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._validateStrategyState(contract ISuperVaultAggregator) (NodeID: 4)
  │   💬 Args: [aggregator]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPaused(contract ISuperVaultAggregator) (NodeID: 5)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSStale(contract ISuperVaultAggregator) (NodeID: 6)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSNotUpdated(contract ISuperVaultAggregator) (NodeID: 7)
  │     💬 Args: [aggregator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 8)
  │   💬 Args: [ppsGrowth, totalSupplyLocal, PRECISION, Math.Rounding.Floor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 9)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 10)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 11)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 12)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 13)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 14)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 15)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 16)
  │   💬 Args: [profit, feeConfig.performanceFeeBps, BPS_PRECISION, Math.Rounding.Ceil]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 17)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 18)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 19)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 20)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 21)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 22)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 23)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 24)
  │   💬 Args: [fee, SUPER_GOVERNOR.getFee(FeeType.PERFORMANCE_FEE_SHARE), BPS_PRECISION, Math.Rounding.Floor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 25)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 26)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 27)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 28)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 29)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 30)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 31)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getTokenBalance(address,address) (NodeID: 32)
  │   💬 Args: [address(_asset), address(this)]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._safeTokenTransfer(address,address,uint256) (NodeID: 33)
  │   💬 Args: [address(_asset), SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.TREASURY()), sfFee]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._safeTokenTransfer(address,address,uint256) (NodeID: 34)
  │   💬 Args: [address(_asset), feeConfig.recipient, recipientFee]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 35)
  │   💬 Args: [fee, PRECISION, totalSupplyLocal, Math.Rounding.Floor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 36)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 37)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 38)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 39)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 40)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 41)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 42)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  └─ [1] 🔒 MODIFIER: ReentrancyGuardUpgradeable.nonReentrant() (NodeID: 43)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantBefore() (NodeID: 44)
    │   💬 Args: [no args]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 45)
    │     💬 Args: [no args]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantAfter() (NodeID: 46)
        💬 Args: [no args]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 47)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@notice Skim performance fees based on per-share High Water Mark
 @dev Can be called by any manager when vault PPS has grown above HWM
 @dev Uses PPS-based HWM which eliminates redemption-related vulnerabilities

### Interface Documentation

@notice Skim performance fees based on per-share High Water Mark (PPS-based)
 @dev Can be called by any manager when vault PPS has grown above HWM PPS
 @dev Uses PPS growth to calculate profit: (currentPPS - hwmPPS) * totalSupply / PRECISION
 @dev HWM is only updated during this function, not during deposits/redemptions
