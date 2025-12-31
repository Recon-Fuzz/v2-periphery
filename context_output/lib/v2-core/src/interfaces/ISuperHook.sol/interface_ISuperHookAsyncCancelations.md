# Interface: ISuperHookAsyncCancelations

## Metadata

- **Name**: ISuperHookAsyncCancelations
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookAsyncCancelations
   @author Superform Labs
   @notice Interface for hooks that can cancel asynchronous operations
   @dev Used to handle cancellation of pending operations that haven't completed

## Enums

### CancelationType

```solidity
/// @notice Types of cancellations that can be performed
///  @dev Distinguishes between different operation types that can be canceled
enum CancelationType {
    NONE,
    INFLOW,
    OUTFLOW
}
```

## Public/External Functions

### isAsyncCancelHook()

- **Signature**: `isAsyncCancelHook()`
- **Visibility**: external
- **Source Range**: 9168:79:422

**Signature:**
```solidity
/// @notice Identifies the type of async operation this hook can cancel
///  @dev Used to verify the hook is appropriate for the operation being canceled
///  @return asyncType The type of cancellation this hook performs
function isAsyncCancelHook() external pure returns (CancelationType asyncType);;
```
