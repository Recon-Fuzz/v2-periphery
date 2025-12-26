# Interface: IERC7579Account

## Metadata

- **Name**: IERC7579Account
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IERC7579Account.sol

## Events

### ModuleInstalled

```solidity
event ModuleInstalled(uint256 moduleTypeId, address module);
```

### ModuleUninstalled

```solidity
event ModuleUninstalled(uint256 moduleTypeId, address module);
```

## Public/External Functions

### execute(ExecMode,bytes)

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

### executeFromExecutor(ExecMode,bytes)

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

### isValidSignature(bytes32,bytes)

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

### installModule(uint256,address,bytes)

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

### uninstallModule(uint256,address,bytes)

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

### supportsExecutionMode(ExecMode)

- **Signature**: `supportsExecutionMode(ExecMode)`
- **Visibility**: external
- **Source Range**: 3520:82:159

**Signature:**
```solidity
///  Function to check if the account supports a certain CallType or ExecType (see ModeLib.sol)
///  @param encodedMode the encoded mode
function supportsExecutionMode(ExecMode encodedMode) external view returns (bool);;
```

### supportsModule(uint256)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 3788:75:159

**Signature:**
```solidity
///  Function to check if the account supports installation of a certain module type Id
///  @param moduleTypeId the module type ID according the ERC-7579 spec
function supportsModule(uint256 moduleTypeId) external view returns (bool);;
```

### isModuleInstalled(uint256,address,bytes)

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

### accountId()

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
