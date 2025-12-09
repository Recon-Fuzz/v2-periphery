# Interface: ISuperHookResultOutflow

## Metadata

- **Name**: ISuperHookResultOutflow
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookResultOutflow
   @author Superform Labs
   @notice Extended result interface for outflow hook operations
   @dev Extends the base result interface with outflow-specific information

## Implements Interfaces

- **ISuperHookResult** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookResult.md]

## Public/External Functions

### usedShares()

- **Signature**: `usedShares()`
- **Visibility**: external
- **Source Range**: 6454:54:422

**Signature:**
```solidity
/// @notice The amount of shares consumed during outflow processing
///  @dev Used for cost basis calculation in the accounting system
///  @return The amount of shares consumed from the user's position
function usedShares() external view returns (uint256);;
```

### hookType() (inherited from ISuperHookResult)

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

### spToken() (inherited from ISuperHookResult)

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

### asset() (inherited from ISuperHookResult)

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

### getOutAmount(address) (inherited from ISuperHookResult)

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
