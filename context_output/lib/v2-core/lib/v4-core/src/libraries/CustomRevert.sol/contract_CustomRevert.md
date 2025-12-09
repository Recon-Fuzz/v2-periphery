# Contract: CustomRevert

## Metadata

- **Name**: CustomRevert
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/libraries/CustomRevert.sol
- **Documentation**: @title Library for reverting with custom errors efficiently
   @notice Contains functions for reverting with custom errors with different argument types efficiently
   @dev To use this library, declare `using CustomRevert for bytes4;` and replace `revert CustomError()` with
   `CustomError.selector.revertWith()`
   @dev The functions may tamper with the free memory pointer but it is fine since the call context is exited immediately

## Errors

### WrappedError

```solidity
/// @dev ERC-7751 error for wrapping bubbled up reverts
error WrappedError(address target, bytes4 selector, bytes reason, bytes details);
```
