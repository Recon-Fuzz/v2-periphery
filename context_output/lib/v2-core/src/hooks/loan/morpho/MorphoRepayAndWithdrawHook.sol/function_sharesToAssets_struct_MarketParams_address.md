# Function: sharesToAssets(struct MarketParams,address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `sharesToAssets(struct MarketParams,address)`
- **Visibility**: public
- **Source Range**: 9267:371:377

## Implementation

```solidity
/// @dev derive the assets for a share balance in a market
///  @param marketParams the market parameters
///  @param account the account to derive the assets for
///  @return assets the assets of the account
function sharesToAssets(MarketParams memory marketParams, address account) public view returns (uint256 assets) {
    Id id = marketParams.id();
    uint256 shareBalance = deriveShareBalance(id, account);
    Market memory market = morphoInterface.market(id);
    assets = shareBalance.toAssetsUp(market.totalBorrowAssets, market.totalBorrowShares);
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

### deriveShareBalance(Id,address)

- **Kind**: internal
- **Source**: 7030:172:377
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol:MorphoRepayAndWithdrawHook:deriveShareBalance(Id,address)`

```solidity
/// @dev derive the share balance of the account
///  @param id the id of the market
///  @param account the account to derive the share balance for
///  @return borrowShares the share balance of the account
function deriveShareBalance(Id id, address account) public view returns (uint128 borrowShares) {
    (, borrowShares, ) = morphoStaticTyping.position(id, account);
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

## External Calls

- **IMorpho::market(Id)**

## State Variable Reads

- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **VIRTUAL_ASSETS** (`uint256`)
- **VIRTUAL_SHARES** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.sharesToAssets(struct MarketParams,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 1)
  │   💬 Args: [marketParams]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveShareBalance(Id,address) (NodeID: 2)
  │   💬 Args: [id, account]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 3)
      💬 Args: [shareBalance, market.totalBorrowAssets, market.totalBorrowShares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 4)
        💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev derive the assets for a share balance in a market
 @param marketParams the market parameters
 @param account the account to derive the assets for
 @return assets the assets of the account
