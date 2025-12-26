# Contract: SuperValidator

## Metadata

- **Name**: SuperValidator
- **Type**: Contract
- **Path**: lib/v2-core/src/validators/SuperValidator.sol
- **Documentation**: @title SuperValidator
   @author Superform Labs
   @notice Validates user operations using merkle proofs for smart account signatures
   @dev Implements EIP-1271 and ERC-4337 signature validation mechanisms
        Uses transient storage for signature data management

## Implements Interfaces

- **ISuperSignatureStorage** [lib/v2-core/src/interfaces/ISuperSignatureStorage.sol/interface_ISuperSignatureStorage.md]
- **ISuperValidator** [lib/v2-core/src/interfaces/ISuperValidator.sol/interface_ISuperValidator.md]
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

### _initialized (inherited from SuperValidatorBase)

```solidity
/// @notice Tracks which accounts have initialized this validator
///  @dev Used to prevent unauthorized use of the validator
mapping(address => bool) internal _initialized
```

### _accountOwners (inherited from SuperValidatorBase)

```solidity
/// @notice Maps accounts to their owners
///  @dev Used to verify signatures against the correct owner address
mapping(address => address) internal _accountOwners
```

### EIP7702_PREFIX (inherited from SuperValidatorBase)

```solidity
/// @notice Prefix for 7702 authority -> https://eip7702.io/
bytes3 internal constant EIP7702_PREFIX = bytes3(0xef0100)
```

### EIP1271_MAGIC_VALUE (inherited from SuperValidatorBase)

```solidity
/// @notice Magic value returned when a signature is valid according to EIP-1271
///  @dev The value 0x1626ba7e is specified by the EIP-1271 standard
bytes4 internal constant EIP1271_MAGIC_VALUE = bytes4(0x1626ba7e)
```

## Structs

### DstProof (inherited from ISuperValidator)

```solidity
/// @notice Structure holding proof data for destination chain operations
///  @dev Contains merkle proof and destination chain ID
struct DstProof {
    bytes32[] proof;
    uint64 dstChainId;
    DstInfo info;
}
```

### DstInfo (inherited from ISuperValidator)

```solidity
/// @notice Structure holding destination chain operation details
///  @dev Used to validate destination `proof` on source validator
struct DstInfo {
    address account;
    address executor;
    address[] dstTokens;
    uint256[] intentAmounts;
    address validator;
    bytes data;
}
```

### DestinationData (inherited from ISuperValidator)

```solidity
/// @notice Structure representing data specific to a destination chain operation
///  @dev Contains all necessary data to validate and execute a cross-chain operation
struct DestinationData {
    bytes callData;
    uint64 chainId;
    address sender;
    address executor;
    address[] dstTokens;
    uint256[] intentAmounts;
}
```

### SignatureData (inherited from ISuperValidator)

```solidity
/// @notice Structure holding signature data used across validator implementations
///  @dev Contains all components needed for merkle proof verification and signature validation
struct SignatureData {
    uint64[] chainsWithDestinationExecution;
    uint48 validUntil;
    uint48 validAfter;
    bytes32 merkleRoot;
    bytes32[] proofSrc;
    DstProof[] proofDst;
    bytes signature;
}
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

### INVALID_SENDER (inherited from ISuperValidator)

```solidity
/// @notice Thrown when the sender account has not been initialized
error INVALID_SENDER();
```

### NOT_INITIALIZED (inherited from ISuperValidator)

```solidity
error NOT_INITIALIZED();
```

### NOT_IMPLEMENTED (inherited from ISuperValidator)

```solidity
error NOT_IMPLEMENTED();
```

### PROOF_NOT_FOUND (inherited from ISuperValidator)

```solidity
error PROOF_NOT_FOUND();
```

### INVALID_CHAIN_ID (inherited from ISuperValidator)

```solidity
error INVALID_CHAIN_ID();
```

### ZERO_ADDRESS (inherited from SuperValidatorBase)

```solidity
error ZERO_ADDRESS();
```

### INVALID_PROOF (inherited from SuperValidatorBase)

```solidity
error INVALID_PROOF();
```

### ALREADY_INITIALIZED (inherited from SuperValidatorBase)

```solidity
error ALREADY_INITIALIZED();
```

### INVALID_DESTINATION_PROOF (inherited from SuperValidatorBase)

```solidity
error INVALID_DESTINATION_PROOF();
```

### NOT_EIP1271_SIGNER (inherited from SuperValidatorBase)

```solidity
error NOT_EIP1271_SIGNER();
```

### EMPTY_DESTINATION_PROOF (inherited from SuperValidatorBase)

```solidity
error EMPTY_DESTINATION_PROOF();
```

### PROOF_COUNT_MISMATCH (inherited from SuperValidatorBase)

```solidity
error PROOF_COUNT_MISMATCH();
```

### INVALID_MERKLE_PROOF (inherited from SuperValidatorBase)

```solidity
error INVALID_MERKLE_PROOF();
```

### UNEXPECTED_CHAIN_PROOF (inherited from SuperValidatorBase)

```solidity
error UNEXPECTED_CHAIN_PROOF();
```

### INVALID_USER_OP (inherited from ISuperSignatureStorage)

```solidity
/// @notice Thrown when more than one user op is detected for signature storage
error INVALID_USER_OP();
```

## Events

### AccountOwnerSet (inherited from ISuperValidator)

```solidity
event AccountOwnerSet(address indexed account, address indexed owner);
```

### AccountUnset (inherited from ISuperValidator)

```solidity
event AccountUnset(address indexed account);
```

## Public/External Functions

### retrieveSignatureData(address)

- **Signature**: `retrieveSignatureData(address)`
- **Visibility**: external
- **Source Range**: 1294:191:438
- **Details**: [function_retrieveSignatureData_address.md](./function_retrieveSignatureData_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperSignatureStorage
function retrieveSignatureData(address account) external view returns (bytes memory);
```

### validateUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 1775:2612:438
- **Details**: [function_validateUserOp_struct_PackedUserOperation_bytes32.md](./function_validateUserOp_struct_PackedUserOperation_bytes32.md)

**Signature:**
```solidity
/// @notice Validate a user operation
///  @param _userOp The user operation to validate
function validateUserOp(PackedUserOperation calldata _userOp, bytes32 _userOpHash) override external returns (ValidationData);
```

### isValidSignatureWithSender(address,bytes32,bytes)

- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 4442:791:438
- **Details**: [function_isValidSignatureWithSender_address_bytes32_bytes.md](./function_isValidSignatureWithSender_address_bytes32_bytes.md)

**Signature:**
```solidity
/// @notice Validate a signature with sender
function isValidSignatureWithSender(address, bytes32 dataHash, bytes calldata data) override external view returns (bytes4);
```

### isInitialized(address) (inherited from SuperValidatorBase)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 2461:114:439
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address account) external view returns (bool);
```

### namespace() (inherited from SuperValidatorBase)

- **Signature**: `namespace()`
- **Visibility**: public
- **Source Range**: 2581:93:439
- **Details**: [function_namespace.md](./function_namespace.md)

**Signature:**
```solidity
function namespace() public pure returns (string memory);
```

### isModuleType(uint256) (inherited from SuperValidatorBase)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 2680:124:439
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 typeId) override external pure returns (bool);
```

### getAccountOwner(address) (inherited from SuperValidatorBase)

- **Signature**: `getAccountOwner(address)`
- **Visibility**: external
- **Source Range**: 2810:121:439
- **Details**: [function_getAccountOwner_address.md](./function_getAccountOwner_address.md)

**Signature:**
```solidity
function getAccountOwner(address account) external view returns (address);
```

### onInstall(bytes) (inherited from SuperValidatorBase)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 3120:368:439
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata data) external;
```

### onUninstall(bytes) (inherited from SuperValidatorBase)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 3494:243:439
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata) external;
```
