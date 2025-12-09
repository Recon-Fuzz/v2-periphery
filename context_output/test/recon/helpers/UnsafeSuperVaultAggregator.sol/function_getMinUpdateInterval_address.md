# Function: getMinUpdateInterval(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 41108:154:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getMinUpdateInterval(address strategy) external view returns (uint256 interval) {
    return _strategyData[strategy].minUpdateInterval;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getMinUpdateInterval(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the minimum update interval for a strategy
 @param strategy Address of the strategy
 @return interval Minimum time between updates
