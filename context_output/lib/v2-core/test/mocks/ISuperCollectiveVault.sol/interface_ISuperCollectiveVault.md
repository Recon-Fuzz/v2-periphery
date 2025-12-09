# Interface: ISuperCollectiveVault

## Metadata

- **Name**: ISuperCollectiveVault
- **Type**: Interface
- **Path**: lib/v2-core/test/mocks/ISuperCollectiveVault.sol

## Errors

### CLAIM_FAILED

```solidity
error CLAIM_FAILED();
```

### INVALID_VALUE

```solidity
error INVALID_VALUE();
```

### INVALID_TOKEN

```solidity
error INVALID_TOKEN();
```

### NOT_AUTHORIZED

```solidity
error NOT_AUTHORIZED();
```

### INVALID_AMOUNT

```solidity
error INVALID_AMOUNT();
```

### INVALID_ACCOUNT

```solidity
error INVALID_ACCOUNT();
```

### TOKEN_NOT_FOUND

```solidity
error TOKEN_NOT_FOUND();
```

### NO_LOCKED_ASSETS

```solidity
error NO_LOCKED_ASSETS();
```

### NOTHING_TO_CLAIM

```solidity
error NOTHING_TO_CLAIM();
```

### ALREADY_DISTRIBUTED

```solidity
error ALREADY_DISTRIBUTED();
```

### INVALID_MERKLE_ROOT

```solidity
error INVALID_MERKLE_ROOT();
```

### INVALID_CLAIM_TARGET

```solidity
error INVALID_CLAIM_TARGET();
```

## Events

### Lock

```solidity
event Lock(address indexed account, address indexed token, uint256 amount);
```

### Unlock

```solidity
event Unlock(address indexed account, address indexed token, uint256 amount);
```

### ClaimRewards

```solidity
event ClaimRewards(address indexed target, bytes result);
```

### BatchClaimRewards

```solidity
event BatchClaimRewards(address[] targets);
```

### DistributeRewards

```solidity
event DistributeRewards(bytes32 indexed merkleRoot, address indexed account, address indexed rewardToken, uint256 amount);
```

### MerkleRootUpdated

```solidity
event MerkleRootUpdated(bytes32 indexed merkleRoot, bool status);
```

## Public/External Functions

### isMerkleRootRegistered(bytes32)

- **Signature**: `isMerkleRootRegistered(bytes32)`
- **Visibility**: external
- **Source Range**: 1578:81:482

**Signature:**
```solidity
/// @notice Check if a merkle root is registered
///  @param merkleRoot The merkle root to check
function isMerkleRootRegistered(bytes32 merkleRoot) external view returns (bool);;
```

### viewLockedAmount(address,address)

- **Signature**: `viewLockedAmount(address,address)`
- **Visibility**: external
- **Source Range**: 1792:90:482

**Signature:**
```solidity
/// @notice Get the locked amount of an account for a token
///  @param account The account to get the locked amount for
function viewLockedAmount(address account, address token) external view returns (uint256);;
```

### viewAllLockedAssets(address)

- **Signature**: `viewAllLockedAssets(address)`
- **Visibility**: external
- **Source Range**: 2007:87:482

**Signature:**
```solidity
/// @notice Get all the locked assets of an account
///  @param account The account to get the locked assets for
function viewAllLockedAssets(address account) external view returns (address[] memory);;
```

### canClaim(bytes32,address,address,uint256,bytes32[])

- **Signature**: `canClaim(bytes32,address,address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 2386:217:482

**Signature:**
```solidity
/// @notice Check if an account can claim any reward
///  @param merkleRoot The merkle root to check
///  @param account The account to check
///  @param rewardToken The reward token to check
///  @param amount The amount to check
///  @param proof The proof to check
function canClaim(bytes32 merkleRoot, address account, address rewardToken, uint256 amount, bytes32[] calldata proof) external view returns (bool);;
```

### updateMerkleRoot(bytes32,bool)

- **Signature**: `updateMerkleRoot(bytes32,bool)`
- **Visibility**: external
- **Source Range**: 2969:68:482

**Signature:**
```solidity
/// @notice Update the merkle root
///  @param merkleRoot The merkle root to update
///  @param status The status of the merkle root (true: active, false: inactive)
function updateMerkleRoot(bytes32 merkleRoot, bool status) external;;
```

### lock(address,address,address,uint256)

- **Signature**: `lock(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3481:85:482

**Signature:**
```solidity
/// @notice Lock an asset for an account
///  @param account The account to lock the asset for
///  @param token The asset to lock
///  @param hook The hook to lock the asset through
///  @param amount The amount of the asset to lock
function lock(address account, address token, address hook, uint256 amount) external;;
```

### unlock(address,address,uint256)

- **Signature**: `unlock(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3774:73:482

**Signature:**
```solidity
/// @notice Unlock an asset for an account
///  @param account The account to unlock the asset for
///  @param token The asset to unlock
///  @param amount The amount of the asset to unlock
function unlock(address account, address token, uint256 amount) external;;
```

### batchUnlock(address,address[],uint256[])

- **Signature**: `batchUnlock(address,address[],uint256[])`
- **Visibility**: external
- **Source Range**: 4065:102:482

**Signature:**
```solidity
/// @notice Batch unlock assets for an account
///  @param account The account to unlock the assets for
///  @param tokens The assets to unlock
///  @param amounts The amounts of the assets to unlock
function batchUnlock(address account, address[] calldata tokens, uint256[] calldata amounts) external;;
```

### claim(address,uint256,uint16,bytes)

- **Signature**: `claim(address,uint256,uint16,bytes)`
- **Visibility**: external
- **Source Range**: 4437:113:482

**Signature:**
```solidity
/// @notice Claim rewards for an account
///  @param target The target to claim rewards from
///  @param gasLimit The gas limit for the claim
///  @param maxReturnDataCopy The maximum return data copy
///  @param data The data to pass to the target
function claim(address target, uint256 gasLimit, uint16 maxReturnDataCopy, bytes calldata data) external payable;;
```

### batchClaim(address[],uint256[],uint256[],uint16,bytes)

- **Signature**: `batchClaim(address[],uint256[],uint256[],uint16,bytes)`
- **Visibility**: external
- **Source Range**: 4875:227:482

**Signature:**
```solidity
/// @notice Batch claim rewards for multiple accounts
///  @param targets The targets to claim rewards from
///  @param gasLimit The gas limit for the claim
///  @param val The values to claim
///  @param maxReturnDataCopy The maximum return data copy
///  @param data The data to pass to the targets
function batchClaim(address[] calldata targets, uint256[] calldata gasLimit, uint256[] calldata val, uint16 maxReturnDataCopy, bytes calldata data) external payable;;
```

### distributeRewards(bytes32,address,address,uint256,bytes32[])

- **Signature**: `distributeRewards(bytes32,address,address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 5455:190:482

**Signature:**
```solidity
/// @notice Distribute rewards to an account
///  @param merkleRoot The merkle root to distribute the rewards from
///  @param account The account to distribute the rewards to
///  @param rewardToken The reward token to distribute
///  @param amount The amount to distribute
///  @param proof The proof to distribute the rewards
function distributeRewards(bytes32 merkleRoot, address account, address rewardToken, uint256 amount, bytes32[] calldata proof) external;;
```
