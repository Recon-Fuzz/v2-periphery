# Contract: ModuleKitHelpers

## Metadata

- **Name**: ModuleKitHelpers
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol
- **Documentation**: @notice A library that contains helper functions for building, testing, deploying, and
           interacting with ERC7579 accounts and modules

## Errors

### InvalidAccountType

```solidity
/// @notice Thrown when an invalid account type is provided, currently only DEFAULT, SAFE,
///          KERNEL, CUSTOM, and NEXUS are supported account types
error InvalidAccountType();
```

### SmartSessionNotInstalled

```solidity
/// @notice Thrown when the smart sessions module is not installed
error SmartSessionNotInstalled();
```
