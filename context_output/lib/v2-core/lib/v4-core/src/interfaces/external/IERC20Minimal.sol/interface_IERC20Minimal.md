# Interface: IERC20Minimal

## Metadata

- **Name**: IERC20Minimal
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/external/IERC20Minimal.sol
- **Documentation**: @title Minimal ERC20 interface for Uniswap
   @notice Contains a subset of the full ERC20 interface that is used in Uniswap V3

## Events

### Transfer

```solidity
/// @notice Event emitted when tokens are transferred from one address to another, either via `#transfer` or `#transferFrom`.
///  @param from The account from which the tokens were sent, i.e. the balance decreased
///  @param to The account to which the tokens were sent, i.e. the balance increased
///  @param value The amount of tokens that were transferred
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval

```solidity
/// @notice Event emitted when the approval amount for the spender of a given owner's tokens changes.
///  @param owner The account that approved spending of its tokens
///  @param spender The account for which the spending allowance was modified
///  @param value The new allowance from the owner to the spender
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 436:68:331

**Signature:**
```solidity
/// @notice Returns an account's balance in the token
///  @param account The account for which to look up the number of tokens it has, i.e. its balance
///  @return The number of tokens held by the account
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 848:77:331

**Signature:**
```solidity
/// @notice Transfers the amount of token from the `msg.sender` to the recipient
///  @param recipient The account that will receive the amount transferred
///  @param amount The number of tokens to send from the sender to the recipient
///  @return Returns true for a successful transfer, false for an unsuccessful transfer
function transfer(address recipient, uint256 amount) external returns (bool);;
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1186:83:331

**Signature:**
```solidity
/// @notice Returns the current allowance given to a spender by an owner
///  @param owner The account of the token owner
///  @param spender The account of the token spender
///  @return The current allowance granted by `owner` to `spender`
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 1623:74:331

**Signature:**
```solidity
/// @notice Sets the allowance of a spender from the `msg.sender` to the value `amount`
///  @param spender The account which will be allowed to spend a given amount of the owners tokens
///  @param amount The amount of tokens allowed to be used by `spender`
///  @return Returns true for a successful approval, false for unsuccessful
function approve(address spender, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2079:97:331

**Signature:**
```solidity
/// @notice Transfers `amount` tokens from `sender` to `recipient` up to the allowance given to the `msg.sender`
///  @param sender The account from which the transfer will be initiated
///  @param recipient The recipient of the transfer
///  @param amount The amount of the transfer
///  @return Returns true for a successful transfer, false for unsuccessful
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);;
```
