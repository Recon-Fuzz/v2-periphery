# Interface: ISuperLockableHook

## Metadata

- **Name**: ISuperLockableHook
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**:  @title SuperHook System
   @author Superform Labs
   @notice The hook system provides a modular and composable way to execute operations on assets
   @dev The hook system architecture consists of several interfaces that work together:
        - ISuperHook: The base interface all hooks implement, with lifecycle methods
        - ISuperHookResult: Provides execution results and output information
        - Specialized interfaces (ISuperHookOutflow, ISuperHookLoans, etc.) for specific behaviors
   Hooks are executed in sequence, where each hook can access the results from previous hooks.
   The three main types of hooks are:
        - NONACCOUNTING: Utility hooks that don't update the accounting system
        - INFLOW: Hooks that process deposits or additions to positions
        - OUTFLOW: Hooks that process withdrawals or reductions to positions

## Public/External Functions

### vaultBank()

- **Signature**: `vaultBank()`
- **Visibility**: external
- **Source Range**: 1281:53:422

**Signature:**
```solidity
/// @notice The vault bank address used to lock SuperPositions
///  @dev Only relevant for cross-chain operations where positions are locked
///  @return The vault bank address, or address(0) if not applicable
function vaultBank() external view returns (address);;
```

### dstChainId()

- **Signature**: `dstChainId()`
- **Visibility**: external
- **Source Range**: 1568:54:422

**Signature:**
```solidity
/// @notice The destination chain ID for cross-chain operations
///  @dev Used to identify the target chain for cross-chain position transfers
///  @return The destination chain ID, or 0 if not a cross-chain operation
function dstChainId() external view returns (uint256);;
```
