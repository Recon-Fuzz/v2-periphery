# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 3494:243:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function onUninstall(bytes calldata) external {
    if (!_initialized[msg.sender]) revert NOT_INITIALIZED();
    _initialized[msg.sender] = false;
    delete _accountOwners[msg.sender];
    emit AccountUnset(msg.sender);
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## State Variable Writes

- **_initialized** (`mapping(address => bool)`)
- **_accountOwners** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
