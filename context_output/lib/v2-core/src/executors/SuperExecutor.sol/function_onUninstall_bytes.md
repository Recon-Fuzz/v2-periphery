# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 4966:194:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function onUninstall(bytes calldata) override(IModule, ISuperExecutor) external {
    if (!_initialized[msg.sender]) revert NOT_INITIALIZED();
    _initialized[msg.sender] = false;
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## State Variable Writes

- **_initialized** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Handles module uninstallation for an account
 @dev Called by the ERC-7579 account during module removal
      Clears the initialization status for the calling account
 @param data Uninstallation data (may be used by specific implementations)

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
