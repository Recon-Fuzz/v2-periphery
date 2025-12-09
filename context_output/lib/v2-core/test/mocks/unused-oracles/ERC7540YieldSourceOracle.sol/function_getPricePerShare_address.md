# Function: getPricePerShare(address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getPricePerShare(address)`
- **Visibility**: public
- **Source Range**: 2386:302:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address yieldSourceAddress) override public view returns (uint256) {
    address share = IERC7540(yieldSourceAddress).share();
    uint256 _decimals = IERC20Metadata(share).decimals();
    return IERC7540(yieldSourceAddress).convertToAssets(10 ** _decimals);
}
```

## External Calls

- **IERC7540::share()**
- **IERC20Metadata::decimals()**
- **IERC7540::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getPricePerShare(address) (NodeID: 0)
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
