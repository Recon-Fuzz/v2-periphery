# Function: getMainManager(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getMainManager(address)`
- **Visibility**: external
- **Source Range**: 42539:141:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getMainManager(address) (NodeID: 0)
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
