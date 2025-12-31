# Contract: Errors

## Metadata

- **Name**: Errors
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Errors.sol
- **Documentation**:  @dev Collection of common custom errors used in multiple contracts
   IMPORTANT: Backwards compatibility is not guaranteed in future versions of the library.
   It is recommended to avoid relying on the error API for critical functionality.
   _Available since v5.1._

## Errors

### InsufficientBalance

```solidity
///  @dev The ETH balance of the account is not enough to perform the operation.
error InsufficientBalance(uint256 balance, uint256 needed);
```

### FailedCall

```solidity
///  @dev A call to an address target failed. The target may have reverted.
error FailedCall();
```

### FailedDeployment

```solidity
///  @dev The deployment failed.
error FailedDeployment();
```

### MissingPrecompile

```solidity
///  @dev A necessary precompile is missing.
error MissingPrecompile(address);
```
