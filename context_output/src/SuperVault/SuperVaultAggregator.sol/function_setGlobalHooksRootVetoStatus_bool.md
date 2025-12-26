# Function: setGlobalHooksRootVetoStatus(bool)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `setGlobalHooksRootVetoStatus(bool)`
- **Visibility**: external
- **Source Range**: 34873:504:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function setGlobalHooksRootVetoStatus(bool vetoed) external {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    if (_globalHooksRootVetoed == vetoed) {
        return;
    }
    _globalHooksRootVetoed = vetoed;
    emit GlobalHooksRootVetoStatusChanged(vetoed, _globalHooksRoot);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_globalHooksRootVetoed** (`bool`)
- **_globalHooksRoot** (`bytes32`)

## State Variable Writes

- **_globalHooksRootVetoed** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.setGlobalHooksRootVetoStatus(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Set veto status for the global hooks root
 @dev Only callable by SuperGovernor
 @param vetoed Whether to veto (true) or unveto (false) the global hooks root
