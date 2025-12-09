# Contract: VaultBank

## Metadata

- **Name**: VaultBank
- **Type**: Contract
- **Path**: test/draft/src/VaultBank/VaultBank.sol
- **Documentation**: @title VaultBank
   @author Superform Labs
   @notice Locks assets and mints SuperPositions

## Implements Interfaces

- **IVaultBankDestination** [test/draft/src/interfaces/VaultBank/IVaultBank.sol/interface_IVaultBankDestination.md]
- **IVaultBankSource** [test/draft/src/interfaces/VaultBank/IVaultBank.sol/interface_IVaultBankSource.md]
- **IVaultBank** [test/draft/src/interfaces/VaultBank/IVaultBank.sol/interface_IVaultBank.md]
- **IHookExecutionData** [src/interfaces/IHookExecutionData.sol/interface_IHookExecutionData.md]

## State Variables

### _lockedAssets (inherited from VaultBankSource)

```solidity
EnumerableSet.AddressSet internal _lockedAssets
```

### _lockedAmounts (inherited from VaultBankSource)

```solidity
mapping(address => uint256) internal _lockedAmounts
```

### _chainId (inherited from VaultBankSource)

```solidity
uint64 internal immutable _chainId
```

### _tokenToSuperPosition (inherited from VaultBankDestination)

```solidity
mapping(uint64 => mapping(bytes32 => mapping(address => address))) internal _tokenToSuperPosition
```

### _spAssetsInfo (inherited from VaultBankDestination)

```solidity
mapping(address => SpAsset) internal _spAssetsInfo
```

### NOT_ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant ENTERED = 2
```

### _status (inherited from ReentrancyGuard)

```solidity
uint256 private _status
```

### SUPER_GOVERNOR

```solidity
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### SUPER_REGISTRY

```solidity
ISuperRegistry public immutable SUPER_REGISTRY
```

**ISuperRegistry**: [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

### nonces

```solidity
mapping(uint64 => uint256) public nonces
```

### noncesUsed

```solidity
mapping(uint64 => mapping(uint256 => bool)) public noncesUsed
```

## Structs

### HookExecutionData (inherited from IHookExecutionData)

```solidity
/// @notice Data required for executing hooks with Merkle proof verification.
///  @param hooks Array of addresses of hooks to execute.
///  @param data Array of arbitrary data to pass to each hook.
///  @param merkleProofs Double array of Merkle proofs verifying each hook's allowed targets.
///  @param expectedAssetsOrSharesOut Array of minimum expected output amounts for slippage protection.
struct HookExecutionData {
    address[] hooks;
    bytes[] data;
    bytes32[][] merkleProofs;
    uint256[] expectedAssetsOrSharesOut;
}
```

### SourceAssetInfo (inherited from IVaultBank)

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

### SpAsset (inherited from IVaultBankDestination)

```solidity
struct SpAsset {
    bool wasCreated;
    mapping(uint64 => mapping(bytes32 => address)) spToToken;
}
```

## Errors

### INVALID_VALUE (inherited from IVaultBank)

```solidity
error INVALID_VALUE();
```

### INVALID_CHAIN (inherited from IVaultBank)

```solidity
error INVALID_CHAIN();
```

### NOT_AUTHORIZED (inherited from IVaultBank)

```solidity
error NOT_AUTHORIZED();
```

### INVALID_RELAYER (inherited from IVaultBank)

```solidity
error INVALID_RELAYER();
```

### INVALID_EXECUTOR (inherited from IVaultBank)

```solidity
error INVALID_EXECUTOR();
```

### NONCE_ALREADY_USED (inherited from IVaultBank)

```solidity
error NONCE_ALREADY_USED();
```

### ALREADY_DISTRIBUTED (inherited from IVaultBank)

```solidity
error ALREADY_DISTRIBUTED();
```

### INVALID_PROOF_CHAIN (inherited from IVaultBank)

```solidity
error INVALID_PROOF_CHAIN();
```

### INVALID_PROOF_EVENT (inherited from IVaultBank)

```solidity
error INVALID_PROOF_EVENT();
```

### INVALID_PROOF_TOKEN (inherited from IVaultBank)

```solidity
error INVALID_PROOF_TOKEN();
```

### INVALID_PROOF_AMOUNT (inherited from IVaultBank)

```solidity
error INVALID_PROOF_AMOUNT();
```

### INVALID_BANK_MANAGER (inherited from IVaultBank)

```solidity
error INVALID_BANK_MANAGER();
```

### INVALID_PROOF_ACCOUNT (inherited from IVaultBank)

```solidity
error INVALID_PROOF_ACCOUNT();
```

### INVALID_PROOF_EMITTER (inherited from IVaultBank)

```solidity
error INVALID_PROOF_EMITTER();
```

### INVALID_PROOF_SOURCE_CHAIN (inherited from IVaultBank)

```solidity
error INVALID_PROOF_SOURCE_CHAIN();
```

### INVALID_VAULT_BANK_ADDRESS (inherited from IVaultBank)

```solidity
error INVALID_VAULT_BANK_ADDRESS();
```

### INVALID_PROOF_TARGETED_CHAIN (inherited from IVaultBank)

```solidity
error INVALID_PROOF_TARGETED_CHAIN();
```

### CLAIM_FAILED (inherited from IVaultBankSource)

```solidity
error CLAIM_FAILED();
```

### INVALID_TOKEN (inherited from IVaultBankSource)

```solidity
error INVALID_TOKEN();
```

### INVALID_AMOUNT (inherited from IVaultBankSource)

```solidity
error INVALID_AMOUNT();
```

### INVALID_ACCOUNT (inherited from IVaultBankSource)

```solidity
error INVALID_ACCOUNT();
```

### TOKEN_NOT_FOUND (inherited from IVaultBankSource)

```solidity
error TOKEN_NOT_FOUND();
```

### NO_LOCKED_ASSETS (inherited from IVaultBankSource)

```solidity
error NO_LOCKED_ASSETS();
```

### INVALID_CLAIM_TARGET (inherited from IVaultBankSource)

```solidity
error INVALID_CLAIM_TARGET();
```

### INVALID_YIELD_SOURCE_ORACLE_ID (inherited from IVaultBankSource)

```solidity
error INVALID_YIELD_SOURCE_ORACLE_ID();
```

### INVALID_PROOF_YIELD_SOURCE_ORACLE_ID (inherited from IVaultBankSource)

```solidity
error INVALID_PROOF_YIELD_SOURCE_ORACLE_ID();
```

### INVALID_BURN_AMOUNT (inherited from IVaultBankDestination)

```solidity
error INVALID_BURN_AMOUNT();
```

### SUPERPOSITION_ASSET_NOT_FOUND (inherited from IVaultBankDestination)

```solidity
error SUPERPOSITION_ASSET_NOT_FOUND();
```

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuard)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

### INVALID_HOOK (inherited from Bank)

```solidity
error INVALID_HOOK();
```

### INVALID_MERKLE_PROOF (inherited from Bank)

```solidity
error INVALID_MERKLE_PROOF();
```

### HOOK_VALIDATION_FAILED (inherited from Bank)

```solidity
error HOOK_VALIDATION_FAILED();
```

### HOOK_EXECUTION_FAILED (inherited from Bank)

```solidity
error HOOK_EXECUTION_FAILED();
```

### HOOK_NOT_REGISTERED (inherited from Bank)

```solidity
error HOOK_NOT_REGISTERED();
```

### ZERO_LENGTH_ARRAY (inherited from Bank)

```solidity
error ZERO_LENGTH_ARRAY();
```

### ZERO_AMOUNT (inherited from Bank)

```solidity
error ZERO_AMOUNT();
```

### INVALID_ARRAY_LENGTH (inherited from Bank)

```solidity
error INVALID_ARRAY_LENGTH();
```

### ZERO_ADDRESS (inherited from Bank)

```solidity
error ZERO_ADDRESS();
```

### MINIMUM_OUTPUT_AMOUNT_NOT_MET (inherited from Bank)

```solidity
error MINIMUM_OUTPUT_AMOUNT_NOT_MET();
```

## Events

### BatchDistributeRewardsToSuperBank (inherited from IVaultBank)

```solidity
event BatchDistributeRewardsToSuperBank(address[] indexed rewards, uint256[] amounts);
```

### SuperpositionsMinted (inherited from IVaultBank)

```solidity
event SuperpositionsMinted(address indexed account, address indexed spAddress, address indexed srcTokenAddress, uint256 amount, uint64 srcChain, uint256 nonce);
```

### SuperpositionsBurned (inherited from IVaultBank)

```solidity
event SuperpositionsBurned(address indexed account, address indexed spAddress, address indexed srcTokenAddress, uint256 amount, uint64 srcChain, uint256 nonce);
```

### DestinationChainUpdated (inherited from IVaultBank)

```solidity
event DestinationChainUpdated(uint64 indexed dstChainId, bool status);
```

### RelayerUpdated (inherited from IVaultBank)

```solidity
event RelayerUpdated(address indexed relayer, bool status);
```

### ProverUpdated (inherited from IVaultBank)

```solidity
event ProverUpdated(address indexed prover);
```

### SharesLocked (inherited from IVaultBankSource)

```solidity
event SharesLocked(bytes32 indexed yieldSourceOracleId, address indexed account, address indexed token, uint256 amount, uint256 srcChainId, uint256 dstChainId, uint256 nonce);
```

### SharesUnlocked (inherited from IVaultBankSource)

```solidity
event SharesUnlocked(bytes32 indexed yieldSourceOracleId, address indexed account, address indexed token, uint256 amount, uint256 srcChainId, uint256 dstChainId, uint256 nonce);
```

### HooksExecuted (inherited from Bank)

```solidity
/// @notice Emitted when hooks are executed.
///  @param hooks The addresses of the hooks that were executed.
///  @param data The data passed to each hook.
event HooksExecuted(address[] hooks, bytes[] data);
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1625:249:552
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address governor_, address registry_);
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 2256:30:552
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
/// @dev to receive ETH rewards
receive() external payable;
```

### lockAsset(bytes32,address,address,address,uint256,uint64)

- **Signature**: `lockAsset(bytes32,address,address,address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 2581:608:552
- **Details**: [function_lockAsset_bytes32_address_address_address_uint256_uint64.md](./function_lockAsset_bytes32_address_address_address_uint256_uint64.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function lockAsset(bytes32 yieldSourceOracleId, address account, address token, address hookAddress, uint256 amount, uint64 toChainId) external;
```

### unlockAsset(address,address,uint256,uint64,bytes32,bytes)

- **Signature**: `unlockAsset(address,address,uint256,uint64,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 3226:611:552
- **Details**: [function_unlockAsset_address_address_uint256_uint64_bytes32_bytes.md](./function_unlockAsset_address_address_uint256_uint64_bytes32_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function unlockAsset(address account, address token, uint256 amount, uint64 fromChainId, bytes32 yieldSourceOracleId, bytes calldata proof) external;
```

### executeHooks(struct IHookExecutionData.HookExecutionData)

- **Signature**: `executeHooks(struct IHookExecutionData.HookExecutionData)`
- **Visibility**: external
- **Source Range**: 3874:145:552
- **Details**: [function_executeHooks_struct_IHookExecutionData.HookExecutionData.md](./function_executeHooks_struct_IHookExecutionData.HookExecutionData.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function executeHooks(IVaultBank.HookExecutionData calldata executionData) external onlyBankManager();
```

### batchDistributeRewardsToSuperBank(address[],uint256[])

- **Signature**: `batchDistributeRewardsToSuperBank(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 4056:386:552
- **Details**: [function_batchDistributeRewardsToSuperBank_address[]_uint256[].md](./function_batchDistributeRewardsToSuperBank_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function batchDistributeRewardsToSuperBank(address[] memory rewards, uint256[] memory amounts) external onlyRelayer();
```

### distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)

- **Signature**: `distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)`
- **Visibility**: external
- **Source Range**: 4554:978:552
- **Details**: [function_distributeSuperPosition_address_uint256_struct_IVaultBank.SourceAssetInfo_bytes.md](./function_distributeSuperPosition_address_uint256_struct_IVaultBank.SourceAssetInfo_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function distributeSuperPosition(address account_, uint256 amount_, SourceAssetInfo calldata sourceAsset_, bytes calldata proof_) override external onlyRelayer();
```

### burnSuperPosition(uint256,address,uint64,bytes32)

- **Signature**: `burnSuperPosition(uint256,address,uint64,bytes32)`
- **Visibility**: external
- **Source Range**: 5569:567:552
- **Details**: [function_burnSuperPosition_uint256_address_uint64_bytes32.md](./function_burnSuperPosition_uint256_address_uint64_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBank
function burnSuperPosition(uint256 amount_, address spAddress_, uint64 forChainId_, bytes32 yieldSourceOracleId_) override external;
```

### transferSuperPositionOwnership(address,address)

- **Signature**: `transferSuperPositionOwnership(address,address)`
- **Visibility**: external
- **Source Range**: 6142:178:552
- **Details**: [function_transferSuperPositionOwnership_address_address.md](./function_transferSuperPositionOwnership_address_address.md)

**Signature:**
```solidity
function transferSuperPositionOwnership(address superPos, address newOwner) external onlyBankManager();
```

### viewTotalLockedAsset(address) (inherited from VaultBankSource)

- **Signature**: `viewTotalLockedAsset(address)`
- **Visibility**: external
- **Source Range**: 1339:122:554
- **Details**: [function_viewTotalLockedAsset_address.md](./function_viewTotalLockedAsset_address.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBankSource
function viewTotalLockedAsset(address token) external view returns (uint256);
```

### viewAllLockedAssets() (inherited from VaultBankSource)

- **Signature**: `viewAllLockedAssets()`
- **Visibility**: external
- **Source Range**: 1504:118:554
- **Details**: [function_viewAllLockedAssets.md](./function_viewAllLockedAssets.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBankSource
function viewAllLockedAssets() external view returns (address[] memory);
```

### getSuperPositionForAsset(uint64,address,bytes32) (inherited from VaultBankDestination)

- **Signature**: `getSuperPositionForAsset(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 982:278:553
- **Details**: [function_getSuperPositionForAsset_uint64_address_bytes32.md](./function_getSuperPositionForAsset_uint64_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBankDestination
function getSuperPositionForAsset(uint64 srcChainId, address srcAsset, bytes32 yieldSourceOracleId) external view returns (address);
```

### getAssetForSuperPosition(uint64,address,bytes32) (inherited from VaultBankDestination)

- **Signature**: `getAssetForSuperPosition(uint64,address,bytes32)`
- **Visibility**: external
- **Source Range**: 1308:290:553
- **Details**: [function_getAssetForSuperPosition_uint64_address_bytes32.md](./function_getAssetForSuperPosition_uint64_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBankDestination
function getAssetForSuperPosition(uint64 srcChainId, address superPosition, bytes32 yieldSourceOracleId) external view returns (address);
```

### isSuperPositionCreated(address) (inherited from VaultBankDestination)

- **Signature**: `isSuperPositionCreated(address)`
- **Visibility**: external
- **Source Range**: 1646:147:553
- **Details**: [function_isSuperPositionCreated_address.md](./function_isSuperPositionCreated_address.md)

**Signature:**
```solidity
/// @inheritdoc IVaultBankDestination
function isSuperPositionCreated(address superPosition) external view returns (bool);
```
