# Contract: SuperExecutor

## Metadata

- **Name**: SuperExecutor
- **Type**: Contract
- **Path**: lib/v2-core/src/executors/SuperExecutor.sol
- **Documentation**: @title SuperExecutor
   @author Superform Labs
   @notice Standard implementation of the Superform hook executor for local chain operations
   @dev This is the primary executor for non-cross-chain operations, implementing the logic
        defined in SuperExecutorBase without adding additional functionality

## Implements Interfaces

- **ISuperExecutor** [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **IExecutor** [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IExecutor.md]
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

### NOT_ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant ENTERED = 2
```

### _status (inherited from ReentrancyGuard)

```solidity
uint256 private _status
```

### NATIVE_TOKEN_SENTINEL (inherited from SuperExecutorBase)

```solidity
address internal constant NATIVE_TOKEN_SENTINEL = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
```

### EIP7702_PREFIX (inherited from SuperExecutorBase)

```solidity
/// @notice Prefix for 7702 authority -> https://eip7702.io/
bytes3 internal constant EIP7702_PREFIX = bytes3(0xef0100)
```

### _initialized (inherited from SuperExecutorBase)

```solidity
/// @notice Tracks which accounts have initialized this executor
///  @dev Used to ensure only initialized accounts can execute operations
mapping(address => bool) internal _initialized
```

### LEDGER_CONFIGURATION (inherited from SuperExecutorBase)

```solidity
/// @notice Configuration for yield sources and accounting
///  @dev Provides access to ledger information and fee settings
ISuperLedgerConfiguration public immutable LEDGER_CONFIGURATION
```

**ISuperLedgerConfiguration**: [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

### FEE_TOLERANCE (inherited from SuperExecutorBase)

```solidity
/// @notice Tolerance for fee transfer verification (numerator)
///  @dev Used to account for tokens with transfer fees or rounding errors
uint256 internal constant FEE_TOLERANCE = 1000
```

### FEE_TOLERANCE_DENOMINATOR (inherited from SuperExecutorBase)

```solidity
/// @notice Denominator for fee tolerance calculation
///  @dev FEE_TOLERANCE/FEE_TOLERANCE_DENOMINATOR represents the maximum allowed deviation
uint256 internal constant FEE_TOLERANCE_DENOMINATOR = 100_000
```

## Structs

### ExecutorEntry (inherited from ISuperExecutor)

```solidity
/// @notice Input data structure for hook execution
///  @dev Contains parallel arrays of hook addresses and their corresponding input data
///       Both arrays must have the same length, with each index corresponding to the same hook
struct ExecutorEntry {
    address[] hooksAddresses;
    bytes[] hooksData;
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

### NO_HOOKS (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when trying to execute with an empty hooks array
///  @dev A valid execution requires at least one hook to process
error NO_HOOKS();
```

### INVALID_FEE (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when a fee calculation results in an invalid amount
///  @dev Typically occurs when a fee exceeds the available amount or is negative
///       Important for maintaining economic integrity in the system
error INVALID_FEE();
```

### NOT_AUTHORIZED (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when an unauthorized address attempts a restricted operation
///  @dev Security measure to ensure only approved addresses can perform certain actions
///       Critical for maintaining system security and integrity
error NOT_AUTHORIZED();
```

### LENGTH_MISMATCH (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when the hooks addresses and data arrays have different lengths
///  @dev Each hook address must have a corresponding data element
///       This ensures data integrity during execution sequences
error LENGTH_MISMATCH();
```

### NOT_INITIALIZED (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when trying to use an executor that hasn't been initialized for an account
///  @dev Executors must be properly initialized before use to ensure correct state
error NOT_INITIALIZED();
```

### MANAGER_NOT_SET (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when a manager address is required but not set
///  @dev The manager is needed for certain privileged operations
///       Particularly important for rebalancing governance
error MANAGER_NOT_SET();
```

### INVALID_CHAIN_ID (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when an operation references an invalid chain ID
///  @dev Cross-chain operations must use valid destination chain identifiers
///       Essential for multi-chain SuperUSD deployments
error INVALID_CHAIN_ID();
```

### ADDRESS_NOT_VALID (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when an invalid address (typically zero address) is provided
///  @dev Prevents operations with problematic address values
///       Zero addresses are generally not allowed as hooks or recipients
error ADDRESS_NOT_VALID();
```

### ALREADY_INITIALIZED (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when trying to initialize an executor that's already initialized
///  @dev Prevents duplicate initialization which could reset important state
error ALREADY_INITIALIZED();
```

### FEE_NOT_TRANSFERRED (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when a fee transfer fails to complete correctly
///  @dev Used to detect potential issues with the fee transfer mechanism
error FEE_NOT_TRANSFERRED();
```

### INSUFFICIENT_BALANCE_FOR_FEE (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when an account has insufficient balance to pay required fees
///  @dev Ensures operations only proceed when proper compensation can be provided
error INSUFFICIENT_BALANCE_FOR_FEE();
```

### MALICIOUS_HOOK_DETECTED (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when a malicious hook is detected
///  @dev Used to prevent unauthorized or malicious hooks from compromising the system
error MALICIOUS_HOOK_DETECTED();
```

### INVALID_YIELD_SOURCE_ORACLE_ID (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when an invalid yield source oracle ID is provided
///  @dev Used to prevent operations with problematic yield source oracle IDs
error INVALID_YIELD_SOURCE_ORACLE_ID();
```

### INVALID_CALLER (inherited from ISuperExecutor)

```solidity
/// @notice Thrown when `hook.setExecutionContext` is called with an invalid caller
error INVALID_CALLER();
```

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuard)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

## Events

### SuperPositionMintRequested (inherited from ISuperExecutor)

```solidity
/// @notice Emitted when a cross-chain SuperPosition mint is requested
///  @dev This event signals that a position should be minted on another chain
///  @param account The account that will receive the minted SuperPosition
///  @param spToken The SuperPosition token address to be minted
///  @param amount The amount of tokens to mint, in the token's native units
///  @param dstChainId The destination chain ID where the mint will occur
event SuperPositionMintRequested(address indexed account, address indexed spToken, uint256 amount, uint256 indexed dstChainId);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 667:85:361
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
/// @notice Initializes the SuperExecutor with ledger configuration
///  @param ledgerConfiguration_ Address of the ledger configuration contract for fee calculations
constructor(address ledgerConfiguration_) SuperExecutorBase(ledgerConfiguration_);
```

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 942:102:361
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() override external pure returns (string memory);
```

### version()

- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 1050:97:361
- **Details**: [function_version.md](./function_version.md)

**Signature:**
```solidity
function version() override external pure returns (string memory);
```

### isInitialized(address) (inherited from SuperExecutorBase)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 3754:148:362
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperExecutor
function isInitialized(address account) override(IModule, ISuperExecutor) external view returns (bool);
```

### isModuleType(uint256) (inherited from SuperExecutorBase)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 4379:123:362
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
/// @notice Verifies if this module is of the specified type
///  @dev Part of the ERC-7579 module interface
///  @param typeId The module type identifier to check against
///  @return True if this module matches the specified type, false otherwise
function isModuleType(uint256 typeId) override external pure returns (bool);
```

### onInstall(bytes) (inherited from SuperExecutorBase)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 4731:194:362
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperExecutor
function onInstall(bytes calldata) override(IModule, ISuperExecutor) external;
```

### onUninstall(bytes) (inherited from SuperExecutorBase)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 4966:194:362
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperExecutor
function onUninstall(bytes calldata) override(IModule, ISuperExecutor) external;
```

### execute(bytes) (inherited from SuperExecutorBase)

- **Signature**: `execute(bytes)`
- **Visibility**: external
- **Source Range**: 5201:216:362
- **Details**: [function_execute_bytes.md](./function_execute_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperExecutor
function execute(bytes calldata data) virtual external;
```

### validateHookCompliance(address,address,address,bytes) (inherited from SuperExecutorBase)

- **Signature**: `validateHookCompliance(address,address,address,bytes)`
- **Visibility**: public
- **Source Range**: 5492:1189:362
- **Details**: [function_validateHookCompliance_address_address_address_bytes.md](./function_validateHookCompliance_address_address_address_bytes.md)

**Signature:**
```solidity
/// @notice Validates that hook follows secure execution pattern
function validateHookCompliance(address hook, address prevHook, address account, bytes memory hookData) public view returns (Execution[] memory);
```
