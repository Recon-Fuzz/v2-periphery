# Function: getPricePerShare(address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `getPricePerShare(address)`
- **Visibility**: public
- **Source Range**: 3496:170:356

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address yieldSourceAddress) override public view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).exchangeRate();
}
```

## External Calls

- **IStandardizedYield::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getPricePerShare(address) (NodeID: 0)
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
