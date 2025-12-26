# Interface: ISignatureTransfer

## Metadata

- **Name**: ISignatureTransfer
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/uniswap/permit2/ISignatureTransfer.sol
- **Documentation**: @title SignatureTransfer
   @notice Handles ERC20 token transfers through signature based actions
   @dev Requires user's token approval on the Permit2 contract

## Implements Interfaces

- **IEIP712** [lib/v2-core/src/vendor/uniswap/permit2/IEIP712.sol/interface_IEIP712.md]

## Structs

### TokenPermissions

```solidity
/// @notice The token and amount details for a transfer signed in the permit transfer signature
struct TokenPermissions {
    address token;
    uint256 amount;
}
```

### PermitTransferFrom

```solidity
/// @notice The signed permit message for a single token transfer
struct PermitTransferFrom {
    TokenPermissions permitted;
    uint256 nonce;
    uint256 deadline;
}
```

### SignatureTransferDetails

```solidity
/// @notice Specifies the recipient address and amount for batched transfers.
///  @dev Recipients and amounts correspond to the index of the signed token permissions array.
///  @dev Reverts if the requested amount is greater than the permitted signed amount.
struct SignatureTransferDetails {
    address to;
    uint256 requestedAmount;
}
```

### PermitBatchTransferFrom

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

## Errors

### InvalidAmount

```solidity
/// @notice Thrown when the requested amount for a transfer is larger than the permissioned amount
///  @param maxAmount The maximum amount a spender can request to transfer
error InvalidAmount(uint256 maxAmount);
```

### LengthMismatch

```solidity
/// @notice Thrown when the number of tokens permissioned to a spender does not match the number of tokens being
///  transferred
///  @dev If the spender does not need to transfer the number of tokens permitted, the spender can request amount 0
///  to be transferred
error LengthMismatch();
```

## Events

### UnorderedNonceInvalidation

```solidity
/// @notice Emits an event when the owner successfully invalidates an unordered nonce.
event UnorderedNonceInvalidation(address indexed owner, uint256 word, uint256 mask);
```

## Public/External Functions

### nonceBitmap(address,uint256)

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

### permitTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes)

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

### permitWitnessTransferFrom(struct ISignatureTransfer.PermitTransferFrom,struct ISignatureTransfer.SignatureTransferDetails,address,bytes32,string,bytes)

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

### permitTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes)

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

### permitWitnessTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom,struct ISignatureTransfer.SignatureTransferDetails[],address,bytes32,string,bytes)

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

### invalidateUnorderedNonces(uint256,uint256)

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

### DOMAIN_SEPARATOR() (inherited from IEIP712)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 88:60:474

**Signature:**
```solidity
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
