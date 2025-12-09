# Interface: ISigner

## Metadata

- **Name**: ISigner
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

## Public/External Functions

### checkUserOpSignature(bytes32,struct PackedUserOperation,bytes32)

- **Signature**: `checkUserOpSignature(bytes32,struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 3772:188:149

**Signature:**
```solidity
function checkUserOpSignature(bytes32 id, PackedUserOperation calldata userOp, bytes32 userOpHash) external payable returns (uint256);;
```

### checkSignature(bytes32,address,bytes32,bytes)

- **Signature**: `checkSignature(bytes32,address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 3965:179:149

**Signature:**
```solidity
function checkSignature(bytes32 id, address sender, bytes32 hash, bytes calldata sig) external view returns (bytes4);;
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
