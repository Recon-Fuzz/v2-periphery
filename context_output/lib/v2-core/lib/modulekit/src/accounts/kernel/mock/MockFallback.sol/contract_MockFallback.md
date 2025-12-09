# Contract: MockFallback

## Metadata

- **Name**: MockFallback
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol

## Implements Interfaces

- **IFallback** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Module.sol/interface_IFallback.md]
- **IModule** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Module.sol/interface_IModule.md]

## State Variables

### data

```solidity
mapping(address => bytes) public data
```

### valueStored

```solidity
uint256 public valueStored
```

### isExecutor

```solidity
bool public isExecutor
```

### callee

```solidity
Callee public callee
```

**Callee**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_Callee.md]

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

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 721:52:165
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor();
```

### setExecutorMode(bool)

- **Signature**: `setExecutorMode(bool)`
- **Visibility**: external
- **Source Range**: 779:101:165
- **Details**: [function_setExecutorMode_bool.md](./function_setExecutorMode_bool.md)

**Signature:**
```solidity
function setExecutorMode(bool _isExecutor) external payable;
```

### onInstall(bytes)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 886:108:165
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata _data) override external payable;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 1000:103:165
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata) override external payable;
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1109:160:165
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 moduleTypeId) override external view returns (bool);
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1275:136:165
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address smartAccount) override external view returns (bool);
```

### fallbackFunction(uint256)

- **Signature**: `fallbackFunction(uint256)`
- **Visibility**: external
- **Source Range**: 1417:98:165
- **Details**: [function_fallbackFunction_uint256.md](./function_fallbackFunction_uint256.md)

**Signature:**
```solidity
function fallbackFunction(uint256 v) external pure returns (uint256);
```

### getData()

- **Signature**: `getData()`
- **Visibility**: external
- **Source Range**: 1521:96:165
- **Details**: [function_getData.md](./function_getData.md)

**Signature:**
```solidity
function getData() external view returns (bytes memory);
```

### getCaller()

- **Signature**: `getCaller()`
- **Visibility**: external
- **Source Range**: 1623:126:165
- **Details**: [function_getCaller.md](./function_getCaller.md)

**Signature:**
```solidity
function getCaller() external pure returns (address);
```

### setData(uint256)

- **Signature**: `setData(uint256)`
- **Visibility**: external
- **Source Range**: 1755:382:165
- **Details**: [function_setData_uint256.md](./function_setData_uint256.md)

**Signature:**
```solidity
function setData(uint256 value) external;
```
