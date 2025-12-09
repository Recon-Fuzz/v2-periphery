# Contract: MockStatelessValidator

## Metadata

- **Name**: MockStatelessValidator
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol

## Implements Interfaces

- **IStatelessValidator** [lib/v2-core/lib/modulekit/src/module-bases/interfaces/IStatelessValidator.sol/interface_IStatelessValidator.md]
- **IModule** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IModule.md]

## State Variables

### TYPE_VALIDATOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_VALIDATOR = MODULE_TYPE_VALIDATOR
```

### TYPE_EXECUTOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_EXECUTOR = MODULE_TYPE_EXECUTOR
```

### TYPE_FALLBACK (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_FALLBACK = MODULE_TYPE_FALLBACK
```

### TYPE_HOOK (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_HOOK = MODULE_TYPE_HOOK
```

### TYPE_POLICY (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_POLICY = MODULE_TYPE_POLICY
```

### TYPE_SIGNER (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_SIGNER = MODULE_TYPE_SIGNER
```

### TYPE_STATELESS_VALIDATOR (inherited from ERC7579ModuleBase)

```solidity
uint256 internal constant TYPE_STATELESS_VALIDATOR = MODULE_TYPE_STATELESS_VALIDATOR
```

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

### onInstall(bytes)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 223:60:226
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata data) virtual external;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 289:62:226
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata data) virtual external;
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 357:102:226
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 typeID) external pure returns (bool);
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 465:89:226
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address) external pure returns (bool);
```

### validateSignatureWithData(bytes32,bytes,bytes)

- **Signature**: `validateSignatureWithData(bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 560:217:226
- **Details**: [function_validateSignatureWithData_bytes32_bytes_bytes.md](./function_validateSignatureWithData_bytes32_bytes_bytes.md)

**Signature:**
```solidity
function validateSignatureWithData(bytes32, bytes calldata, bytes calldata) override external pure returns (bool validSig);
```
