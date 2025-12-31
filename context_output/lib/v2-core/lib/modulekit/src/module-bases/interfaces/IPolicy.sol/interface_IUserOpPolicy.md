# Interface: IUserOpPolicy

## Metadata

- **Name**: IUserOpPolicy
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/IPolicy.sol
- **Documentation**:  IUserOpPolicy is a policy that enforces restrictions on user operations. It is called during the
   validation phase
   of the ERC4337 execution.
   Use this policy to enforce restrictions on user operations (userOp.gas, Time based restrictions).
   The checkUserOpPolicy function should return a uint256 value that represents the policy's
   decision.
   The policy's decision should be one of the following:
   - VALIDATION_SUCCESS: The user operation is allowed.
   - VALIDATION_FAILED: The user operation is not allowed.

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

### checkUserOpPolicy(ConfigId,struct PackedUserOperation)

- **Signature**: `checkUserOpPolicy(ConfigId,struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 2181:142:217

**Signature:**
```solidity
function checkUserOpPolicy(ConfigId id, PackedUserOperation calldata userOp) external returns (uint256);;
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
