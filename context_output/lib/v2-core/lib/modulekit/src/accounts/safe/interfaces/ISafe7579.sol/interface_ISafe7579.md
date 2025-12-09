# Interface: ISafe7579

## Metadata

- **Name**: ISafe7579
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579.sol
- **Documentation**:  @title ERC7579 Adapter for Safe accounts.
   creates full ERC7579 compliance to Safe accounts
   @author rhinestone | zeroknots.eth, Konrad Kopp (@kopy-kat)

## Implements Interfaces

- **ISafeOp** [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafeOp.sol/interface_ISafeOp.md]
- **IERC7579Account** [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/IERC7579Account.sol/interface_IERC7579Account.md]
- **IERC7579AccountView** [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/IERC7579Account.sol/interface_IERC7579AccountView.md]
- **IERC7579AccountEvents** [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/IERC7579Account.sol/interface_IERC7579AccountEvents.md]

## Structs

### EncodedSafeOpStruct (inherited from ISafeOp)

```solidity
///  @notice The EIP-712 type-hash for a SafeOp, representing the structure of a User Operation
///  for
///  the Safe.
///   {address} safe - The address of the safe on which the operation is performed.
///   {uint256} nonce - A unique number associated with the user operation, preventing replay
///  attacks
///  by ensuring each operation is unique.
///   {bytes} initCode - The packed encoding of a factory address and its factory-specific data
///  for
///  creating a new Safe account.
///   {bytes} callData - The bytes representing the data of the function call to be executed.
///   {uint128} verificationGasLimit - The maximum amount of gas allowed for the verification
///  process.
///   {uint128} callGasLimit - The maximum amount of gas allowed for executing the function call.
///   {uint256} preVerificationGas - The amount of gas allocated for pre-verification steps before
///  executing the main operation.
///   {uint128} maxPriorityFeePerGas - The maximum priority fee per gas that the user is willing
///  to
///  pay for the transaction.
///   {uint128} maxFeePerGas - The maximum fee per gas that the user is willing to pay for the
///  transaction.
///   {bytes} paymasterAndData - The packed encoding of a paymaster address and its
///  paymaster-specific
///  data for sponsoring the user operation.
///   {uint48} validAfter - A timestamp representing from when the user operation is valid.
///   {uint48} validUntil - A timestamp representing until when the user operation is valid, or 0
///  to
///  indicated "forever".
///   {address} entryPoint - The address of the entry point that will execute the user operation.
///  @dev When validating the user operation, the signature timestamps are pre-pended to the
///  signature
///  bytes. Equal to:
///  keccak256(
///      "SafeOp(address safe,uint256 nonce,bytes initCode,bytes callData,uint128
///  verificationGasLimit,uint128 callGasLimit,uint256 preVerificationGas,uint128
///  maxPriorityFeePerGas,uint128 maxFeePerGas,bytes paymasterAndData,uint48 validAfter,uint48
///  validUntil,address entryPoint)"
///  ) = 0xc03dfc11d8b10bf9cf703d558958c8c42777f785d998c62060d85a4f0ef6ea7f
struct EncodedSafeOpStruct {
    bytes32 typeHash;
    address safe;
    uint256 nonce;
    bytes32 initCodeHash;
    bytes32 callDataHash;
    uint128 verificationGasLimit;
    uint128 callGasLimit;
    uint256 preVerificationGas;
    uint128 maxPriorityFeePerGas;
    uint128 maxFeePerGas;
    bytes32 paymasterAndDataHash;
    uint48 validAfter;
    uint48 validUntil;
    address entryPoint;
}
```

## Errors

### UnsupportedModuleType (inherited from IERC7579Account)

```solidity
error UnsupportedModuleType(uint256 moduleTypeId);
```

### UnsupportedCallType (inherited from IERC7579Account)

```solidity
error UnsupportedCallType(CallType callType);
```

### UnsupportedExecType (inherited from IERC7579Account)

```solidity
error UnsupportedExecType(ExecType execType);
```

### InvalidModule

```solidity
error InvalidModule(address module);
```

### InvalidModuleType

```solidity
error InvalidModuleType(address module, uint256 moduleType);
```

### InvalidInput

```solidity
error InvalidInput();
```

### InvalidCallType

```solidity
error InvalidCallType(CallType callType);
```

### NoFallbackHandler

```solidity
error NoFallbackHandler(bytes4 msgSig);
```

### InvalidFallbackHandler

```solidity
error InvalidFallbackHandler(bytes4 msgSig);
```

### FallbackInstalled

```solidity
error FallbackInstalled(bytes4 msgSig);
```

### HookAlreadyInstalled

```solidity
error HookAlreadyInstalled(address currentHook);
```

### InvalidHookType

```solidity
error InvalidHookType();
```

## Events

### ModuleInstalled (inherited from IERC7579AccountEvents)

```solidity
event ModuleInstalled(uint256 moduleTypeId, address module);
```

### ModuleUninstalled (inherited from IERC7579AccountEvents)

```solidity
event ModuleUninstalled(uint256 moduleTypeId, address module);
```

### ERC7484RegistryConfigured

```solidity
event ERC7484RegistryConfigured(address indexed smartAccount, IERC7484 indexed registry);
```

## Public/External Functions

### validateUserOp(struct PackedUserOperation,bytes32,uint256)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 1167:196:176

**Signature:**
```solidity
///  ERC4337 v0.7 validation function
///  @dev expects that a ERC7579 validator module is encoded within the UserOp nonce.
///          if no validator module is provided, it will fallback to validate the transaction with
///          Safe's signers
function validateUserOp(PackedUserOperation memory userOp, bytes32 userOpHash, uint256 missingAccountFunds) external returns (uint256 packedValidSig);;
```

### isValidSignature(bytes32,bytes)

- **Signature**: `isValidSignature(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 1902:147:176

**Signature:**
```solidity
///  Will use Safe's signed messages or checkSignatures features or ERC7579 validation modules
///  if no signature is provided, it makes use of Safe's signedMessages
///  if address(0) or a non-installed validator module is provided, it will use Safe's
///  checkSignatures
///  if a valid validator module is provided, it will use the module's validateUserOp function
///     @param hash message hash of ERC1271 request
///     @param data abi.encodePacked(address validationModule, bytes signatures)
function isValidSignature(bytes32 hash, bytes memory data) external view returns (bytes4 magicValue);;
```

### execute(ModeCode,bytes)

- **Signature**: `execute(ModeCode,bytes)`
- **Visibility**: external
- **Source Range**: 3184:73:176

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the Safe account.
///          This function is intended to be called by ERC-4337 EntryPoint.sol
///  @dev If a global hook and/or selector hook is set, it will be called
///  @dev AccessControl: only Self of Entrypoint can install modules
///  Safe7579 supports the following feature set:
///     CallTypes:
///              - CALLTYPE_SINGLE
///              - CALLTYPE_BATCH
///              - CALLTYPE_DELEGATECALL
///     ExecTypes:
///              - EXECTYPE_DEFAULT (revert if not successful)
///              - EXECTYPE_TRY
///     If a different mode is selected, this function will revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function execute(ModeCode mode, bytes memory executionCalldata) external;;
```

### executeFromExecutor(ModeCode,bytes)

- **Signature**: `executeFromExecutor(ModeCode,bytes)`
- **Visibility**: external
- **Source Range**: 4088:160:176

**Signature:**
```solidity
///  @dev Executes a transaction on behalf of the Safe account.
///          This function is intended to be called by executor modules
///  @dev If a global hook and/or selector hook is set, it will be called
///  @dev AccessControl: only enabled executor modules
///  Safe7579 supports the following feature set:
///     CallTypes:
///              - CALLTYPE_SINGLE
///              - CALLTYPE_BATCH
///              - CALLTYPE_DELEGATECALL
///     ExecTypes:
///              - EXECTYPE_DEFAULT (revert if not successful)
///              - EXECTYPE_TRY
///     If a different mode is selected, this function will revert
///  @param mode The encoded execution mode of the transaction. See ModeLib.sol for details
///  @param executionCalldata The encoded execution call data
function executeFromExecutor(ModeCode mode, bytes memory executionCalldata) external returns (bytes[] memory returnDatas);;
```

### installModule(uint256,address,bytes)

- **Signature**: `installModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 5486:91:176

**Signature:**
```solidity
///  Installs a 7579 Module of a certain type on the smart account
///  @dev The module has to be initialized from msg.sender == SafeProxy, we thus use a
///     delegatecall to DCUtil, which calls the onInstall/onUninstall function on the ERC7579
///     module and emits the ModuleInstall/ModuleUnintall events
///  @dev AccessControl: only Self of Entrypoint can install modules
///  @dev If the safe set a registry, ERC7484 registry will be queried before installing
///  @dev If a global hook and/or selector hook is set, it will be called
///  @param moduleType the module type ID according the ERC-7579 spec
///                    Note: MULTITYPE_MODULE (uint(0)) is a special type to install a module with
///                          multiple types
///  @param module the module address
///  @param initData arbitrary data that may be required on the module during `onInstall`
///  initialization.
function installModule(uint256 moduleType, address module, bytes memory initData) external;;
```

### uninstallModule(uint256,address,bytes)

- **Signature**: `uninstallModule(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 6299:133:176

**Signature:**
```solidity
///  Uninstalls a Module of a certain type on the smart account.
///  @dev The module has to be initialized from msg.sender == SafeProxy, we thus use a
///     delegatecall to DCUtil, which calls the onInstall/onUninstall function on the ERC7579
///     module and emits the ModuleInstall/ModuleUnintall events
///  @dev AccessControl: only Self of Entrypoint can install modules
///  @dev If a global hook and/or selector hook is set, it will be called
///  @param moduleType the module type ID according the ERC-7579 spec
///  @param module the module address
///  @param deInitData arbitrary data that may be required on the module during `onUninstall`
///  de-initialization.
function uninstallModule(uint256 moduleType, address module, bytes memory deInitData) external;;
```

### isModuleInstalled(uint256,address,bytes)

- **Signature**: `isModuleInstalled(uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 7173:178:176

**Signature:**
```solidity
///  Function to check if the account has a certain module installed
///  @param moduleType the module type ID according the ERC-7579 spec
///       Note: keep in mind that some contracts can be multiple module types at the same time. It
///             thus may be necessary to query multiple module types
///  @param module the module address
///  @param additionalContext additional context data that the smart account may interpret to
///                           identifiy conditions under which the module is installed.
///                           usually this is not necessary, but for some special hooks that
///                           are stored in mappings, this param might be needed
function isModuleInstalled(uint256 moduleType, address module, bytes memory additionalContext) external view returns (bool);;
```

### initializeAccount(struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct RegistryInit)

- **Signature**: `initializeAccount(struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct RegistryInit)`
- **Visibility**: external
- **Source Range**: 8447:245:176

**Signature:**
```solidity
///  This function can be called by the Launchpad.initSafe7579() or by already existing Safes that
///  want to use Safe7579
///  if this is called by the Launchpad, it is expected that launchpadValidators() was called
///  previously, and the param validators is empty
///  @param validators validator modules and initData
///  @param executors executor modules and initData
///  @param executors executor modules and initData
///  @param fallbacks fallback modules and initData
///  @param hooks hook module and initData
///  @param registryInit (OPTIONAL) registry, attesters and threshold for IERC7484 Registry
///                     If not provided, the registry will be set to the zero address, and no
///                     registry checks will be performed
function initializeAccount(ModuleInit[] memory validators, ModuleInit[] memory executors, ModuleInit[] memory fallbacks, ModuleInit[] memory hooks, RegistryInit memory registryInit) external;;
```

### initializeAccountWithValidators(struct ModuleInit[])

- **Signature**: `initializeAccountWithValidators(struct ModuleInit[])`
- **Visibility**: external
- **Source Range**: 9165:82:176

**Signature:**
```solidity
///  This function is intended to be called by Launchpad.validateUserOp()
///  @dev it will initialize the SentinelList4337 list for validators, and sstore all
///  validators
///  @dev Since this function has to be 4337 compliant (storage access), only validator storage is  acccess
///  @dev Note: this function DOES NOT call onInstall() on the validator modules or emit
///  ModuleInstalled events. this has to be done by the launchpad
function initializeAccountWithValidators(ModuleInit[] memory validators) external;;
```

### setRegistry(contract IERC7484,address[],uint8)

- **Signature**: `setRegistry(contract IERC7484,address[],uint8)`
- **Visibility**: external
- **Source Range**: 9460:94:176

**Signature:**
```solidity
///  Configure the Safe7579 with a IERC7484 registry
///  @param registry IERC7484 registry
///  @param attesters list of attesters
///  @param threshold number of attesters required
function setRegistry(IERC7484 registry, address[] memory attesters, uint8 threshold) external;;
```

### getValidatorsPaginated(address,uint256)

- **Signature**: `getValidatorsPaginated(address,uint256)`
- **Visibility**: external
- **Source Range**: 9842:173:176

**Signature:**
```solidity
function getValidatorsPaginated(address cursor, uint256 pageSize) external view returns (address[] memory array, address next);;
```

### getActiveHook()

- **Signature**: `getActiveHook()`
- **Visibility**: external
- **Source Range**: 10079:62:176

**Signature:**
```solidity
///  Get the current active global hook
function getActiveHook() external view returns (address hook);;
```

### getActiveHook(bytes4)

- **Signature**: `getActiveHook(bytes4)`
- **Visibility**: external
- **Source Range**: 10207:77:176

**Signature:**
```solidity
///  Get the current active selector hook
function getActiveHook(bytes4 selector) external view returns (address hook);;
```

### getExecutorsPaginated(address,uint256)

- **Signature**: `getExecutorsPaginated(address,uint256)`
- **Visibility**: external
- **Source Range**: 10290:168:176

**Signature:**
```solidity
function getExecutorsPaginated(address cursor, uint256 size) external view returns (address[] memory array, address next);;
```

### getNonce(address,address)

- **Signature**: `getNonce(address,address)`
- **Visibility**: external
- **Source Range**: 11070:89:176

**Signature:**
```solidity
///  Safe7579 is using validator selection encoding in the userop nonce.
///  to make it easier for SDKs / devs to integrate, this function can be
///  called to get the next nonce for a specific validator
///  @param safe address of safe account
///  @param validator ERC7579 validator to encode
function getNonce(address safe, address validator) external view returns (uint256 nonce);;
```

### accountId() (inherited from IERC7579AccountView)

- **Signature**: `accountId()`
- **Visibility**: external
- **Source Range**: 694:83:175

**Signature:**
```solidity
///  @dev Returns the account id of the smart account
///  @return accountImplementationId the account id of the smart account
///  the accountId should be structured like so:
///         "vendorname.accountname.semver"
function accountId() external view returns (string memory accountImplementationId);;
```

### supportsExecutionMode(ModeCode) (inherited from IERC7579AccountView)

- **Signature**: `supportsExecutionMode(ModeCode)`
- **Visibility**: external
- **Source Range**: 940:82:175

**Signature:**
```solidity
///  Function to check if the account supports a certain CallType or ExecType (see ModeLib.sol)
///  @param encodedMode the encoded mode
function supportsExecutionMode(ModeCode encodedMode) external view returns (bool);;
```

### supportsModule(uint256) (inherited from IERC7579AccountView)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 1208:75:175

**Signature:**
```solidity
///  Function to check if the account supports installation of a certain module type Id
///  @param moduleTypeId the module type ID according the ERC-7579 spec
function supportsModule(uint256 moduleTypeId) external view returns (bool);;
```

### domainSeparator() (inherited from ISafeOp)

- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 3026:59:178

**Signature:**
```solidity
function domainSeparator() external view returns (bytes32);;
```

### getSafeOp(struct PackedUserOperation,address) (inherited from ISafeOp)

- **Signature**: `getSafeOp(struct PackedUserOperation,address)`
- **Visibility**: external
- **Source Range**: 3091:296:178

**Signature:**
```solidity
function getSafeOp(PackedUserOperation calldata userOp, address entryPoint) external view returns (bytes memory operationData, uint48 validAfter, uint48 validUntil, bytes calldata signatures);;
```
