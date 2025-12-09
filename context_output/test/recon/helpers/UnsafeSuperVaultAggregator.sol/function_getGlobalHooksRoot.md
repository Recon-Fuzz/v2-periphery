# Function: getGlobalHooksRoot()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 46520:107:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getGlobalHooksRoot() external view returns (bytes32 root) {
    return _globalHooksRoot;
}
```

## State Variable Reads

- **_globalHooksRoot** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getGlobalHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the current global hooks Merkle root
 @return root The current global hooks Merkle root
