# Contract: MockValidator

## Metadata

- **Name**: MockValidator
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol

## Implements Interfaces

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

### VALIDATION_SUCCESS (inherited from ERC7579ValidatorBase)

```solidity
ValidationData internal constant VALIDATION_SUCCESS = ValidationData.wrap(0)
```

### VALIDATION_FAILED (inherited from ERC7579ValidatorBase)

```solidity
ValidationData internal constant VALIDATION_FAILED = ValidationData.wrap(1)
```

### EIP1271_SUCCESS (inherited from ERC7579ValidatorBase)

```solidity
bytes4 internal constant EIP1271_SUCCESS = 0x1626ba7e
```

### EIP1271_FAILED (inherited from ERC7579ValidatorBase)

```solidity
bytes4 internal constant EIP1271_FAILED = 0xFFFFFFFF
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
- **Source Range**: 290:69:228
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata data) virtual override external;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 365:71:228
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata data) virtual override external;
```

### validateUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 442:318:228
- **Details**: [function_validateUserOp_struct_PackedUserOperation_bytes32.md](./function_validateUserOp_struct_PackedUserOperation_bytes32.md)

**Signature:**
```solidity
function validateUserOp(PackedUserOperation calldata, bytes32) virtual override external returns (ValidationData);
```

### isValidSignatureWithSender(address,bytes32,bytes)

- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 766:257:228
- **Details**: [function_isValidSignatureWithSender_address_bytes32_bytes.md](./function_isValidSignatureWithSender_address_bytes32_bytes.md)

**Signature:**
```solidity
function isValidSignatureWithSender(address, bytes32, bytes calldata) virtual override external view returns (bytes4);
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1029:124:228
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 typeID) override external pure returns (bool);
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1159:148:228
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address) external pure returns (bool);
```
