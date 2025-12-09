# Function: deriveLoanAmount(Id,address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `deriveLoanAmount(Id,address)`
- **Visibility**: public
- **Source Range**: 8659:380:377

## Implementation

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

## Related Implementations

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

## External Calls

- **IMorphoStaticTyping::position(Id,address)**
- **IMorpho::market(Id)**

## State Variable Reads

- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **VIRTUAL_ASSETS** (`uint256`)
- **VIRTUAL_SHARES** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveLoanAmount(Id,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [castShares, market.totalBorrowAssets, market.totalBorrowShares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 2)
        💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev derive the loan amount of the account
 @param id the id of the market
 @param account the account to derive the loan amount for
 @return loanAmount the loan amount of the account
