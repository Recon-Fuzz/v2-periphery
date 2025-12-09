# Interface: IModule

## Metadata

- **Name**: IModule
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol

## Errors

### ModuleAlreadyInitialized

```solidity
error ModuleAlreadyInitialized(address smartAccount);
```

### NotInitialized

```solidity
error NotInitialized(address smartAccount);
```

## Public/External Functions

### onInstall(bytes)

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

### onUninstall(bytes)

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

### isModuleType(uint256)

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

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1779:74:149

**Signature:**
```solidity
///  @dev Returns if the module was already initialized for a provided smartaccount
function isInitialized(address smartAccount) external view returns (bool);;
```
