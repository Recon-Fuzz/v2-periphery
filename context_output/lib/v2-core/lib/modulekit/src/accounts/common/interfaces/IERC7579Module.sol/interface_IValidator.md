# Interface: IValidator

## Metadata

- **Name**: IValidator
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol

## Implements Interfaces

- **IModule** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IModule.md]

## Errors

### ModuleAlreadyInitialized (inherited from IModule)

```solidity
error ModuleAlreadyInitialized(address smartAccount);
```

### NotInitialized (inherited from IModule)

```solidity
error NotInitialized(address smartAccount);
```

### InvalidTargetAddress

```solidity
error InvalidTargetAddress(address target);
```

## Public/External Functions

### validateUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 2603:162:149

**Signature:**
```solidity
///  @dev Validates a transaction on behalf of the account.
///          This function is intended to be called by the MSA during the ERC-4337 validaton phase
///          Note: solely relying on bytes32 hash and signature is not sufficient for some
///  validation implementations (i.e. SessionKeys often need access to userOp.calldata)
///  @param userOp The user operation to be validated. The userOp MUST NOT contain any metadata.
///  The MSA MUST clean up the userOp before sending it to the validator.
///  @param userOpHash The hash of the user operation to be validated
///  @return return value according to ERC-4337
function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external payable returns (uint256);;
```

### isValidSignatureWithSender(address,bytes32,bytes)

- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 2840:172:149

**Signature:**
```solidity
///  Validator can be used for ERC-1271 validation
function isValidSignatureWithSender(address sender, bytes32 hash, bytes calldata data) external view returns (bytes4);;
```

### onInstall(bytes) (inherited from IModule)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 989:49:149

**Signature:**
```solidity
///  @dev This function is called by the smart account during installation of the module
///  @param data arbitrary data that may be required on the module during `onInstall`
///  initialization
///  MUST revert on error (i.e. if module is already enabled)
function onInstall(bytes calldata data) external;;
```

### onUninstall(bytes) (inherited from IModule)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 1303:51:149

**Signature:**
```solidity
///  @dev This function is called by the smart account during uninstallation of the module
///  @param data arbitrary data that may be required on the module during `onUninstall`
///  de-initialization
///  MUST revert on error
function onUninstall(bytes calldata data) external;;
```

### isModuleType(uint256) (inherited from IModule)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1598:73:149

**Signature:**
```solidity
///  @dev Returns boolean value if module is a certain type
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///  MUST return true if the module is of the given type and false otherwise
function isModuleType(uint256 moduleTypeId) external view returns (bool);;
```

### isInitialized(address) (inherited from IModule)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1779:74:149

**Signature:**
```solidity
///  @dev Returns if the module was already initialized for a provided smartaccount
function isInitialized(address smartAccount) external view returns (bool);;
```
