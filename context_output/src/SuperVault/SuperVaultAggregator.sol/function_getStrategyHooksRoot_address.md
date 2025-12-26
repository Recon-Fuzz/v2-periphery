# Function: getStrategyHooksRoot(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 50696:149:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getStrategyHooksRoot(address strategy) external view returns (bytes32 root) {
    return _strategyData[strategy].managerHooksRoot;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getStrategyHooksRoot(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the hooks Merkle root for a specific strategy
 @param strategy Address of the strategy
 @return root The strategy-specific hooks Merkle root
