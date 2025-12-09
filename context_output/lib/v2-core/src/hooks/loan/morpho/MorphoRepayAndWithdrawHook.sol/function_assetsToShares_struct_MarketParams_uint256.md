# Function: assetsToShares(struct MarketParams,uint256)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `assetsToShares(struct MarketParams,uint256)`
- **Visibility**: public
- **Source Range**: 9868:300:377

## Implementation

```solidity
/// @dev derive the shares for an amount of assets in a market
///  @param marketParams the market parameters
///  @param assets the assets to derive the shares for
///  @return shares the shares of the account
function assetsToShares(MarketParams memory marketParams, uint256 assets) public view returns (uint256 shares) {
    Id id = marketParams.id();
    Market memory market = morphoInterface.market(id);
    shares = assets.toSharesUp(market.totalBorrowAssets, market.totalBorrowShares);
}
```

## Related Implementations

### id(struct MarketParams)

- **Kind**: internal
- **Source**: 588:222:457
- **Link**: `lib/v2-core/src/vendor/morpho/MarketParamsLib.sol:MarketParamsLib:id(struct MarketParams)`

```solidity
/// @notice Returns the id of the market `marketParams`.
function id(MarketParams memory marketParams) internal pure returns (Id marketParamsId) {
    assembly ("memory-safe") {
        marketParamsId := keccak256(marketParams, MARKET_PARAMS_BYTES_LENGTH)
    }
}
```

### toSharesUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1858:209:459
- **Link**: `lib/v2-core/src/vendor/morpho/SharesMathLib.sol:SharesMathLib:toSharesUp(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `assets` quoted in shares, rounding up.
function toSharesUp(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return assets.mulDivUp(totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS);
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

- **IMorpho::market(Id)**

## State Variable Reads

- **VIRTUAL_SHARES** (`uint256`)
- **VIRTUAL_ASSETS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.assetsToShares(struct MarketParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 1)
  │   💬 Args: [marketParams]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SharesMathLib.toSharesUp(uint256,uint256,uint256) (NodeID: 2)
      💬 Args: [assets, market.totalBorrowAssets, market.totalBorrowShares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 3)
        💬 Args: [assets, totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev derive the shares for an amount of assets in a market
 @param marketParams the market parameters
 @param assets the assets to derive the shares for
 @return shares the shares of the account
