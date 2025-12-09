# Contract: UpDistributor

## Metadata

- **Name**: UpDistributor
- **Type**: Contract
- **Path**: test/draft/src/UP/UpDistributor.sol
- **Documentation**:  @title UpDistributor
   @notice A contract for distributing tokens using a merkle tree for verification
   @dev The foundation can reclaim unclaimed tokens

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _pendingOwner (inherited from Ownable2Step)

```solidity
address private _pendingOwner
```

### token

```solidity
IERC20 public immutable token
```

**IERC20**: [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### merkleRoot

```solidity
bytes32 public merkleRoot
```

### hasClaimed

```solidity
/// @notice Track which addresses have claimed their tokens
mapping(address => bool) public hasClaimed
```

## Errors

### OwnableUnauthorizedAccount (inherited from Ownable)

```solidity
///  @dev The caller account is not authorized to perform an operation.
error OwnableUnauthorizedAccount(address account);
```

### OwnableInvalidOwner (inherited from Ownable)

```solidity
///  @dev The owner is not a valid owner account. (eg. `address(0)`)
error OwnableInvalidOwner(address owner);
```

### ALREADY_CLAIMED

```solidity
error ALREADY_CLAIMED();
```

### NO_TOKENS_TO_RECLAIM

```solidity
error NO_TOKENS_TO_RECLAIM();
```

### INVALID_MERKLE_PROOF

```solidity
error INVALID_MERKLE_PROOF();
```

### INVALID_TOKEN_ADDRESS

```solidity
error INVALID_TOKEN_ADDRESS();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### OwnershipTransferStarted (inherited from Ownable2Step)

```solidity
event OwnershipTransferStarted(address indexed previousOwner, address indexed newOwner);
```

### MerkleRootSet

```solidity
event MerkleRootSet(bytes32 merkleRoot);
```

### TokensClaimed

```solidity
event TokensClaimed(address indexed user, uint256 amount);
```

### TokensReclaimed

```solidity
event TokensReclaimed(uint256 amount);
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1249:177:551
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address _token, address initialOwner) Ownable(initialOwner);
```

### setMerkleRoot(bytes32)

- **Signature**: `setMerkleRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 1552:145:551
- **Details**: [function_setMerkleRoot_bytes32.md](./function_setMerkleRoot_bytes32.md)

**Signature:**
```solidity
///  @notice Set a new merkle root for the distribution
///  @param _merkleRoot The new merkle root
function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner();
```

### claim(uint256,bytes32[])

- **Signature**: `claim(uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 1899:592:551
- **Details**: [function_claim_uint256_bytes32[].md](./function_claim_uint256_bytes32[].md)

**Signature:**
```solidity
///  @notice Claim tokens if you are part of the merkle tree
///  @param amount The amount of tokens to claim
///  @param merkleProof A proof of inclusion in the merkle tree
function claim(uint256 amount, bytes32[] calldata merkleProof) external;
```

### claimOnBehalf(address,uint256,bytes32[])

- **Signature**: `claimOnBehalf(address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 2799:614:551
- **Details**: [function_claimOnBehalf_address_uint256_bytes32[].md](./function_claimOnBehalf_address_uint256_bytes32[].md)

**Signature:**
```solidity
///  @notice Claim tokens for a recipient
///  @dev This function can be called by users with smart accounts
///  @param recipient The address to claim tokens for
///  @param amount The amount of tokens to claim
///  @param merkleProof A proof of inclusion in the merkle tree
function claimOnBehalf(address recipient, uint256 amount, bytes32[] calldata merkleProof) external;
```

### reclaimTokens(uint256)

- **Signature**: `reclaimTokens(uint256)`
- **Visibility**: external
- **Source Range**: 3552:268:551
- **Details**: [function_reclaimTokens_uint256.md](./function_reclaimTokens_uint256.md)

**Signature:**
```solidity
///  @notice Allow the foundation to reclaim unclaimed tokens
///  @param amount The amount of tokens to reclaim
function reclaimTokens(uint256 amount) external onlyOwner();
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1638:85:251
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 2293:101:251
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2543:215:251
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```

### pendingOwner() (inherited from Ownable2Step)

- **Signature**: `pendingOwner()`
- **Visibility**: public
- **Source Range**: 1232:99:252
- **Details**: [function_pendingOwner.md](./function_pendingOwner.md)

**Signature:**
```solidity
///  @dev Returns the address of the pending owner.
function pendingOwner() virtual public view returns (address);
```

### acceptOwnership() (inherited from Ownable2Step)

- **Signature**: `acceptOwnership()`
- **Visibility**: public
- **Source Range**: 2244:229:252
- **Details**: [function_acceptOwnership.md](./function_acceptOwnership.md)

**Signature:**
```solidity
///  @dev The new owner accepts the ownership transfer.
function acceptOwnership() virtual public;
```
