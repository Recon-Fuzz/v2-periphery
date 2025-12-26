# Function: isGlobalHooksRootVetoed()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `isGlobalHooksRootVetoed()`
- **Visibility**: external
- **Source Range**: 41273:117:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function isGlobalHooksRootVetoed() external view returns (bool vetoed) {
    return _globalHooksRootVetoed;
}
```

## State Variable Reads

- **_globalHooksRootVetoed** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.isGlobalHooksRootVetoed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Check if the global hooks root is currently vetoed
 @return vetoed True if the global hooks root is vetoed
