# Function: maxRedeem(address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 16310:284:510

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxRedeem(address owner) override public view returns (uint256) {
    uint256 withdrawPrice = strategy.getAverageWithdrawPrice(owner);
    if (withdrawPrice == 0) return 0;
    return maxWithdraw(owner).mulDiv(PRECISION, withdrawPrice, Math.Rounding.Floor);
}
```

## Related Implementations

### maxWithdraw(address)

- **Kind**: internal
- **Source**: 16143:132:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:maxWithdraw(address)`

```solidity
/// @inheritdoc IERC4626
function maxWithdraw(address owner) override public view returns (uint256) {
    return strategy.claimableWithdraw(owner);
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

- **ISuperVaultStrategy::getAverageWithdrawPrice(address)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.maxRedeem(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVault.maxWithdraw(address) (NodeID: 1)
  │   💬 Args: [owner]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 2)
      💬 Args: [maxWithdraw(owner), PRECISION, withdrawPrice, Math.Rounding.Floor]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 3)
    │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 4)
    │     💬 Args: [rounding]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 5)
        💬 Args: [x, y, denominator]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 6)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 7)
          💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 8)
            💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 9)
              💬 Args: [condition]
              👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the maximum amount of Vault shares that can be redeemed from the owner balance in the Vault,
 through a redeem call.
 - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
 - MUST return balanceOf(owner) if owner is not subject to any withdrawal limit or timelock.
 - MUST NOT revert.
