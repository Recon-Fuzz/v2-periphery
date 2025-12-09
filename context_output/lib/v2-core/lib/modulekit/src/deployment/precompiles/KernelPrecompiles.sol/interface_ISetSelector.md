# Interface: ISetSelector

## Metadata

- **Name**: ISetSelector
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/deployment/precompiles/KernelPrecompiles.sol

## Implements Interfaces

- **IKernel** [lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernel.sol/interface_IKernel.md]
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

### setSelector(ValidationId,bytes4,bool)

- **Signature**: `setSelector(ValidationId,bytes4,bool)`
- **Visibility**: external
- **Source Range**: 477:79:183

**Signature:**
```solidity
function setSelector(ValidationId vId, bytes4 selector, bool allowed) external;;
```

### validateUserOp(struct PackedUserOperation,bytes32,uint256) (inherited from IAccount)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 2624:221:157

**Signature:**
```solidity
///  Validate user's signature and nonce
///  the entryPoint will make the call to the recipient only if this validation call returns
///  successfully.
///  signature failure should be reported by returning SIG_VALIDATION_FAILED (1).
///  This allows making a "simulation call" without a valid signature
///  Other failures (e.g. nonce mismatch, or invalid signature format) should still revert to
///  signal failure.
///  @dev Must validate caller is the entryPoint.
///       Must validate the signature and nonce
///  @param userOp              - The operation that is about to be executed.
///  @param userOpHash          - Hash of the user's request data. can be used as the basis for
///  signature.
///  @param missingAccountFunds - Missing funds on the account's deposit in the entrypoint.
///                               This is the minimum amount to transfer to the sender(entryPoint)
///  to be
///                               able to make the call. The excess is left as a deposit in the
///  entrypoint
///                               for future calls. Can be withdrawn anytime using
///  "entryPoint.withdrawTo()".
///                               In case there is a paymaster in the request (or the current
///  deposit is high
///                               enough), this value will be zero.
///  @return validationData       - Packaged ValidationData structure. use `_packValidationData`
///  and
///                               `_unpackValidationData` to encode and decode.
///                               <20-byte> sigAuthorizer - 0 for valid signature, 1 to mark
///  signature failure,
///                                  otherwise, an address of an "authorizer" contract.
///                               <6-byte> validUntil - Last timestamp this operation is valid. 0
///  for "indefinite"
///                               <6-byte> validAfter - First timestamp this operation is valid
///                                                     If an account doesn't use time-range, it
///  is enough to
///                                                     return SIG_VALIDATION_FAILED value (1) for
///  signature failure.
///                               Note that the validation code cannot use block.timestamp (or
///  block.number) directly.
function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) external payable returns (ValidationData validationData);;
```

### executeUserOp(struct PackedUserOperation,bytes32) (inherited from IAccountExecute)

- **Signature**: `executeUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 695:135:158

**Signature:**
```solidity
///  Account may implement this execute method.
///  passing this methodSig at the beginning of callData will cause the entryPoint to pass the
///  full UserOp (and hash)
///  to the account.
///  The account should skip the methodSig, and use the callData (and optionally, other UserOp
///  fields)
///  @param userOp              - The operation that was just validated.
///  @param userOpHash          - Hash of the user's request data.
function executeUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external payable;;
```

### execute(ExecMode,bytes) (inherited from IERC7579Account)

- **Signature**: `execute(ExecMode,bytes)`
- **Visibility**: external
- **Source Range**: 1087:83:159

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the account.
///          This function is intended to be called by ERC-4337 EntryPoint.sol
///  @dev Ensure adequate authorization control: i.e. onlyEntryPointOrSelf
///  @dev MSA MUST implement this function signature.
///  If a mode is requested that is not supported by the Account, it MUST revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function execute(ExecMode mode, bytes calldata executionCalldata) external payable;;
```

### executeFromExecutor(ExecMode,bytes) (inherited from IERC7579Account)

- **Signature**: `executeFromExecutor(ExecMode,bytes)`
- **Visibility**: external
- **Source Range**: 1706:177:159

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the account.
///          This function is intended to be called by Executor Modules
///  @dev Ensure adequate authorization control: i.e. onlyExecutorModule
///  @dev MSA MUST implement this function signature.
///  If a mode is requested that is not supported by the Account, it MUST revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function executeFromExecutor(ExecMode mode, bytes calldata executionCalldata) external payable returns (bytes[] memory returnData);;
```

### isValidSignature(bytes32,bytes) (inherited from IERC7579Account)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 2192:92:159

**Signature:**
```solidity
///  @dev ERC-1271 isValidSignature
///          This function is intended to be used to validate a smart account signature
///  and may forward the call to a validator module
///  @param hash The hash of the data that is signed
///  @param data The data that is signed
function isValidSignature(bytes32 hash, bytes calldata data) external view returns (bytes4);;
```

### installModule(uint256,address,bytes) (inherited from IERC7579Account)

- **Signature**: `installModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 2665:149:159

**Signature:**
```solidity
///  @dev installs a Module of a certain type on the smart account
///  @dev Implement Authorization control of your choosing
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///  @param module the module address
///  @param initData arbitrary data that may be required on the module during `onInstall`
///  initialization.
function installModule(uint256 moduleTypeId, address module, bytes calldata initData) external payable;;
```

### uninstallModule(uint256,address,bytes) (inherited from IERC7579Account)

- **Signature**: `uninstallModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3204:153:159

**Signature:**
```solidity
///  @dev uninstalls a Module of a certain type on the smart account
///  @dev Implement Authorization control of your choosing
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///  @param module the module address
///  @param deInitData arbitrary data that may be required on the module during `onUninstall`
///  de-initialization.
function uninstallModule(uint256 moduleTypeId, address module, bytes calldata deInitData) external payable;;
```

### supportsExecutionMode(ExecMode) (inherited from IERC7579Account)

- **Signature**: `supportsExecutionMode(ExecMode)`
- **Visibility**: external
- **Source Range**: 3520:82:159

**Signature:**
```solidity
///  Function to check if the account supports a certain CallType or ExecType (see ModeLib.sol)
///  @param encodedMode the encoded mode
function supportsExecutionMode(ExecMode encodedMode) external view returns (bool);;
```

### supportsModule(uint256) (inherited from IERC7579Account)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 3788:75:159

**Signature:**
```solidity
///  Function to check if the account supports installation of a certain module type Id
///  @param moduleTypeId the module type ID according the ERC-7579 spec
function supportsModule(uint256 moduleTypeId) external view returns (bool);;
```

### isModuleInstalled(uint256,address,bytes) (inherited from IERC7579Account)

- **Signature**: `isModuleInstalled(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 4605:182:159

**Signature:**
```solidity
///  Function to check if the account has a certain module installed
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///       Note: keep in mind that some contracts can be multiple module types at the same time. It
///             thus may be necessary to query multiple module types
///  @param module the module address
///  @param additionalContext additional context data that the smart account may interpret to
///                           identify conditions under which the module is installed.
///                           usually this is not necessary, but for some special hooks that
///                           are stored in mappings, this param might be needed
function isModuleInstalled(uint256 moduleTypeId, address module, bytes calldata additionalContext) external view returns (bool);;
```

### accountId() (inherited from IERC7579Account)

- **Signature**: `accountId()`
- **Visibility**: external
- **Source Range**: 5037:83:159

**Signature:**
```solidity
///  @dev Returns the account id of the smart account
///  @return accountImplementationId the account id of the smart account
///  the accountId should be structured like so:
///         "vendorname.accountname.semver"
function accountId() external view returns (string memory accountImplementationId);;
```

### initialize(ValidationId,contract IHook,bytes,bytes,bytes[]) (inherited from IKernel)

- **Signature**: `initialize(ValidationId,contract IHook,bytes,bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 614:208:161

**Signature:**
```solidity
function initialize(ValidationId _rootValidator, IHook hook, bytes calldata validatorData, bytes calldata hookData, bytes[] calldata initConfig) external;;
```

### upgradeTo(address) (inherited from IKernel)

- **Signature**: `upgradeTo(address)`
- **Visibility**: external
- **Source Range**: 828:64:161

**Signature:**
```solidity
function upgradeTo(address _newImplementation) external payable;;
```

### onERC721Received(address,address,uint256,bytes) (inherited from IKernel)

- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 898:162:161

**Signature:**
```solidity
function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4);;
```

### onERC1155Received(address,address,uint256,uint256,bytes) (inherited from IKernel)

- **Signature**: `onERC1155Received(address,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1066:180:161

**Signature:**
```solidity
function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4);;
```

### onERC1155BatchReceived(address,address,uint256[],uint256[],bytes) (inherited from IKernel)

- **Signature**: `onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)`
- **Visibility**: external
- **Source Range**: 1252:207:161

**Signature:**
```solidity
function onERC1155BatchReceived(address, address, uint256[] calldata, uint256[] calldata, bytes calldata) external pure returns (bytes4);;
```

### installValidations(ValidationId[],struct ValidationConfig[],bytes[],bytes[]) (inherited from IKernel)

- **Signature**: `installValidations(ValidationId[],struct ValidationConfig[],bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 2463:224:161

**Signature:**
```solidity
function installValidations(ValidationId[] calldata vIds, ValidationConfig[] memory configs, bytes[] calldata validationData, bytes[] calldata hookData) external payable;;
```

### uninstallValidation(ValidationId,bytes,bytes) (inherited from IKernel)

- **Signature**: `uninstallValidation(ValidationId,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 2693:168:161

**Signature:**
```solidity
function uninstallValidation(ValidationId vId, bytes calldata deinitData, bytes calldata hookDeinitData) external payable;;
```

### invalidateNonce(uint32) (inherited from IKernel)

- **Signature**: `invalidateNonce(uint32)`
- **Visibility**: external
- **Source Range**: 2867:56:161

**Signature:**
```solidity
function invalidateNonce(uint32 nonce) external payable;;
```

### isAllowedSelector(ValidationId,bytes4) (inherited from IKernel)

- **Signature**: `isAllowedSelector(ValidationId,bytes4)`
- **Visibility**: external
- **Source Range**: 3523:91:161

**Signature:**
```solidity
function isAllowedSelector(ValidationId vId, bytes4 selector) external view returns (bool);;
```

### _toWrappedHash(bytes32) (inherited from IKernel)

- **Signature**: `_toWrappedHash(bytes32)`
- **Visibility**: external
- **Source Range**: 3620:70:161

**Signature:**
```solidity
function _toWrappedHash(bytes32 hash) external view returns (bytes32);;
```

### validationConfig(ValidationId) (inherited from IKernel)

- **Signature**: `validationConfig(ValidationId)`
- **Visibility**: external
- **Source Range**: 3696:92:161

**Signature:**
```solidity
function validationConfig(ValidationId vId) external view returns (ValidationConfig memory);;
```
