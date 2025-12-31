# Contract: CurrencyLibrary

## Metadata

- **Name**: CurrencyLibrary
- **Type**: Contract
- **Path**: lib/v2-core/lib/v4-core/src/types/Currency.sol
- **Documentation**: @title CurrencyLibrary
   @dev This library allows for transferring and holding native tokens and ERC20 tokens

## State Variables

### ADDRESS_ZERO

```solidity
/// @notice A constant to represent the native currency
Currency public constant ADDRESS_ZERO = Currency.wrap(address(0))
```

## Errors

### NativeTransferFailed

```solidity
/// @notice Additional context for ERC-7751 wrapped error when a native transfer fails
error NativeTransferFailed();
```

### ERC20TransferFailed

```solidity
/// @notice Additional context for ERC-7751 wrapped error when an ERC20 transfer fails
error ERC20TransferFailed();
```
