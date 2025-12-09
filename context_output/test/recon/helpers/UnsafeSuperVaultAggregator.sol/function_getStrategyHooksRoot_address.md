# Function: getStrategyHooksRoot(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 47230:149:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getStrategyHooksRoot(address) (NodeID: 0)
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
