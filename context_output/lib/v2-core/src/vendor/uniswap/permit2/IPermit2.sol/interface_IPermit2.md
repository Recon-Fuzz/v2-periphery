# Interface: IPermit2

## Metadata

- **Name**: IPermit2
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/uniswap/permit2/IPermit2.sol
- **Documentation**: @notice Permit2 handles signature-based transfers in SignatureTransfer and allowance-based transfers in
   AllowanceTransfer.
   @dev Users must approve Permit2 before calling any of the transfer functions.

## Implements Interfaces

- **IAllowanceTransfer** [lib/v2-core/src/vendor/uniswap/permit2/IAllowanceTransfer.sol/interface_IAllowanceTransfer.md]
- **ISignatureTransfer** [lib/v2-core/src/vendor/uniswap/permit2/ISignatureTransfer.sol/interface_ISignatureTransfer.md]
- **IEIP712** [lib/v2-core/src/vendor/uniswap/permit2/IEIP712.sol/interface_IEIP712.md]

## Structs

### TokenPermissions (inherited from ISignatureTransfer)

```solidity
/// @notice The token and amount details for a transfer signed in the permit transfer signature
struct TokenPermissions {
    address token;
    uint256 amount;
}
```

### PermitTransferFrom (inherited from ISignatureTransfer)

```solidity
/// @notice The signed permit message for a single token transfer
struct PermitTransferFrom {
    TokenPermissions permitted;
    uint256 nonce;
    uint256 deadline;
}
```

### SignatureTransferDetails (inherited from ISignatureTransfer)

```solidity
/// @notice Specifies the recipient address and amount for batched transfers.
///  @dev Recipients and amounts correspond to the index of the signed token permissions array.
///  @dev Reverts if the requested amount is greater than the permitted signed amount.
struct SignatureTransferDetails {
    address to;
    uint256 requestedAmount;
}
```

### PermitBatchTransferFrom (inherited from ISignatureTransfer)

```solidity
/// @notice Used to reconstruct the signed permit message for multiple token transfers
///  @dev Do not need to pass in spender address as it is required that it is msg.sender
///  @dev Note that a user still signs over a spender address
struct PermitBatchTransferFrom {
    TokenPermissions[] permitted;
    uint256 nonce;
    uint256 deadline;
}
```

### PermitDetails (inherited from IAllowanceTransfer)

```solidity
/// @notice The permit data for a token
struct PermitDetails {
    address token;
    uint160 amount;
    uint48 expiration;
    uint48 nonce;
}
```

### PermitSingle (inherited from IAllowanceTransfer)

```solidity
/// @notice The permit message signed for a single token allowance
struct PermitSingle {
    PermitDetails details;
    address spender;
    uint256 sigDeadline;
}
```

### PermitBatch (inherited from IAllowanceTransfer)

```solidity
/// @notice The permit message signed for multiple token allowances
struct PermitBatch {
    PermitDetails[] details;
    address spender;
    uint256 sigDeadline;
}
```

### PackedAllowance (inherited from IAllowanceTransfer)

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

### TokenSpenderPair (inherited from IAllowanceTransfer)

```solidity
/// @notice A token spender pair.
struct TokenSpenderPair {
    address token;
    address spender;
}
```

### AllowanceTransferDetails (inherited from IAllowanceTransfer)

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

### InvalidAmount (inherited from ISignatureTransfer)

```solidity
/// @notice Thrown when the requested amount for a transfer is larger than the permissioned amount
///  @param maxAmount The maximum amount a spender can request to transfer
error InvalidAmount(uint256 maxAmount);
```

### LengthMismatch (inherited from ISignatureTransfer)

```solidity
/// @notice Thrown when the number of tokens permissioned to a spender does not match the number of tokens being
///  transferred
///  @dev If the spender does not need to transfer the number of tokens permitted, the spender can request amount 0
///  to be transferred
error LengthMismatch();
```

### AllowanceExpired (inherited from IAllowanceTransfer)

```solidity
/// @notice Thrown when an allowance on a token has expired.
///  @param deadline The timestamp at which the allowed amount is no longer valid
error AllowanceExpired(uint256 deadline);
```

### InsufficientAllowance (inherited from IAllowanceTransfer)

```solidity
/// @notice Thrown when an allowance on a token has been depleted.
///  @param amount The maximum amount allowed
error InsufficientAllowance(uint256 amount);
```

### ExcessiveInvalidation (inherited from IAllowanceTransfer)

```solidity
/// @notice Thrown when too many nonces are invalidated.
error ExcessiveInvalidation();
```

## Events

### UnorderedNonceInvalidation (inherited from ISignatureTransfer)

```solidity
/// @notice Emits an event when the owner successfully invalidates an unordered nonce.
event UnorderedNonceInvalidation(address indexed owner, uint256 word, uint256 mask);
```

### NonceInvalidation (inherited from IAllowanceTransfer)

```solidity
/// @notice Emits an event when the owner successfully invalidates an ordered nonce.
event NonceInvalidation(address indexed owner, address indexed token, address indexed spender, uint48 newNonce, uint48 oldNonce);
```

### Approval (inherited from IAllowanceTransfer)

```solidity
/// @notice Emits an event when the owner successfully sets permissions on a token for the spender.
event Approval(address indexed owner, address indexed token, address indexed spender, uint160 amount, uint48 expiration);
```

### Permit (inherited from IAllowanceTransfer)

```solidity
/// @notice Emits an event when the owner successfully sets permissions using a permit signature on a token for the
///  spender.
event Permit(address indexed owner, address indexed token, address indexed spender, uint160 amount, uint48 expiration, uint48 nonce);
```

### Lockdown (inherited from IAllowanceTransfer)

```solidity
/// @notice Emits an event when the owner sets the allowance back to 0 with the lockdown function.
event Lockdown(address indexed owner, address token, address spender);
```

## Public/External Functions

### DOMAIN_SEPARATOR() (inherited from IEIP712)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 88:60:474

**Signature:**
```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```

### nonceBitmap(address,uint256) (inherited from ISignatureTransfer)

- **Signature**: `nonceBitmap(address,uint256)`
- **Visibility**: external
- **Source Range**: 3142:71:477

**Signature:**
```solidity
/// @notice A map from token owner address and a caller specified word index to a bitmap. Used to set bits in the
///  bitmap to prevent against signature replay protection
///  @dev Uses unordered nonces so that permit messages do not need to be spent in a certain order
///  @dev The mapping is indexed first by the token owner, then by an index specified in the nonce
///  @dev It returns a uint256 bitmap
///  @dev The index, or wordPosition is capped at type(uint248).max
function nonceBitmap(address, uint256) external view returns (uint256);;
```

### permitTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes) (inherited from ISignatureTransfer)

- **Signature**: `permitTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes)`
- **Visibility**: external
- **Source Range**: 3637:209:477

**Signature:**
```solidity
/// @notice Transfers a token using a signed permit message
///  @dev Reverts if the requested amount is greater than the permitted signed amount
///  @param permit The permit data signed over by the owner
///  @param owner The owner of the tokens to transfer
///  @param transferDetails The spender's requested transfer details for the permitted token
///  @param signature The signature to verify
function permitTransferFrom(PermitTransferFrom memory permit, SignatureTransferDetails calldata transferDetails, address owner, bytes calldata signature) external;;
```

### permitWitnessTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes32,string,bytes) (inherited from ISignatureTransfer)

- **Signature**: `permitWitnessTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes32,string,bytes)`
- **Visibility**: external
- **Source Range**: 4680:284:477

**Signature:**
```solidity
/// @notice Transfers a token using a signed permit message
///  @notice Includes extra data provided by the caller to verify signature over
///  @dev The witness type string must follow EIP712 ordering of nested structs and must include the TokenPermissions
///  type definition
///  @dev Reverts if the requested amount is greater than the permitted signed amount
///  @param permit The permit data signed over by the owner
///  @param owner The owner of the tokens to transfer
///  @param transferDetails The spender's requested transfer details for the permitted token
///  @param witness Extra data to include when checking the user signature
///  @param witnessTypeString The EIP-712 type definition for remaining string stub of the typehash
///  @param signature The signature to verify
function permitWitnessTransferFrom(PermitTransferFrom memory permit, SignatureTransferDetails calldata transferDetails, address owner, bytes32 witness, string calldata witnessTypeString, bytes calldata signature) external;;
```

### permitTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes) (inherited from ISignatureTransfer)

- **Signature**: `permitTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes)`
- **Visibility**: external
- **Source Range**: 5310:216:477

**Signature:**
```solidity
/// @notice Transfers multiple tokens using a signed permit message
///  @param permit The permit data signed over by the owner
///  @param owner The owner of the tokens to transfer
///  @param transferDetails Specifies the recipient and requested amount for the token transfer
///  @param signature The signature to verify
function permitTransferFrom(PermitBatchTransferFrom memory permit, SignatureTransferDetails[] calldata transferDetails, address owner, bytes calldata signature) external;;
```

### permitWitnessTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes32,string,bytes) (inherited from ISignatureTransfer)

- **Signature**: `permitWitnessTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes32,string,bytes)`
- **Visibility**: external
- **Source Range**: 6282:291:477

**Signature:**
```solidity
/// @notice Transfers multiple tokens using a signed permit message
///  @dev The witness type string must follow EIP712 ordering of nested structs and must include the TokenPermissions
///  type definition
///  @notice Includes extra data provided by the caller to verify signature over
///  @param permit The permit data signed over by the owner
///  @param owner The owner of the tokens to transfer
///  @param transferDetails Specifies the recipient and requested amount for the token transfer
///  @param witness Extra data to include when checking the user signature
///  @param witnessTypeString The EIP-712 type definition for remaining string stub of the typehash
///  @param signature The signature to verify
function permitWitnessTransferFrom(PermitBatchTransferFrom memory permit, SignatureTransferDetails[] calldata transferDetails, address owner, bytes32 witness, string calldata witnessTypeString, bytes calldata signature) external;;
```

### invalidateUnorderedNonces(uint256,uint256) (inherited from ISignatureTransfer)

- **Signature**: `invalidateUnorderedNonces(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 6878:75:477

**Signature:**
```solidity
/// @notice Invalidates the bits specified in mask for the bitmap at the word position
///  @dev The wordPos is maxed at type(uint248).max
///  @param wordPos A number to index the nonceBitmap at
///  @param mask A bitmap masked against msg.sender's current bitmap at the word position
function invalidateUnorderedNonces(uint256 wordPos, uint256 mask) external;;
```

### allowance(address,address,address) (inherited from IAllowanceTransfer)

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

### approve(address,address,uint160,uint48) (inherited from IAllowanceTransfer)

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

### permit(address,struct IAllowanceTransfer.PermitSingle,bytes) (inherited from IAllowanceTransfer)

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

### permit(address,struct IAllowanceTransfer.PermitBatch,bytes) (inherited from IAllowanceTransfer)

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

### transferFrom(address,address,uint160,address) (inherited from IAllowanceTransfer)

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

### transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[]) (inherited from IAllowanceTransfer)

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

### lockdown(struct IAllowanceTransfer.TokenSpenderPair[]) (inherited from IAllowanceTransfer)

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

### invalidateNonces(address,address,uint48) (inherited from IAllowanceTransfer)

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
