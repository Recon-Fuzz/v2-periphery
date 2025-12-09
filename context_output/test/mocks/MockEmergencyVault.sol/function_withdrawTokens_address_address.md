# Function: withdrawTokens(address,address)

**Contract**: [test/mocks/MockEmergencyVault.sol/contract_MockEmergencyVault.md]

## Metadata

- **Contract**: MockEmergencyVault
- **Signature**: `withdrawTokens(address,address)`
- **Visibility**: external
- **Source Range**: 2893:439:591

## Implementation

```solidity
/// @notice Withdraw tokens from the emergency vault to a recipient
///  @param token_ The token address to withdraw
///  @param to_ The recipient address
function withdrawTokens(address token_, address to_) external onlyOwner() {
    if (token_ == address(0)) revert ZERO_ADDRESS();
    if (to_ == address(0)) revert ZERO_ADDRESS();
    uint256 balance = getTokenBalance(token_);
    if (balance == 0) revert INSUFFICIENT_BALANCE();
    tokenBalances[token_] = 0;
    IERC20(token_).safeTransfer(to_, balance);
    emit TokensWithdrawn(token_, to_, balance);
}
```

## Related Implementations

### getTokenBalance(address)

- **Kind**: internal
- **Source**: 5303:158:591
- **Link**: `test/mocks/MockEmergencyVault.sol:MockEmergencyVault:getTokenBalance(address)`

```solidity
/// @notice Get the balance of a specific token in the emergency vault
///  @param token_ The token address
///  @return The token balance
function getTokenBalance(address token_) public view returns (uint256) {
    return tokenBalances[token_] + IERC20(token_).balanceOf(address(this));
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 2045:95:591
- **Link**: `test/mocks/MockEmergencyVault.sol:MockEmergencyVault:onlyOwner()`

```solidity
modifier onlyOwner() {
    if (msg.sender != owner) revert UNAUTHORIZED();
    _;
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **tokenBalances** (`mapping(address => uint256)`)
- **owner** (`address`)

## State Variable Writes

- **tokenBalances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockEmergencyVault.withdrawTokens(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MockEmergencyVault.getTokenBalance(address) (NodeID: 1)
  │   💬 Args: [token_]
  │   👁️  Def: public
  └─ [1] 🔒 MODIFIER: MockEmergencyVault.onlyOwner() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Withdraw tokens from the emergency vault to a recipient
 @param token_ The token address to withdraw
 @param to_ The recipient address
