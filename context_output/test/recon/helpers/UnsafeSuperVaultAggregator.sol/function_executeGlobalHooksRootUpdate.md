# Function: executeGlobalHooksRootUpdate()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `executeGlobalHooksRootUpdate()`
- **Visibility**: external
- **Source Range**: 32263:706:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function executeGlobalHooksRootUpdate() external {
    bytes32 proposedRoot = _proposedGlobalHooksRoot;
    if (proposedRoot == bytes32(0)) {
        revert NO_PENDING_GLOBAL_ROOT_CHANGE();
    }
    if (block.timestamp < _globalHooksRootEffectiveTime) {
        revert ROOT_UPDATE_NOT_READY();
    }
    bytes32 oldRoot = _globalHooksRoot;
    _globalHooksRoot = proposedRoot;
    _globalHooksRootEffectiveTime = 0;
    _proposedGlobalHooksRoot = bytes32(0);
    emit GlobalHooksRootUpdated(oldRoot, proposedRoot);
}
```

## State Variable Reads

- **_proposedGlobalHooksRoot** (`bytes32`)
- **_globalHooksRootEffectiveTime** (`uint256`)
- **_globalHooksRoot** (`bytes32`)

## State Variable Writes

- **_globalHooksRoot** (`bytes32`)
- **_globalHooksRootEffectiveTime** (`uint256`)
- **_proposedGlobalHooksRoot** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.executeGlobalHooksRootUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Executes a previously proposed global hooks root update after timelock period
 @dev Can be called by anyone after the timelock period has elapsed
