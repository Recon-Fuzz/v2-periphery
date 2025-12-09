# Interface: IPoolManager

## Metadata

- **Name**: IPoolManager
- **Type**: Interface
- **Path**: lib/v2-core/test/mocks/centrifuge/IPoolManager.sol

## Implements Interfaces

- **IRecoverable** [lib/v2-core/test/mocks/centrifuge/IRoot.sol/interface_IRecoverable.md]
- **IMessageHandler** [lib/v2-core/test/mocks/centrifuge/IGateway.sol/interface_IMessageHandler.md]

## Events

### File

```solidity
event File(bytes32 indexed what, address data);
```

### AddAsset

```solidity
event AddAsset(uint128 indexed assetId, address indexed asset);
```

### AddPool

```solidity
event AddPool(uint64 indexed poolId);
```

### AllowAsset

```solidity
event AllowAsset(uint64 indexed poolId, address indexed asset);
```

### DisallowAsset

```solidity
event DisallowAsset(uint64 indexed poolId, address indexed asset);
```

### AddTranche

```solidity
event AddTranche(uint64 indexed poolId, bytes16 indexed trancheId);
```

### DeployTranche

```solidity
event DeployTranche(uint64 indexed poolId, bytes16 indexed trancheId, address indexed tranche);
```

### DeployVault

```solidity
event DeployVault(uint64 indexed poolId, bytes16 indexed trancheId, address indexed asset, address vault);
```

### RemoveVault

```solidity
event RemoveVault(uint64 indexed poolId, bytes16 indexed trancheId, address indexed asset, address vault);
```

### PriceUpdate

```solidity
event PriceUpdate(uint64 indexed poolId, bytes16 indexed trancheId, address indexed asset, uint256 price, uint64 computedAt);
```

### TransferAssets

```solidity
event TransferAssets(address indexed asset, address indexed sender, bytes32 indexed recipient, uint128 amount);
```

### TransferTrancheTokens

```solidity
event TransferTrancheTokens(uint64 indexed poolId, bytes16 indexed trancheId, address indexed sender, Domain destinationDomain, uint64 destinationId, bytes32 destinationAddress, uint128 amount);
```

## Public/External Functions

### investmentManager()

- **Signature**: `investmentManager()`
- **Visibility**: external
- **Source Range**: 2770:61:491

**Signature:**
```solidity
/// @notice returns the investmentManager address
///  @dev    can be set using file
function investmentManager() external view returns (address);;
```

### idToAsset(uint128)

- **Signature**: `idToAsset(uint128)`
- **Visibility**: external
- **Source Range**: 2912:74:491

**Signature:**
```solidity
/// @notice returns the asset address associated with a given asset id
function idToAsset(uint128 assetId) external view returns (address asset);;
```

### assetToId(address)

- **Signature**: `assetToId(address)`
- **Visibility**: external
- **Source Range**: 3061:68:491

**Signature:**
```solidity
/// @notice returns the asset id associated with a given address
function assetToId(address) external view returns (uint128 assetId);;
```

### file(bytes32,address)

- **Signature**: `file(bytes32,address)`
- **Visibility**: external
- **Source Range**: 3341:51:491

**Signature:**
```solidity
/// @notice Updates a contract parameter
///  @param what Accepts a bytes32 representation of 'gateway', 'investmentManager', 'trancheFactory',
///                 'vaultFactory', or 'gasService'
function file(bytes32 what, address data) external;;
```

### transferAssets(address,bytes32,uint128)

- **Signature**: `transferAssets(address,bytes32,uint128)`
- **Visibility**: external
- **Source Range**: 3539:83:491

**Signature:**
```solidity
/// @notice transfers assets to a cross-chain recipient address
///  @dev    Addresses on centrifuge chain are represented as bytes32
function transferAssets(address asset, bytes32 recipient, uint128 amount) external;;
```

### transferTrancheTokens(uint64,bytes16,enum Domain,uint64,bytes32,uint128)

- **Signature**: `transferTrancheTokens(uint64,bytes16,enum Domain,uint64,bytes32,uint128)`
- **Visibility**: external
- **Source Range**: 4164:219:491

**Signature:**
```solidity
/// @notice transfers tranche tokens to a cross-chain recipient address
///  @dev    To transfer to evm chains, pad a 20 byte evm address with 12 bytes of 0
///  @param  poolId The centrifuge pool id
///  @param  trancheId The tranche id
///  @param  destinationDomain an enum representing the destination domain (Centrifuge or EVM)
///  @param  destinationId The destination chain id
///  @param  recipient A bytes32 representation of the recipient address
///  @param  amount The amount of tokens to transfer
function transferTrancheTokens(uint64 poolId, bytes16 trancheId, Domain destinationDomain, uint64 destinationId, bytes32 recipient, uint128 amount) external;;
```

### addPool(uint64)

- **Signature**: `addPool(uint64)`
- **Visibility**: external
- **Source Range**: 4547:41:491

**Signature:**
```solidity
/// @notice    New pool details from an existing Centrifuge pool are added.
///  @dev       The function can only be executed by the gateway contract.
function addPool(uint64 poolId) external;;
```

### allowAsset(uint64,uint128)

- **Signature**: `allowAsset(uint64,uint128)`
- **Visibility**: external
- **Source Range**: 4950:61:491

**Signature:**
```solidity
/// @notice     Centrifuge pools can support multiple currencies for investing. this function adds
///              a new supported asset to the pool details.
///              Adding new currencies allow the creation of new vaults for the underlying Centrifuge pool.
///  @dev        The function can only be executed by the gateway contract.
function allowAsset(uint64 poolId, uint128 assetId) external;;
```

### disallowAsset(uint64,uint128)

- **Signature**: `disallowAsset(uint64,uint128)`
- **Visibility**: external
- **Source Range**: 5260:64:491

**Signature:**
```solidity
/// @notice    Centrifuge pools can support multiple currencies for investing. this function removes
///             a supported asset from the pool details.
///  @dev       The function can only be executed by the gateway contract.
function disallowAsset(uint64 poolId, uint128 assetId) external;;
```

### addTranche(uint64,bytes16,string,string,uint8,address)

- **Signature**: `addTranche(uint64,bytes16,string,string,uint8,address)`
- **Visibility**: external
- **Source Range**: 5493:207:491

**Signature:**
```solidity
/// @notice     New tranche details from an existing Centrifuge pool are added.
///  @dev        The function can only be executed by the gateway contract.
function addTranche(uint64 poolId, bytes16 trancheId, string memory tokenName, string memory tokenSymbol, uint8 decimals, address hook) external;;
```

### updateTrancheMetadata(uint64,bytes16,string,string)

- **Signature**: `updateTrancheMetadata(uint64,bytes16,string,string)`
- **Visibility**: external
- **Source Range**: 5858:172:491

**Signature:**
```solidity
/// @notice   Updates the tokenName and tokenSymbol of a tranche token
///  @dev      The function can only be executed by the gateway contract.
function updateTrancheMetadata(uint64 poolId, bytes16 trancheId, string memory tokenName, string memory tokenSymbol) external;;
```

### updateTranchePrice(uint64,bytes16,uint128,uint128,uint64)

- **Signature**: `updateTranchePrice(uint64,bytes16,uint128,uint128,uint64)`
- **Visibility**: external
- **Source Range**: 6166:176:491

**Signature:**
```solidity
/// @notice  Updates the price of a tranche token
///  @dev     The function can only be executed by the gateway contract.
function updateTranchePrice(uint64 poolId, bytes16 trancheId, uint128 assetId, uint128 price, uint64 computedAt) external;;
```

### updateRestriction(uint64,bytes16,bytes)

- **Signature**: `updateRestriction(uint64,bytes16,bytes)`
- **Visibility**: external
- **Source Range**: 6707:91:491

**Signature:**
```solidity
/// @notice Updates the restrictions on a tranche token for a specific user
///  @param  poolId The centrifuge pool id
///  @param  trancheId The tranche id
///  @param  update The restriction update in the form of a bytes array indicating
///                 the restriction to be updated, the user to be updated, and a validUntil timestamp.
function updateRestriction(uint64 poolId, bytes16 trancheId, bytes memory update) external;;
```

### updateTrancheHook(uint64,bytes16,address)

- **Signature**: `updateTrancheHook(uint64,bytes16,address)`
- **Visibility**: external
- **Source Range**: 6984:84:491

**Signature:**
```solidity
/// @notice Updates the hook of a tranche token
///  @param  poolId The centrifuge pool id
///  @param  trancheId The tranche id
///  @param  hook The new hook addres
function updateTrancheHook(uint64 poolId, bytes16 trancheId, address hook) external;;
```

### addAsset(uint128,address)

- **Signature**: `addAsset(uint128,address)`
- **Visibility**: external
- **Source Range**: 7451:59:491

**Signature:**
```solidity
/// @notice A global chain agnostic asset index is maintained on Centrifuge. This function maps
///          a asset from the Centrifuge index to its corresponding address on the evm chain.
///          The chain agnostic asset id has to be used to pass asset information to the Centrifuge.
///  @dev    This function can only be executed by the gateway contract.
function addAsset(uint128 assetId, address asset) external;;
```

### handle(bytes)

- **Signature**: `handle(bytes)`
- **Visibility**: external
- **Source Range**: 7643:49:491

**Signature:**
```solidity
/// @notice Executes a message from the gateway
///  @dev    The function can only be executed by the gateway contract.
function handle(bytes calldata message) external;;
```

### handleTransfer(uint128,address,uint128)

- **Signature**: `handleTransfer(uint128,address,uint128)`
- **Visibility**: external
- **Source Range**: 7860:85:491

**Signature:**
```solidity
/// @notice Transfers assets to a recipient from the escrow contract
///  @dev    The function can only be executed internally or by the gateway contract.
function handleTransfer(uint128 assetId, address recipient, uint128 amount) external;;
```

### handleTransferTrancheTokens(uint64,bytes16,address,uint128)

- **Signature**: `handleTransferTrancheTokens(uint64,bytes16,address,uint128)`
- **Visibility**: external
- **Source Range**: 8092:170:491

**Signature:**
```solidity
/// @notice Mints tranche tokens to a recipient
///  @dev    The function can only be executed internally or by the gateway contract.
function handleTransferTrancheTokens(uint64 poolId, bytes16 trancheId, address destinationAddress, uint128 amount) external;;
```

### deployTranche(uint64,bytes16)

- **Signature**: `deployTranche(uint64,bytes16)`
- **Visibility**: external
- **Source Range**: 8385:84:491

**Signature:**
```solidity
/// @notice Deploys a created tranche
///  @dev    The function can only be executed by the gateway contract.
function deployTranche(uint64 poolId, bytes16 trancheId) external returns (address);;
```

### deployVault(uint64,bytes16,address)

- **Signature**: `deployVault(uint64,bytes16,address)`
- **Visibility**: external
- **Source Range**: 8618:97:491

**Signature:**
```solidity
/// @notice Deploys a vault for a given asset and tranche token
///  @dev    The function can only be executed by the gateway contract.
function deployVault(uint64 poolId, bytes16 trancheId, address asset) external returns (address);;
```

### removeVault(uint64,bytes16,address)

- **Signature**: `removeVault(uint64,bytes16,address)`
- **Visibility**: external
- **Source Range**: 8864:79:491

**Signature:**
```solidity
/// @notice Removes a vault for a given asset and tranche token
///  @dev    The function can only be executed by the gateway contract.
function removeVault(uint64 poolId, bytes16 trancheId, address asset) external;;
```

### isPoolActive(uint64)

- **Signature**: `isPoolActive(uint64)`
- **Visibility**: external
- **Source Range**: 9009:66:491

**Signature:**
```solidity
/// @notice Returns whether the given pool id is active
function isPoolActive(uint64 poolId) external view returns (bool);;
```

### getTranche(uint64,bytes16)

- **Signature**: `getTranche(uint64,bytes16)`
- **Visibility**: external
- **Source Range**: 9155:86:491

**Signature:**
```solidity
/// @notice Returns the tranche token for a given pool and tranche id
function getTranche(uint64 poolId, bytes16 trancheId) external view returns (address);;
```

### canTrancheBeDeployed(uint64,bytes16)

- **Signature**: `canTrancheBeDeployed(uint64,bytes16)`
- **Visibility**: external
- **Source Range**: 9345:93:491

**Signature:**
```solidity
/// @notice Returns whether the tranche token for a given pool and tranche id can be deployed
function canTrancheBeDeployed(uint64 poolId, bytes16 trancheId) external view returns (bool);;
```

### getVault(uint64,bytes16,uint128)

- **Signature**: `getVault(uint64,bytes16,uint128)`
- **Visibility**: external
- **Source Range**: 9521:101:491

**Signature:**
```solidity
/// @notice Returns the vault for a given pool, tranche id, and asset id
function getVault(uint64 poolId, bytes16 trancheId, uint128 assetId) external view returns (address);;
```

### getVault(uint64,bytes16,address)

- **Signature**: `getVault(uint64,bytes16,address)`
- **Visibility**: external
- **Source Range**: 9710:99:491

**Signature:**
```solidity
/// @notice Returns the vault for a given pool, tranche id, and asset address
function getVault(uint64 poolId, bytes16 trancheId, address asset) external view returns (address);;
```

### getTranchePrice(uint64,bytes16,address)

- **Signature**: `getTranchePrice(uint64,bytes16,address)`
- **Visibility**: external
- **Source Range**: 9912:185:491

**Signature:**
```solidity
/// @notice Retuns the latest tranche token price for a given pool, tranche id, and asset id
function getTranchePrice(uint64 poolId, bytes16 trancheId, address asset) external view returns (uint128 price, uint64 computedAt);;
```

### getVaultAsset(address)

- **Signature**: `getVaultAsset(address)`
- **Visibility**: external
- **Source Range**: 10460:92:491

**Signature:**
```solidity
/// @notice Function to get the vault's underlying asset
///  @dev    Function vaultToAsset which is a state variable getter could be used
///          but in that case each caller MUST make sure they handle the case
///          where a 0 address is returned. Using this method, that handling is done
///          on the behalf the caller.
function getVaultAsset(address vault) external view returns (address asset, bool isWrapper);;
```

### isAllowedAsset(uint64,address)

- **Signature**: `isAllowedAsset(uint64,address)`
- **Visibility**: external
- **Source Range**: 10631:83:491

**Signature:**
```solidity
/// @notice Checks whether a given asset is allowed for a given pool
function isAllowedAsset(uint64 poolId, address asset) external view returns (bool);;
```

### recoverTokens(address,address,uint256) (inherited from IRecoverable)

- **Signature**: `recoverTokens(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 519:75:494

**Signature:**
```solidity
/// @notice Used to recover any ERC-20 token.
///  @dev    This method is called only by authorized entities
///  @param  token It could be 0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
///          to recover locked native ETH or any ERC20 compatible token.
///  @param  to Receiver of the funds
///  @param  amount Amount to send to the receiver.
function recoverTokens(address token, address to, uint256 amount) external;;
```
