# Interface: ISuperHook

## Metadata

- **Name**: ISuperHook
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHook
   @author Superform Labs
   @notice The core hook interface that all hooks must implement
   @dev Defines the lifecycle methods and execution flow for the hook system
        Hooks are executed in sequence with results passed between them

## Enums

### HookType

```solidity
/// @notice Defines the possible types of hooks in the system
///  @dev Used to determine how the hook affects accounting and what operations it performs
enum HookType {
    NONACCOUNTING,
    INFLOW,
    OUTFLOW
}
```

## Public/External Functions

### build(address,address,bytes)

- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 10940:179:422

**Signature:**
```solidity
/// @notice Builds the execution array for the hook operation
///  @dev This is the core method where hooks define their on-chain interactions
///       The returned executions are a sequence of contract calls to perform
///       No state changes should occur in this method
///  @param prevHook The address of the previous hook in the chain, or address(0) if first
///  @param account The account to perform executions for (usually an ERC7579 account)
///  @param data The hook-specific parameters and configuration data
///  @return executions Array of Execution structs defining calls to make
function build(address prevHook, address account, bytes calldata data) external view returns (Execution[] memory executions);;
```

### preExecute(address,address,bytes)

- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 11771:83:422

**Signature:**
```solidity
/// @notice Prepares the hook for execution
///  @dev Called before the main execution, used to validate inputs and set execution context
///       This method may perform state changes to set up the hook's execution state
///  @param prevHook The address of the previous hook in the chain, or address(0) if first
///  @param account The account to perform operations for
///  @param data The hook-specific parameters and configuration data
function preExecute(address prevHook, address account, bytes memory data) external;;
```

### postExecute(address,address,bytes)

- **Signature**: `postExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 12319:84:422

**Signature:**
```solidity
/// @notice Finalizes the hook after execution
///  @dev Called after the main execution, used to update hook state and calculate results
///       Sets output values (outAmount, usedShares, etc.) for subsequent hooks
///  @param prevHook The address of the previous hook in the chain, or address(0) if first
///  @param account The account operations were performed for
///  @param data The hook-specific parameters and configuration data
function postExecute(address prevHook, address account, bytes memory data) external;;
```

### subtype()

- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 12703:51:422

**Signature:**
```solidity
/// @notice Returns the specific subtype identification for this hook
///  @dev Used to categorize hooks beyond the basic HookType
///       For example, a hook might be of type INFLOW but subtype VAULT_DEPOSIT
///  @return A bytes32 identifier for the specific hook functionality
function subtype() external view returns (bytes32);;
```

### resetExecutionState(address)

- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 12864:54:422

**Signature:**
```solidity
/// @notice Resets hook mutexes
///  @param caller The caller address for context identification
function resetExecutionState(address caller) external;;
```

### setExecutionContext(address)

- **Signature**: `setExecutionContext(address)`
- **Visibility**: external
- **Source Range**: 13144:54:422

**Signature:**
```solidity
/// @notice Sets the caller address that initiated the execution
///  @dev Used for security validation between preExecute and postExecute calls
///  @param caller The caller address for context identification
function setExecutionContext(address caller) external;;
```

### executionNonce()

- **Signature**: `executionNonce()`
- **Visibility**: external
- **Source Range**: 13399:58:422

**Signature:**
```solidity
/// @notice Returns the execution nonce for the current execution context
///  @dev Used to ensure unique execution contexts and prevent replay attacks
///  @return The execution nonce
function executionNonce() external view returns (uint256);;
```

### lastCaller()

- **Signature**: `lastCaller()`
- **Visibility**: external
- **Source Range**: 13579:54:422

**Signature:**
```solidity
/// @notice Returns the last caller registered by `setExecutionContext`
///  @return The last caller address
function lastCaller() external view returns (address);;
```
