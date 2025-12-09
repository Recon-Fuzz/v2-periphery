# Function: isGlobalHooksRootVetoed()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `isGlobalHooksRootVetoed()`
- **Visibility**: external
- **Source Range**: 39844:117:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.isGlobalHooksRootVetoed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Check if the global hooks root is currently vetoed
 @return vetoed True if the global hooks root is vetoed
