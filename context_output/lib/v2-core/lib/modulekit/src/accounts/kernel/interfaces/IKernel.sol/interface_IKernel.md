# Interface: IKernel

## Metadata

- **Name**: IKernel
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernel.sol

## Implements Interfaces

- **IERC7579Account** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]
- **IAccountExecute** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IAccountExecute.sol/interface_IAccountExecute.md]
- **IAccount** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IAccount.sol/interface_IAccount.md]

## Events

### ModuleInstalled (inherited from IERC7579Account)

```solidity
event ModuleInstalled(uint256 moduleTypeId, address module);
```

### ModuleUninstalled (inherited from IERC7579Account)

```solidity
event ModuleUninstalled(uint256 moduleTypeId, address module);
```

## Public/External Functions

### initialize(ValidationId,contract IHook,bytes,bytes,bytes[])

- **Signature**: `initialize(ValidationId,contract IHook,bytes,bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 614:208:161

**Signature:**
```solidity
function initialize(ValidationId _rootValidator, IHook hook, bytes calldata validatorData, bytes calldata hookData, bytes[] calldata initConfig) external;;
```

### upgradeTo(address)

- **Signature**: `upgradeTo(address)`
- **Visibility**: external
- **Source Range**: 828:64:161

**Signature:**
```solidity
function upgradeTo(address _newImplementation) external payable;;
```

### onERC721Received(address,address,uint256,bytes)

- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 898:162:161

**Signature:**
```solidity
function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4);;
```

### onERC1155Received(address,address,uint256,uint256,bytes)

- **Signature**: `onERC1155Received(address,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1066:180:161

**Signature:**
```solidity
function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4);;
```

### onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)

- **Signature**: `onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)`
- **Visibility**: external
- **Source Range**: 1252:207:161

**Signature:**
```solidity
function onERC1155BatchReceived(address, address, uint256[] calldata, uint256[] calldata, bytes calldata) external pure returns (bytes4);;
```

### validateUserOp(struct PackedUserOperation,bytes32,uint256)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 1488:221:161

**Signature:**
```solidity
function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) external payable returns (ValidationData validationData);;
```

### executeUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `executeUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 1740:135:161

**Signature:**
```solidity
function executeUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external payable;;
```

### executeFromExecutor(ExecMode,bytes)

- **Signature**: `executeFromExecutor(ExecMode,bytes)`
- **Visibility**: external
- **Source Range**: 1881:181:161

**Signature:**
```solidity
function executeFromExecutor(ExecMode execMode, bytes calldata executionCalldata) external payable returns (bytes[] memory returnData);;
```

### execute(ExecMode,bytes)

- **Signature**: `execute(ExecMode,bytes)`
- **Visibility**: external
- **Source Range**: 2068:87:161

**Signature:**
```solidity
function execute(ExecMode execMode, bytes calldata executionCalldata) external payable;;
```

### isValidSignature(bytes32,bytes)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 2161:143:161

**Signature:**
```solidity
function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4);;
```

### installModule(uint256,address,bytes)

- **Signature**: `installModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 2310:147:161

**Signature:**
```solidity
function installModule(uint256 moduleType, address module, bytes calldata initData) external payable;;
```

### installValidations(ValidationId[],struct ValidationConfig[],bytes[],bytes[])

- **Signature**: `installValidations(ValidationId[],struct ValidationConfig[],bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 2463:224:161

**Signature:**
```solidity
function installValidations(ValidationId[] calldata vIds, ValidationConfig[] memory configs, bytes[] calldata validationData, bytes[] calldata hookData) external payable;;
```

### uninstallValidation(ValidationId,bytes,bytes)

- **Signature**: `uninstallValidation(ValidationId,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 2693:168:161

**Signature:**
```solidity
function uninstallValidation(ValidationId vId, bytes calldata deinitData, bytes calldata hookDeinitData) external payable;;
```

### invalidateNonce(uint32)

- **Signature**: `invalidateNonce(uint32)`
- **Visibility**: external
- **Source Range**: 2867:56:161

**Signature:**
```solidity
function invalidateNonce(uint32 nonce) external payable;;
```

### uninstallModule(uint256,address,bytes)

- **Signature**: `uninstallModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 2929:151:161

**Signature:**
```solidity
function uninstallModule(uint256 moduleType, address module, bytes calldata deInitData) external payable;;
```

### supportsModule(uint256)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 3086:75:161

**Signature:**
```solidity
function supportsModule(uint256 moduleTypeId) external pure returns (bool);;
```

### isModuleInstalled(uint256,address,bytes)

- **Signature**: `isModuleInstalled(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3167:180:161

**Signature:**
```solidity
function isModuleInstalled(uint256 moduleType, address module, bytes calldata additionalContext) external view returns (bool);;
```

### accountId()

- **Signature**: `accountId()`
- **Visibility**: external
- **Source Range**: 3353:83:161

**Signature:**
```solidity
function accountId() external pure returns (string memory accountImplementationId);;
```

### supportsExecutionMode(ExecMode)

- **Signature**: `supportsExecutionMode(ExecMode)`
- **Visibility**: external
- **Source Range**: 3442:75:161

**Signature:**
```solidity
function supportsExecutionMode(ExecMode mode) external pure returns (bool);;
```

### isAllowedSelector(ValidationId,bytes4)

- **Signature**: `isAllowedSelector(ValidationId,bytes4)`
- **Visibility**: external
- **Source Range**: 3523:91:161

**Signature:**
```solidity
function isAllowedSelector(ValidationId vId, bytes4 selector) external view returns (bool);;
```

### _toWrappedHash(bytes32)

- **Signature**: `_toWrappedHash(bytes32)`
- **Visibility**: external
- **Source Range**: 3620:70:161

**Signature:**
```solidity
function _toWrappedHash(bytes32 hash) external view returns (bytes32);;
```

### validationConfig(ValidationId)

- **Signature**: `validationConfig(ValidationId)`
- **Visibility**: external
- **Source Range**: 3696:92:161

**Signature:**
```solidity
function validationConfig(ValidationId vId) external view returns (ValidationConfig memory);;
```
