# Function: proposeYieldSourceOracleConfig(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `proposeYieldSourceOracleConfig(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])`
- **Visibility**: external
- **Source Range**: 4003:2812:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function proposeYieldSourceOracleConfig(bytes32[] calldata yieldSourceOracleIds, YieldSourceOracleConfigArgs[] calldata configs) virtual external {
    uint256 length = configs.length;
    if (length == 0) revert ZERO_LENGTH();
    if (length != yieldSourceOracleIds.length) revert LENGTH_MISMATCH();
    for (uint256 i; i < length; ++i) {
        YieldSourceOracleConfigArgs calldata config = configs[i];
        YieldSourceOracleConfig memory existingConfig = yieldSourceOracleConfig[yieldSourceOracleIds[i]];
        if ((existingConfig.ledger == address(0)) || (existingConfig.manager == address(0))) revert CONFIG_NOT_FOUND();
        if (existingConfig.manager != msg.sender) revert NOT_MANAGER();
        if (yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleIds[i]] > block.timestamp) {
            revert CHANGE_ALREADY_PROPOSED();
        }
        if (existingConfig.feePercent > 0) {
            if (config.feePercent > 0) {
                uint256 minFee = Math.mulDiv(existingConfig.feePercent, (10_000 - MAX_FEE_PERCENT_CHANGE), 10_000, Math.Rounding.Ceil);
                uint256 maxFee = Math.mulDiv(existingConfig.feePercent, (10_000 + MAX_FEE_PERCENT_CHANGE), 10_000);
                if ((config.feePercent < minFee) || (config.feePercent > maxFee)) revert INVALID_FEE_PERCENT();
            }
        } else if ((existingConfig.feePercent == 0) && (config.feePercent > 0)) {
            if (config.feePercent > MAX_INITIAL_FEE_PERCENT) revert INVALID_FEE_PERCENT();
        }
        _validateYieldSourceOracleConfig(yieldSourceOracleIds[i], config.yieldSourceOracle, config.feePercent, config.feeRecipient, config.ledger);
        yieldSourceOracleConfigProposals[yieldSourceOracleIds[i]] = YieldSourceOracleConfig({yieldSourceOracle: config.yieldSourceOracle, feePercent: config.feePercent, feeRecipient: config.feeRecipient, manager: existingConfig.manager, ledger: config.ledger});
        yieldSourceOracleConfigProposalGracePeriod[yieldSourceOracleIds[i]] = block.timestamp + PROPOSAL_EXPIRATION_TIME;
        emit YieldSourceOracleConfigProposalSet(yieldSourceOracleIds[i], config.yieldSourceOracle, config.feePercent, config.feeRecipient, existingConfig.manager, config.ledger);
    }
}
```

## Related Implementations

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

### _validateYieldSourceOracleConfig(bytes32,address,uint256,address,address)

- **Kind**: internal
- **Source**: 13913:618:353
- **Link**: `lib/v2-core/src/accounting/SuperLedgerConfiguration.sol:SuperLedgerConfiguration:_validateYieldSourceOracleConfig(bytes32,address,uint256,address,address)`

```solidity
function _validateYieldSourceOracleConfig(bytes32 salt, address yieldSourceOracle, uint256 feePercent, address feeRecipient, address ledgerContract) virtual internal view {
    if (yieldSourceOracle == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (feeRecipient == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (ledgerContract == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (feePercent > MAX_FEE_PERCENT) revert INVALID_FEE_PERCENT();
    if (salt == bytes32(0)) revert ZERO_ID_NOT_ALLOWED();
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)
- **MAX_FEE_PERCENT_CHANGE** (`uint256`)
- **MAX_INITIAL_FEE_PERCENT** (`uint256`)
- **PROPOSAL_EXPIRATION_TIME** (`uint256`)
- **MAX_FEE_PERCENT** (`uint256`)

## State Variable Writes

- **yieldSourceOracleConfigProposals** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **yieldSourceOracleConfigProposalGracePeriod** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.proposeYieldSourceOracleConfig(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 1)
  │   💬 Args: [existingConfig.feePercent, (10_000 - MAX_FEE_PERCENT_CHANGE), 10_000, Math.Rounding.Ceil]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 2)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 3)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 4)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 5)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 6)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 7)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 9)
  │   💬 Args: [existingConfig.feePercent, (10_000 + MAX_FEE_PERCENT_CHANGE), 10_000]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 10)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 11)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 12)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 13)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperLedgerConfiguration._validateYieldSourceOracleConfig(bytes32,address,uint256,address,address) (NodeID: 14)
      💬 Args: [yieldSourceOracleIds[i], config.yieldSourceOracle, config.feePercent, config.feeRecipient, config.ledger]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Proposes changes to existing yield source oracle configurations
 @dev Only the current manager of a configuration can propose changes
      Proposals are subject to a time-lock before they can be accepted
      Fee percentage changes are limited to a maximum percentage change
 @param yieldSourceOracleIds Array of yield source IDs to propose changes for
 @param configs Array of proposed configuration changes
