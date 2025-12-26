# Function: onInstall(bytes)

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 4731:194:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function onInstall(bytes calldata) override(IModule, ISuperExecutor) external {
    if (_initialized[msg.sender]) revert ALREADY_INITIALIZED();
    _initialized[msg.sender] = true;
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## State Variable Writes

- **_initialized** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Handles module installation for an account
 @dev Called by the ERC-7579 account during module installation
      Sets up the initialization status for the calling account
 @param data Installation data (may be used by specific implementations)

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
