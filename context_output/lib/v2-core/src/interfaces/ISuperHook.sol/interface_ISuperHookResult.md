# Interface: ISuperHookResult

## Metadata

- **Name**: ISuperHookResult
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookResult
   @author Superform Labs
   @notice Interface that exposes the result of a hook execution
   @dev All hooks must implement this interface to provide standardized access to execution results.
        These results are used by subsequent hooks in the execution chain and by the executor.

## Public/External Functions

### hookType()

- **Signature**: `hookType()`
- **Visibility**: external
- **Source Range**: 3113:64:422

**Signature:**
```solidity
/// @notice The type of hook
///  @dev Used to determine how accounting should process this hook's results
///  @return The hook type (NONACCOUNTING, INFLOW, or OUTFLOW)
function hookType() external view returns (ISuperHook.HookType);;
```

### spToken()

- **Signature**: `spToken()`
- **Visibility**: external
- **Source Range**: 3418:51:422

**Signature:**
```solidity
/// @notice The SuperPosition (SP) token associated with this hook
///  @dev For vault hooks, this would be the tokenized position representing shares
///  @return The address of the SP token, or address(0) if not applicable
function spToken() external view returns (address);;
```

### asset()

- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 3697:49:422

**Signature:**
```solidity
/// @notice The underlying asset token being processed
///  @dev For most hooks, this is the actual token being deposited or withdrawn
///  @return The address of the asset token, or address(0) for native assets
function asset() external view returns (address);;
```

### getOutAmount(address)

- **Signature**: `getOutAmount(address)`
- **Visibility**: external
- **Source Range**: 4072:70:422

**Signature:**
```solidity
/// @notice The amount of tokens processed by the hook in a given caller context, subject to fees after update
///  @dev This is the primary output value used by subsequent hooks
///  @param caller The caller address for context identification
///  @return The amount of tokens (assets or shares) processed
function getOutAmount(address caller) external view returns (uint256);;
```
