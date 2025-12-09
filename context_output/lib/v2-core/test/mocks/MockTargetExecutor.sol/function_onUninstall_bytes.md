# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 3016:194:487

## Implementation

```solidity
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
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Handles module uninstallation for an account
 @dev Called by the ERC-7579 account during module removal
      Clears the initialization status for the calling account
 @param data Uninstallation data (may be used by specific implementations)

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
