# Function: getMainManager(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getMainManager(address)`
- **Visibility**: external
- **Source Range**: 44466:141:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getMainManager(address strategy) external view returns (address manager) {
    return _strategyData[strategy].mainManager;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getMainManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the main manager for a strategy
 @param strategy Address of the strategy
 @return manager Address of the main manager
