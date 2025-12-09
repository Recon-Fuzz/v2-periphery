# Interface: IMSA

## Metadata

- **Name**: IMSA
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/erc7579/interfaces/IMSA.sol

## Implements Interfaces

- **IERC4337Account** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC4337Account.sol/interface_IERC4337Account.md]
- **IERC7579Account** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]

## Errors

### UnsupportedModuleType

```solidity
error UnsupportedModuleType(uint256 moduleTypeId);
```

### UnsupportedCallType

```solidity
error UnsupportedCallType(CallType callType);
```

### UnsupportedExecType

```solidity
error UnsupportedExecType(ExecType execType);
```

### AccountInitializationFailed

```solidity
error AccountInitializationFailed();
```

### MismatchModuleTypeId

```solidity
error MismatchModuleTypeId(uint256 moduleTypeId);
```

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

### initializeAccount(bytes)

- **Signature**: `initializeAccount(bytes)`
- **Visibility**: external
- **Source Range**: 1176:65:153

**Signature:**
```solidity
///  @dev Initializes the account. Function might be called directly, or by a Factory
///  @param data. encoded data that can be used during the initialization phase
function initializeAccount(bytes calldata data) external payable;;
```

### execute(ModeCode,bytes) (inherited from IERC7579Account)

- **Signature**: `execute(ModeCode,bytes)`
- **Visibility**: external
- **Source Range**: 979:83:148

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the account.
///          This function is intended to be called by ERC-4337 EntryPoint.sol
///  @dev Ensure adequate authorization control: i.e. onlyEntryPointOrSelf
///  @dev MSA MUST implement this function signature.
///  If a mode is requested that is not supported by the Account, it MUST revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function execute(ModeCode mode, bytes calldata executionCalldata) external payable;;
```

### executeFromExecutor(ModeCode,bytes) (inherited from IERC7579Account)

- **Signature**: `executeFromExecutor(ModeCode,bytes)`
- **Visibility**: external
- **Source Range**: 1598:177:148

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the account.
///          This function is intended to be called by Executor Modules
///  @dev Ensure adequate authorization control: i.e. onlyExecutorModule
///  @dev MSA MUST implement this function signature.
///  If a mode is requested that is not supported by the Account, it MUST revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function executeFromExecutor(ModeCode mode, bytes calldata executionCalldata) external payable returns (bytes[] memory returnData);;
```

### isValidSignature(bytes32,bytes) (inherited from IERC7579Account)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 2084:92:148

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
- **Source Range**: 2556:149:148

**Signature:**
```solidity
///  @dev installs a Module of a certain type on the smart account
///  @dev Implement Authorization control of your chosing
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///  @param module the module address
///  @param initData arbitrary data that may be required on the module during `onInstall`
///  initialization.
function installModule(uint256 moduleTypeId, address module, bytes calldata initData) external payable;;
```

### uninstallModule(uint256,address,bytes) (inherited from IERC7579Account)

- **Signature**: `uninstallModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3094:153:148

**Signature:**
```solidity
///  @dev uninstalls a Module of a certain type on the smart account
///  @dev Implement Authorization control of your chosing
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///  @param module the module address
///  @param deInitData arbitrary data that may be required on the module during `onUninstall`
///  de-initialization.
function uninstallModule(uint256 moduleTypeId, address module, bytes calldata deInitData) external payable;;
```

### supportsExecutionMode(ModeCode) (inherited from IERC7579Account)

- **Signature**: `supportsExecutionMode(ModeCode)`
- **Visibility**: external
- **Source Range**: 3410:82:148

**Signature:**
```solidity
///  Function to check if the account supports a certain CallType or ExecType (see ModeLib.sol)
///  @param encodedMode the encoded mode
function supportsExecutionMode(ModeCode encodedMode) external view returns (bool);;
```

### supportsModule(uint256) (inherited from IERC7579Account)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 3678:75:148

**Signature:**
```solidity
///  Function to check if the account supports installation of a certain module type Id
///  @param moduleTypeId the module type ID according the ERC-7579 spec
function supportsModule(uint256 moduleTypeId) external view returns (bool);;
```

### isModuleInstalled(uint256,address,bytes) (inherited from IERC7579Account)

- **Signature**: `isModuleInstalled(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 4496:182:148

**Signature:**
```solidity
///  Function to check if the account has a certain module installed
///  @param moduleTypeId the module type ID according the ERC-7579 spec
///       Note: keep in mind that some contracts can be multiple module types at the same time. It
///             thus may be necessary to query multiple module types
///  @param module the module address
///  @param additionalContext additional context data that the smart account may interpret to
///                           identifiy conditions under which the module is installed.
///                           usually this is not necessary, but for some special hooks that
///                           are stored in mappings, this param might be needed
function isModuleInstalled(uint256 moduleTypeId, address module, bytes calldata additionalContext) external view returns (bool);;
```

### accountId() (inherited from IERC7579Account)

- **Signature**: `accountId()`
- **Visibility**: external
- **Source Range**: 4928:83:148

**Signature:**
```solidity
///  @dev Returns the account id of the smart account
///  @return accountImplementationId the account id of the smart account
///  the accountId should be structured like so:
///         "vendorname.accountname.semver"
function accountId() external view returns (string memory accountImplementationId);;
```

### validateUserOp(struct PackedUserOperation,bytes32,uint256) (inherited from IERC4337Account)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 2602:214:147

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
function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) external payable returns (uint256 validationData);;
```

### executeUserOp(struct PackedUserOperation,bytes32) (inherited from IERC4337Account)

- **Signature**: `executeUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 3301:135:147

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
