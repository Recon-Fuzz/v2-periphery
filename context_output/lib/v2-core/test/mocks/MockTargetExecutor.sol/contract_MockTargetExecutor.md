# Contract: MockTargetExecutor

## Metadata

- **Name**: MockTargetExecutor
- **Type**: Contract
- **Path**: lib/v2-core/test/mocks/MockTargetExecutor.sol

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

### LEDGER_CONFIGURATION

```solidity
ISuperLedgerConfiguration public immutable LEDGER_CONFIGURATION
```

**ISuperLedgerConfiguration**: [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

### SUPER_COLLECTIVE_VAULT

```solidity
ISuperCollectiveVault public immutable SUPER_COLLECTIVE_VAULT
```

**ISuperCollectiveVault**: [lib/v2-core/test/mocks/ISuperCollectiveVault.sol/interface_ISuperCollectiveVault.md]

### nexusFactory

```solidity
INexusFactory public nexusFactory
```

**INexusFactory**: [lib/v2-core/src/vendor/nexus/INexusFactory.sol/interface_INexusFactory.md]

### _initialized

```solidity
mapping(address => bool) internal _initialized
```

### nexusCreatedAccount

```solidity
address public nexusCreatedAccount
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

### INVALID_SENDER

```solidity
error INVALID_SENDER();
```

### NEXUS_ADDRESS_MISMATCH

```solidity
error NEXUS_ADDRESS_MISMATCH();
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

### HappyAccountCreated

```solidity
event HappyAccountCreated(address indexed account);
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1213:239:487
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address ledgerConfiguration_, address superCollectiveVault_);
```

### setNexusFactory(address)

- **Signature**: `setNexusFactory(address)`
- **Visibility**: external
- **Source Range**: 2029:117:487
- **Details**: [function_setNexusFactory_address.md](./function_setNexusFactory_address.md)

**Signature:**
```solidity
function setNexusFactory(address nexusFactory_) external;
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 2152:148:487
- **Details**: [function_isInitialized_address.md](./function_isInitialized_address.md)

**Signature:**
```solidity
function isInitialized(address account) override(IModule, ISuperExecutor) external view returns (bool);
```

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 2306:93:487
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() external pure returns (string memory);
```

### version()

- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 2405:88:487
- **Details**: [function_version.md](./function_version.md)

**Signature:**
```solidity
function version() external pure returns (string memory);
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 2499:123:487
- **Details**: [function_isModuleType_uint256.md](./function_isModuleType_uint256.md)

**Signature:**
```solidity
function isModuleType(uint256 typeId) override external pure returns (bool);
```

### onInstall(bytes)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 2816:194:487
- **Details**: [function_onInstall_bytes.md](./function_onInstall_bytes.md)

**Signature:**
```solidity
function onInstall(bytes calldata) override(IModule, ISuperExecutor) external;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 3016:194:487
- **Details**: [function_onUninstall_bytes.md](./function_onUninstall_bytes.md)

**Signature:**
```solidity
function onUninstall(bytes calldata) override(IModule, ISuperExecutor) external;
```

### handleV3AcrossMessage(address,uint256,address,bytes)

- **Signature**: `handleV3AcrossMessage(address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 3278:1098:487
- **Details**: [function_handleV3AcrossMessage_address_uint256_address_bytes.md](./function_handleV3AcrossMessage_address_uint256_address_bytes.md)

**Signature:**
```solidity
function handleV3AcrossMessage(address tokenSent, uint256 amount, address, bytes memory message) external;
```

### execute(bytes)

- **Signature**: `execute(bytes)`
- **Visibility**: external
- **Source Range**: 4382:184:487
- **Details**: [function_execute_bytes.md](./function_execute_bytes.md)

**Signature:**
```solidity
function execute(bytes calldata data) external;
```
