# Interface: IAllowanceTransfer

## Metadata

- **Name**: IAllowanceTransfer
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/uniswap/permit2/IAllowanceTransfer.sol
- **Documentation**: @title AllowanceTransfer
   @notice Handles ERC20 token permissions through signature based allowance setting and ERC20 token transfers by
   checking allowed amounts
   @dev Requires user's token approval on the Permit2 contract

## Implements Interfaces

- **IEIP712** [lib/v2-core/src/vendor/uniswap/permit2/IEIP712.sol/interface_IEIP712.md]

## Structs

### PermitDetails

```solidity
/// @notice The permit data for a token
struct PermitDetails {
    address token;
    uint160 amount;
    uint48 expiration;
    uint48 nonce;
}
```

### PermitSingle

```solidity
/// @notice The permit message signed for a single token allowance
struct PermitSingle {
    PermitDetails details;
    address spender;
    uint256 sigDeadline;
}
```

### PermitBatch

```solidity
/// @notice The permit message signed for multiple token allowances
struct PermitBatch {
    PermitDetails[] details;
    address spender;
    uint256 sigDeadline;
}
```

### PackedAllowance

```solidity
/// @notice The saved permissions
///  @dev This info is saved per owner, per token, per spender and all signed over in the permit message
///  @dev Setting amount to type(uint160).max sets an unlimited approval
struct PackedAllowance {
    uint160 amount;
    uint48 expiration;
    uint48 nonce;
}
```

### TokenSpenderPair

```solidity
/// @notice A token spender pair.
struct TokenSpenderPair {
    address token;
    address spender;
}
```

### AllowanceTransferDetails

```solidity
/// @notice Details for a token transfer.
struct AllowanceTransferDetails {
    address from;
    address to;
    uint160 amount;
    address token;
}
```

## Errors

### AllowanceExpired

```solidity
/// @notice Thrown when an allowance on a token has expired.
///  @param deadline The timestamp at which the allowed amount is no longer valid
error AllowanceExpired(uint256 deadline);
```

### InsufficientAllowance

```solidity
/// @notice Thrown when an allowance on a token has been depleted.
///  @param amount The maximum amount allowed
error InsufficientAllowance(uint256 amount);
```

### ExcessiveInvalidation

```solidity
/// @notice Thrown when too many nonces are invalidated.
error ExcessiveInvalidation();
```

## Events

### NonceInvalidation

```solidity
/// @notice Emits an event when the owner successfully invalidates an ordered nonce.
event NonceInvalidation(address indexed owner, address indexed token, address indexed spender, uint48 newNonce, uint48 oldNonce);
```

### Approval

```solidity
/// @notice Emits an event when the owner successfully sets permissions on a token for the spender.
event Approval(address indexed owner, address indexed token, address indexed spender, uint160 amount, uint48 expiration);
```

### Permit

```solidity
/// @notice Emits an event when the owner successfully sets permissions using a permit signature on a token for the
///  spender.
event Permit(address indexed owner, address indexed token, address indexed spender, uint160 amount, uint48 expiration, uint48 nonce);
```

### Lockdown

```solidity
/// @notice Emits an event when the owner sets the allowance back to 0 with the lockdown function.
event Lockdown(address indexed owner, address token, address spender);
```

## Public/External Functions

### allowance(address,address,address)

- **Signature**: `allowance(address,address,address)`
- **Visibility**: external
- **Source Range**: 4421:191:473

**Signature:**
```solidity
/// @notice A mapping from owner address to token address to spender address to PackedAllowance struct, which
///  contains details and conditions of the approval.
///  @notice The mapping is indexed in the above order see: allowance[ownerAddress][tokenAddress][spenderAddress]
///  @dev The packed slot holds the allowed amount, expiration at which the allowed amount is no longer valid, and
///  current nonce thats updated on any signature based approvals.
function allowance(address user, address token, address spender) external view returns (uint160 amount, uint48 expiration, uint48 nonce);;
```

### approve(address,address,uint160,uint48)

- **Signature**: `approve(address,address,uint160,uint48)`
- **Visibility**: external
- **Source Range**: 5121:93:473

**Signature:**
```solidity
/// @notice Approves the spender to use up to amount of the specified token up until the expiration
///  @param token The token to approve
///  @param spender The spender address to approve
///  @param amount The approved amount of the token
///  @param expiration The timestamp at which the approval is no longer valid
///  @dev The packed allowance also holds a nonce, which will stay unchanged in approve
///  @dev Setting amount to type(uint160).max sets an unlimited approval
function approve(address token, address spender, uint160 amount, uint48 expiration) external;;
```

### permit(address,struct IAllowanceTransfer.PermitSingle,bytes)

- **Signature**: `permit(address,struct IAllowanceTransfer.PermitSingle,bytes)`
- **Visibility**: external
- **Source Range**: 5632:100:473

**Signature:**
```solidity
/// @notice Permit a spender to a given amount of the owners token via the owner's EIP-712 signature
///  @dev May fail if the owner's nonce was invalidated in-flight by invalidateNonce
///  @param owner The owner of the tokens being approved
///  @param permitSingle Data signed over by the owner specifying the terms of approval
///  @param signature The owner's signature over the permit data
function permit(address owner, PermitSingle memory permitSingle, bytes calldata signature) external;;
```

### permit(address,struct IAllowanceTransfer.PermitBatch,bytes)

- **Signature**: `permit(address,struct IAllowanceTransfer.PermitBatch,bytes)`
- **Visibility**: external
- **Source Range**: 6154:98:473

**Signature:**
```solidity
/// @notice Permit a spender to the signed amounts of the owners tokens via the owner's EIP-712 signature
///  @dev May fail if the owner's nonce was invalidated in-flight by invalidateNonce
///  @param owner The owner of the tokens being approved
///  @param permitBatch Data signed over by the owner specifying the terms of approval
///  @param signature The owner's signature over the permit data
function permit(address owner, PermitBatch memory permitBatch, bytes calldata signature) external;;
```

### transferFrom(address,address,uint160,address)

- **Signature**: `transferFrom(address,address,uint160,address)`
- **Visibility**: external
- **Source Range**: 6649:88:473

**Signature:**
```solidity
/// @notice Transfer approved tokens from one address to another
///  @param from The address to transfer from
///  @param to The address of the recipient
///  @param amount The amount of the token to transfer
///  @param token The token address to transfer
///  @dev Requires the from address to have approved at least the desired amount
///  of tokens to msg.sender.
function transferFrom(address from, address to, uint160 amount, address token) external;;
```

### transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[])

- **Signature**: `transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[])`
- **Visibility**: external
- **Source Range**: 7012:84:473

**Signature:**
```solidity
/// @notice Transfer approved tokens in a batch
///  @param transferDetails Array of owners, recipients, amounts, and tokens for the transfers
///  @dev Requires the from addresses to have approved at least the desired amount
///  of tokens to msg.sender.
function transferFrom(AllowanceTransferDetails[] calldata transferDetails) external;;
```

### lockdown(struct IAllowanceTransfer.TokenSpenderPair[])

- **Signature**: `lockdown(struct IAllowanceTransfer.TokenSpenderPair[])`
- **Visibility**: external
- **Source Range**: 7274:66:473

**Signature:**
```solidity
/// @notice Enables performing a "lockdown" of the sender's Permit2 identity
///  by batch revoking approvals
///  @param approvals Array of approvals to revoke.
function lockdown(TokenSpenderPair[] calldata approvals) external;;
```

### invalidateNonces(address,address,uint48)

- **Signature**: `invalidateNonces(address,address,uint48)`
- **Visibility**: external
- **Source Range**: 7683:84:473

**Signature:**
```solidity
/// @notice Invalidate nonces for a given (token, spender) pair
///  @param token The token to invalidate nonces for
///  @param spender The spender to invalidate nonces for
///  @param newNonce The new nonce to set. Invalidates all nonces less than it.
///  @dev Can't invalidate more than 2**16 nonces per transaction.
function invalidateNonces(address token, address spender, uint48 newNonce) external;;
```

### DOMAIN_SEPARATOR() (inherited from IEIP712)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 88:60:474

**Signature:**
```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
