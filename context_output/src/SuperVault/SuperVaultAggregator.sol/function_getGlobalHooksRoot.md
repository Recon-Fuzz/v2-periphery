# Function: getGlobalHooksRoot()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 49986:107:511

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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getGlobalHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the current global hooks Merkle root
 @return root The current global hooks Merkle root
