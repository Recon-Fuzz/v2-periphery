# Function: deriveCollateralForPartialRepayment(Id,address,uint256,uint256)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `deriveCollateralForPartialRepayment(Id,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8054:386:377

## Implementation

```solidity
/// @dev derive the collateral amount for partial repayment
///  @param id the id of the market
///  @param account the account to derive the collateral amount for
///  @param amount the amount to repay
///  @param fullCollateral the full collateral amount
///  @return withdrawableCollateral the collateral amount for partial repayment
function deriveCollateralForPartialRepayment(Id id, address account, uint256 amount, uint256 fullCollateral) public view returns (uint256 withdrawableCollateral) {
    uint256 fullLoanAmount = deriveLoanAmount(id, account);
    withdrawableCollateral = Math.mulDiv(fullCollateral, amount, fullLoanAmount);
}
```

## Related Implementations

### deriveLoanAmount(Id,address)

- **Kind**: internal
- **Source**: 8659:380:377
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol:MorphoRepayAndWithdrawHook:deriveLoanAmount(Id,address)`

```solidity
/// @dev derive the loan amount of the account
///  @param id the id of the market
///  @param account the account to derive the loan amount for
///  @return loanAmount the loan amount of the account
function deriveLoanAmount(Id id, address account) public view returns (uint256 loanAmount) {
    (, uint128 fullShares, ) = morphoStaticTyping.position(id, account);
    uint256 castShares = uint256(fullShares);
    Market memory market = morphoInterface.market(id);
    loanAmount = castShares.toAssetsUp(market.totalBorrowAssets, market.totalBorrowShares);
}
```

### toAssetsUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2150:209:459
- **Link**: `lib/v2-core/src/vendor/morpho/SharesMathLib.sol:SharesMathLib:toAssetsUp(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `shares` quoted in assets, rounding up.
function toAssetsUp(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return shares.mulDivUp(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
}
```

### mulDivUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1017:128:458
- **Link**: `lib/v2-core/src/vendor/morpho/MathLib.sol:MathLib:mulDivUp(uint256,uint256,uint256)`

```solidity
/// @dev Returns (`x` * `y`) / `d` rounded up.
function mulDivUp(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return ((x * y) + (d - 1)) / d;
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

## State Variable Reads

- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **VIRTUAL_ASSETS** (`uint256`)
- **VIRTUAL_SHARES** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveCollateralForPartialRepayment(Id,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveLoanAmount(Id,address) (NodeID: 1)
  │   💬 Args: [id, account]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [castShares, market.totalBorrowAssets, market.totalBorrowShares]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 3)
  │       💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 4)
      💬 Args: [fullCollateral, amount, fullLoanAmount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 5)
    │   💬 Args: [x, y]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 6)
        💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 7)
          💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
            💬 Args: [condition]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@dev derive the collateral amount for partial repayment
 @param id the id of the market
 @param account the account to derive the collateral amount for
 @param amount the amount to repay
 @param fullCollateral the full collateral amount
 @return withdrawableCollateral the collateral amount for partial repayment
