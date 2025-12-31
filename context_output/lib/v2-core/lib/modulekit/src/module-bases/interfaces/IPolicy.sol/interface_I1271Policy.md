# Interface: I1271Policy

## Metadata

- **Name**: I1271Policy
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/IPolicy.sol
- **Documentation**:  I1271Policy is a policy that enforces restrictions on 1271 signed actions. It is called during an
   ERC1271 signature
   validation

## Implements Interfaces

- **IPolicy** [lib/v2-core/lib/modulekit/src/module-bases/interfaces/IPolicy.sol/interface_IPolicy.md]
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

### check1271SignedAction(ConfigId,address,address,bytes32,bytes)

- **Signature**: `check1271SignedAction(ConfigId,address,address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 3598:223:217

**Signature:**
```solidity
function check1271SignedAction(ConfigId id, address requestSender, address account, bytes32 hash, bytes calldata signature) external view returns (bool);;
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

### isInitialized(address,ConfigId) (inherited from IPolicy)

- **Signature**: `isInitialized(address,ConfigId)`
- **Visibility**: external
- **Source Range**: 1012:88:217

**Signature:**
```solidity
function isInitialized(address account, ConfigId configId) external view returns (bool);;
```

### isInitialized(address,address,ConfigId) (inherited from IPolicy)

- **Signature**: `isInitialized(address,address,ConfigId)`
- **Visibility**: external
- **Source Range**: 1105:163:217

**Signature:**
```solidity
function isInitialized(address account, address mulitplexer, ConfigId configId) external view returns (bool);;
```

### initializeWithMultiplexer(address,ConfigId,bytes) (inherited from IPolicy)

- **Signature**: `initializeWithMultiplexer(address,ConfigId,bytes)`
- **Visibility**: external
- **Source Range**: 1457:143:217

**Signature:**
```solidity
///  This function may be called by the multiplexer (SmartSessions) without deinitializing first.
///  Policies MUST overwrite the current state when this happens
function initializeWithMultiplexer(address account, ConfigId configId, bytes calldata initData) external;;
```
