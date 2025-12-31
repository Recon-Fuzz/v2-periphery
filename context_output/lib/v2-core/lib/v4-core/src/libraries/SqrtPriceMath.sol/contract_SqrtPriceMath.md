# Contract: SqrtPriceMath

## Metadata

- **Name**: SqrtPriceMath
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/SqrtPriceMath.sol
- **Documentation**: @title Functions based on Q64.96 sqrt price and liquidity
   @notice Contains the math that uses square root of price as a Q64.96 and liquidity to compute deltas

## Errors

### InvalidPriceOrLiquidity

```solidity
error InvalidPriceOrLiquidity();
```

### InvalidPrice

```solidity
error InvalidPrice();
```

### NotEnoughLiquidity

```solidity
error NotEnoughLiquidity();
```

### PriceOverflow

```solidity
error PriceOverflow();
```
