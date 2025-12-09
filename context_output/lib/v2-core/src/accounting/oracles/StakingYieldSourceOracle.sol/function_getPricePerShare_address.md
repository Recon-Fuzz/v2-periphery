# Function: getPricePerShare(address)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `getPricePerShare(address)`
- **Visibility**: public
- **Source Range**: 970:102:357

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address) override public pure returns (uint256) {
    return 1e18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakingYieldSourceOracle.getPricePerShare(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Retrieves the current price per share in terms of the underlying asset
 @dev Core function for calculating yields and determining returns
 @param yieldSourceAddress The yield-bearing token address to get the price for
 @return pricePerShare The current price per share in underlying asset terms, scaled by decimals
