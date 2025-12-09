# Function: isStrategyHooksRootVetoed(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `isStrategyHooksRootVetoed(address)`
- **Visibility**: external
- **Source Range**: 40009:152:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function isStrategyHooksRootVetoed(address strategy) external view returns (bool vetoed) {
    return _strategyData[strategy].hooksRootVetoed;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.isStrategyHooksRootVetoed(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Check if a strategy hooks root is currently vetoed
 @param strategy Address of the strategy to check
 @return vetoed True if the strategy hooks root is vetoed
