# Interface: IHook

## Metadata

- **Name**: IHook
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Module.sol

## Implements Interfaces

- **IModule** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Module.sol/interface_IModule.md]

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

### preCheck(address,uint256,bytes)

- **Signature**: `preCheck(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 2715:182:160

**Signature:**
```solidity
function preCheck(address msgSender, uint256 msgValue, bytes calldata msgData) external payable returns (bytes memory hookData);;
```

### postCheck(bytes)

- **Signature**: `postCheck(bytes)`
- **Visibility**: external
- **Source Range**: 2903:61:160

**Signature:**
```solidity
function postCheck(bytes calldata hookData) external payable;;
```

### onInstall(bytes) (inherited from IModule)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 595:57:160

**Signature:**
```solidity
///  @dev This function is called by the smart account during installation of the module
///  @param data arbitrary data that may be required on the module during `onInstall`
///  initialization
///  MUST revert on error (i.e. if module is already enabled)
function onInstall(bytes calldata data) external payable;;
```

### onUninstall(bytes) (inherited from IModule)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 917:59:160

**Signature:**
```solidity
///  @dev This function is called by the smart account during uninstallation of the module
///  @param data arbitrary data that may be required on the module during `onUninstall`
///  de-initialization
///  MUST revert on error
function onUninstall(bytes calldata data) external payable;;
```

### isModuleType(uint256) (inherited from IModule)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1220:73:160

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
- **Source Range**: 1401:74:160

**Signature:**
```solidity
///  @dev Returns if the module was already initialized for a provided smartaccount
function isInitialized(address smartAccount) external view returns (bool);;
```
