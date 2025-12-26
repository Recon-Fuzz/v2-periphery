# Function: onInstall(bytes)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 3120:368:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function onInstall(bytes calldata data) external {
    if (_initialized[msg.sender]) revert ALREADY_INITIALIZED();
    address owner = abi.decode(data, (address));
    if (owner == address(0)) revert ZERO_ADDRESS();
    _initialized[msg.sender] = true;
    _accountOwners[msg.sender] = owner;
    emit AccountOwnerSet(msg.sender, owner);
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## State Variable Writes

- **_initialized** (`mapping(address => bool)`)
- **_accountOwners** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
