# Interface: IVaultBank

## Metadata

- **Name**: IVaultBank
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/superform/IVaultBank.sol

## Implements Interfaces

- **IHookExecutionData** [lib/v2-core/src/vendor/superform/IHookExecutionData.sol/interface_IHookExecutionData.md]

## Structs

### HookExecutionData (inherited from IHookExecutionData)

```solidity
/// @notice Data required for executing hooks with Merkle proof verification.
///  @param hooks Array of addresses of hooks to execute.
///  @param data Array of arbitrary data to pass to each hook.
///  @param merkleProofs Double array of Merkle proofs verifying each hook's allowed targets.
struct HookExecutionData {
    address[] hooks;
    bytes[] data;
    bytes32[][] merkleProofs;
}
```

### SourceAssetInfo

```solidity
struct SourceAssetInfo {
    bytes32 yieldSourceOracleId;
    uint64 chainId;
    address asset;
    string name;
    string symbol;
    uint8 decimals;
}
```

## Errors

### INVALID_VALUE

```solidity
error INVALID_VALUE();
```

### INVALID_CHAIN

```solidity
error INVALID_CHAIN();
```

### NOT_AUTHORIZED

```solidity
error NOT_AUTHORIZED();
```

### INVALID_RELAYER

```solidity
error INVALID_RELAYER();
```

### INVALID_EXECUTOR

```solidity
error INVALID_EXECUTOR();
```

### NONCE_ALREADY_USED

```solidity
error NONCE_ALREADY_USED();
```

### ALREADY_DISTRIBUTED

```solidity
error ALREADY_DISTRIBUTED();
```

### INVALID_PROOF_CHAIN

```solidity
error INVALID_PROOF_CHAIN();
```

### INVALID_PROOF_EVENT

```solidity
error INVALID_PROOF_EVENT();
```

### INVALID_PROOF_TOKEN

```solidity
error INVALID_PROOF_TOKEN();
```

### INVALID_PROOF_AMOUNT

```solidity
error INVALID_PROOF_AMOUNT();
```

### INVALID_BANK_MANAGER

```solidity
error INVALID_BANK_MANAGER();
```

### INVALID_PROOF_ACCOUNT

```solidity
error INVALID_PROOF_ACCOUNT();
```

### INVALID_PROOF_EMITTER

```solidity
error INVALID_PROOF_EMITTER();
```

### INVALID_PROOF_SOURCE_CHAIN

```solidity
error INVALID_PROOF_SOURCE_CHAIN();
```

### INVALID_VAULT_BANK_ADDRESS

```solidity
error INVALID_VAULT_BANK_ADDRESS();
```

### INVALID_PROOF_TARGETED_CHAIN

```solidity
error INVALID_PROOF_TARGETED_CHAIN();
```

## Events

### BatchDistributeRewardsToSuperBank

```solidity
event BatchDistributeRewardsToSuperBank(address[] indexed rewards, uint256[] amounts);
```

### SuperpositionsMinted

```solidity
event SuperpositionsMinted(address indexed account, address indexed spAddress, address indexed srcTokenAddress, uint256 amount, uint64 srcChain, uint256 nonce);
```

### SuperpositionsBurned

```solidity
event SuperpositionsBurned(address indexed account, address indexed spAddress, address indexed srcTokenAddress, uint256 amount, uint64 srcChain, uint256 nonce);
```

### DestinationChainUpdated

```solidity
event DestinationChainUpdated(uint64 indexed dstChainId, bool status);
```

### RelayerUpdated

```solidity
event RelayerUpdated(address indexed relayer, bool status);
```

### ProverUpdated

```solidity
event ProverUpdated(address indexed prover);
```

## Public/External Functions

### lockAsset(bytes32,address,address,address,uint256,uint64)

- **Signature**: `lockAsset(bytes32,address,address,address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 6174:206:472

**Signature:**
```solidity
/// @notice Lock an asset for an account
///  @dev This function is used to lock an asset for an account
///  @param yieldSourceOracleId The yield source oracle ID
///  @param account The account to lock the asset for
///  @param token The asset to lock
///  @param hookAddress The hook address to lock the asset through
///  @param amount The amount of the asset to lock
///  @param toChainId The destination chain ID
function lockAsset(bytes32 yieldSourceOracleId, address account, address token, address hookAddress, uint256 amount, uint64 toChainId) external;;
```

### distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)

- **Signature**: `distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)`
- **Visibility**: external
- **Source Range**: 6686:189:472

**Signature:**
```solidity
/// @notice Creates or retrieves synthethic asset and distributes it to the account
///  @param account_ The account to lock the asset for
///  @param amount_ The amount of the asset to lock
///  @param sourceAssetInfo_ The source asset info
///  @param proof_ The proof of the event
function distributeSuperPosition(address account_, uint256 amount_, SourceAssetInfo calldata sourceAssetInfo_, bytes calldata proof_) external;;
```

### burnSuperPosition(uint256,address,uint64,bytes32)

- **Signature**: `burnSuperPosition(uint256,address,uint64,bytes32)`
- **Visibility**: external
- **Source Range**: 7214:169:472

**Signature:**
```solidity
/// @notice Burns a synthetic asset
///  @dev Should be requested by the account owning the SP assets
///  @param amount_ The amount of the asset to burn
///  @param spAddress_ The synthetic asset address
///  @param forChainId_ The destination chain ID
///  @param yieldSourceOracleId_ The yield source oracle ID
function burnSuperPosition(uint256 amount_, address spAddress_, uint64 forChainId_, bytes32 yieldSourceOracleId_) external;;
```

### unlockAsset(address,address,uint256,uint64,bytes32,bytes)

- **Signature**: `unlockAsset(address,address,uint256,uint64,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 7846:212:472

**Signature:**
```solidity
/// @notice Unlock an asset for an account
///  @param account The account to unlock the asset for
///  @param token The asset to unlock
///  @param amount The amount of the asset to unlock
///  @param fromChainId The `from` (destination) chain
///  @param yieldSourceOracleId The yield source oracle ID
///  @param proof_ The proof of the `burnSuperPosition` event
function unlockAsset(address account, address token, uint256 amount, uint64 fromChainId, bytes32 yieldSourceOracleId, bytes calldata proof_) external;;
```

### executeHooks(struct IHookExecutionData.HookExecutionData)

- **Signature**: `executeHooks(struct IHookExecutionData.HookExecutionData)`
- **Visibility**: external
- **Source Range**: 8237:84:472

**Signature:**
```solidity
/// @notice Execute hooks
///  @dev Used to claim rewards
///  @param executionData The execution data
function executeHooks(IVaultBank.HookExecutionData calldata executionData) external;;
```

### batchDistributeRewardsToSuperBank(address[],uint256[])

- **Signature**: `batchDistributeRewardsToSuperBank(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 8485:104:472

**Signature:**
```solidity
/// @notice Batch distribute rewards to the super bank
///  @param rewards The rewards to distribute
///  @param amounts The amounts of the rewards
function batchDistributeRewardsToSuperBank(address[] memory rewards, uint256[] memory amounts) external;;
```
