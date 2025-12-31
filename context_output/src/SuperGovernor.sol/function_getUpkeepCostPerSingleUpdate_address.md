# Function: getUpkeepCostPerSingleUpdate(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getUpkeepCostPerSingleUpdate(address)`
- **Visibility**: external
- **Source Range**: 31247:158:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getUpkeepCostPerSingleUpdate(address oracle_) external view returns (uint256) {
    return _convertGasToUpkeepToken(_gasPerEntry[oracle_]);
}
```

## Related Implementations

### _convertGasToUpkeepToken(uint256)

- **Kind**: internal
- **Source**: 33921:1562:509
- **Link**: `src/SuperGovernor.sol:SuperGovernor:_convertGasToUpkeepToken(uint256)`

```solidity
/// @notice Converts gas units to UPKEEP_TOKEN cost using multi-step oracle pricing
///  @dev Performs 3 oracle conversions: Gas->Native, Native->USD, USD->UPKEEP_TOKEN
///  @dev Uses AVERAGE_PROVIDER for all price feeds to ensure consistency
///  @dev Uses Math.Rounding.Ceil to ensure sufficient upkeep coverage
///  @dev Dynamically queries token decimals to support tokens with different decimal places (e.g., USDC=6, WETH=18)
///  @param gasAmount The gas units to convert
///  @return requiredUpkeepTokens The equivalent amount in UPKEEP_TOKEN (token's native decimals)
function _convertGasToUpkeepToken(uint256 gasAmount) internal view returns (uint256) {
    address oracle = _addressRegistry[SUPER_ORACLE];
    if (oracle == address(0)) revert SUPER_ORACLE_NOT_FOUND();
    address upkeepToken = _addressRegistry[UPKEEP_TOKEN];
    if (upkeepToken == address(0)) revert UPKEEP_TOKEN_NOT_FOUND();
    uint8 tokenDecimals = IERC20Metadata(upkeepToken).decimals();
    uint256 tokenUnit = 10 ** tokenDecimals;
    (uint256 weiAmount, , , ) = ISuperOracle(oracle).getQuoteFromProvider(gasAmount, GAS_QUOTE, WEI_QUOTE, AVERAGE_PROVIDER);
    (uint256 nativeToUsd, , , ) = ISuperOracle(oracle).getQuoteFromProvider(weiAmount, NATIVE_TOKEN, USD_TOKEN, AVERAGE_PROVIDER);
    (uint256 usdPerUpkeepToken, , , ) = ISuperOracle(oracle).getQuoteFromProvider(tokenUnit, upkeepToken, USD_TOKEN, AVERAGE_PROVIDER);
    return Math.mulDiv(nativeToUsd, tokenUnit, usdPerUpkeepToken, Math.Rounding.Ceil);
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

## External Calls

- **IERC20Metadata::decimals()**
- **ISuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **_gasPerEntry** (`mapping(address => uint256)`)
- **_addressRegistry** (`mapping(bytes32 => address)`)
- **SUPER_ORACLE** (`bytes32`)
- **UPKEEP_TOKEN** (`bytes32`)
- **GAS_QUOTE** (`address`)
- **WEI_QUOTE** (`address`)
- **AVERAGE_PROVIDER** (`bytes32`)
- **NATIVE_TOKEN** (`address`)
- **USD_TOKEN** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getUpkeepCostPerSingleUpdate(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperGovernor._convertGasToUpkeepToken(uint256) (NodeID: 1)
      💬 Args: [_gasPerEntry[oracle_]]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 2)
        💬 Args: [nativeToUsd, tokenUnit, usdPerUpkeepToken, Math.Rounding.Ceil]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 3)
      │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 4)
      │     💬 Args: [rounding]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 5)
          💬 Args: [x, y, denominator]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 6)
        │   💬 Args: [x, y]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 7)
            💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 8)
              💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 9)
                💬 Args: [condition]
                👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the current upkeep cost for an entry
