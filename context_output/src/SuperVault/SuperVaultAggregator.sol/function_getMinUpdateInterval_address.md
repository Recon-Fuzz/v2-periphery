# Function: getMinUpdateInterval(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 43035:154:511

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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getMinUpdateInterval(address) (NodeID: 0)
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
