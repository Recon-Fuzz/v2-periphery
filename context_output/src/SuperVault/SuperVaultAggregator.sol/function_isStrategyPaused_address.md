# Function: isStrategyPaused(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `isStrategyPaused(address)`
- **Visibility**: external
- **Source Range**: 43704:138:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function isStrategyPaused(address strategy) external view returns (bool isPaused) {
    return _strategyData[strategy].isPaused;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.isStrategyPaused(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Checks if a strategy is currently paused
 @param strategy Address of the strategy
 @return isPaused True if paused, false otherwise
