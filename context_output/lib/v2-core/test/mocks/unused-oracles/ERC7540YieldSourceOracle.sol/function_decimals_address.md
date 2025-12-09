# Function: decimals(address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 1038:203:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function decimals(address yieldSourceAddress) override external view returns (uint8) {
    address share = IERC7540(yieldSourceAddress).share();
    return IERC20Metadata(share).decimals();
}
```

## External Calls

- **IERC7540::share()**
- **IERC20Metadata::decimals()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.decimals(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Returns the number of decimals of the yield source shares
 @dev Critical for accurately interpreting share amounts and calculating prices
      Different yield sources may have different decimal precision
 @param yieldSourceAddress The address of the yield-bearing token contract
 @return decimals The number of decimals used by the yield source's share token
