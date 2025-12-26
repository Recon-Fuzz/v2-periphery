# Contract: SafeERC20

## Metadata

- **Name**: SafeERC20
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol
- **Documentation**:  @title SafeERC20
   @dev Wrappers around ERC-20 operations that throw on failure (when the token
   contract returns false). Tokens that return no value (and instead revert or
   throw on failure) are also supported, non-reverting calls are assumed to be
   successful.
   To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
   which allows you to call the safe operations as `token.safeTransfer(...)`, etc.

## Errors

### SafeERC20FailedOperation

```solidity
///  @dev An operation with an ERC-20 token failed.
error SafeERC20FailedOperation(address token);
```

### SafeERC20FailedDecreaseAllowance

```solidity
///  @dev Indicates a failed `decreaseAllowance` request.
error SafeERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);
```
