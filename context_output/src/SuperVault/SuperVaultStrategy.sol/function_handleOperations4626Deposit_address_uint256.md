# Function: handleOperations4626Deposit(address,uint256)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `handleOperations4626Deposit(address,uint256)`
- **Visibility**: external
- **Source Range**: 7204:1557:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function handleOperations4626Deposit(address controller, uint256 assetsGross) external returns (uint256 sharesNet) {
    _requireVault();
    if (assetsGross == 0) revert INVALID_AMOUNT();
    if (controller == address(0)) revert ZERO_ADDRESS();
    ISuperVaultAggregator aggregator = _getSuperVaultAggregator();
    if (aggregator.isGlobalHooksRootVetoed()) {
        revert OPERATIONS_BLOCKED_BY_VETO();
    }
    _validateStrategyState(aggregator);
    uint256 feeBps = feeConfig.managementFeeBps;
    uint256 feeAssets = (feeBps == 0) ? 0 : Math.mulDiv(assetsGross, feeBps, BPS_PRECISION, Math.Rounding.Ceil);
    uint256 assetsNet = assetsGross - feeAssets;
    if (assetsNet == 0) revert INVALID_AMOUNT();
    if (feeAssets != 0) {
        address recipient = feeConfig.recipient;
        if (recipient == address(0)) revert ZERO_ADDRESS();
        _safeTokenTransfer(address(_asset), recipient, feeAssets);
        emit ManagementFeePaid(controller, recipient, feeAssets, feeBps);
    }
    uint256 pps = getStoredPPS();
    if (pps == 0) revert INVALID_PPS();
    sharesNet = Math.mulDiv(assetsNet, PRECISION, pps, Math.Rounding.Floor);
    if (sharesNet == 0) revert INVALID_AMOUNT();
    emit DepositHandled(controller, assetsNet, sharesNet);
    return sharesNet;
}
```

## Related Implementations

### _requireVault()

- **Kind**: internal
- **Source**: 45598:104:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_requireVault()`

```solidity
/// @notice Internal function to check if the caller is the vault
///  @dev This is used to prevent unauthorized access to certain functions
function _requireVault() internal view {
    if (msg.sender != _vault) revert ACCESS_DENIED();
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

## External Calls

- **ISuperVaultAggregator::isGlobalHooksRootVetoed()**

## State Variable Reads

- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)
- **BPS_PRECISION** (`uint256`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **PRECISION** (`uint256`)
- **_vault** (`address`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **ppsExpiration** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.handleOperations4626Deposit(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._requireVault() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._validateStrategyState(contract ISuperVaultAggregator) (NodeID: 3)
  │   💬 Args: [aggregator]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPaused(contract ISuperVaultAggregator) (NodeID: 4)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSStale(contract ISuperVaultAggregator) (NodeID: 5)
  │ │   💬 Args: [aggregator]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._isPPSNotUpdated(contract ISuperVaultAggregator) (NodeID: 6)
  │     💬 Args: [aggregator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 7)
  │   💬 Args: [assetsGross, feeBps, BPS_PRECISION, Math.Rounding.Ceil]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 9)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 10)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 11)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 12)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 13)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 14)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._safeTokenTransfer(address,address,uint256) (NodeID: 15)
  │   💬 Args: [address(_asset), recipient, feeAssets]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy.getStoredPPS() (NodeID: 16)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 17)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 18)
      💬 Args: [assetsNet, PRECISION, pps, Math.Rounding.Floor]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 19)
    │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 20)
    │     💬 Args: [rounding]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 21)
        💬 Args: [x, y, denominator]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 22)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 23)
          💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 24)
            💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 25)
              💬 Args: [condition]
              👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Execute a 4626 deposit by processing assets.
 @param controller The controller address
 @param assetsGross The amount of gross assets user has to deposit
 @return sharesNet The amount of net shares to mint
