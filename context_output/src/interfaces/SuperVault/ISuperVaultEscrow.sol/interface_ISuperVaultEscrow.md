# Interface: ISuperVaultEscrow

## Metadata

- **Name**: ISuperVaultEscrow
- **Type**: Interface
- **Path**: src/interfaces/SuperVault/ISuperVaultEscrow.sol
- **Documentation**: @title ISuperVaultEscrow
   @notice Interface for SuperVault escrow contract that holds shares during request/claim process
   @author Superform Labs

## Errors

### ALREADY_INITIALIZED

```solidity
error ALREADY_INITIALIZED();
```

### UNAUTHORIZED

```solidity
error UNAUTHORIZED();
```

### ZERO_ADDRESS

```solidity
error ZERO_ADDRESS();
```

### ZERO_AMOUNT

```solidity
error ZERO_AMOUNT();
```

## Events

### Initialized

```solidity
/// @notice Emitted when escrow is initialized
///  @param vault The vault contract address
event Initialized(address indexed vault);
```

### SharesEscrowed

```solidity
/// @notice Emitted when shares are transferred to escrow
///  @param from The address shares were transferred from
///  @param amount The amount of shares escrowed
event SharesEscrowed(address indexed from, uint256 amount);
```

### SharesReturned

```solidity
/// @notice Emitted when shares are returned from escrow
///  @param to The address shares were returned to
///  @param amount The amount of shares returned
event SharesReturned(address indexed to, uint256 amount);
```

### AssetsReturned

```solidity
/// @notice Emitted when assets are returned from escrow
///  @param to The address assets were returned to
///  @param amount The amount of assets returned
event AssetsReturned(address indexed to, uint256 amount);
```

## Public/External Functions

### initialize(address)

- **Signature**: `initialize(address)`
- **Visibility**: external
- **Source Range**: 1865:51:521

**Signature:**
```solidity
/// @notice Initialize the escrow with required parameters
///  @param vaultAddress The vault contract address
function initialize(address vaultAddress) external;;
```

### escrowShares(address,uint256)

- **Signature**: `escrowShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 2290:61:521

**Signature:**
```solidity
/// @notice Transfer shares from user to escrow during redeem request
///  @param from The address to transfer shares from
///  @param amount The amount of shares to transfer
function escrowShares(address from, uint256 amount) external;;
```

### returnShares(address,uint256)

- **Signature**: `returnShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 2537:59:521

**Signature:**
```solidity
/// @notice Return shares from escrow to user during redeem cancellation
///  @param to The address to return shares to
///  @param amount The amount of shares to return
function returnShares(address to, uint256 amount) external;;
```

### returnAssets(address,uint256)

- **Signature**: `returnAssets(address,uint256)`
- **Visibility**: external
- **Source Range**: 2784:59:521

**Signature:**
```solidity
/// @notice Return assets from escrow to vault during deposit cancellation
///  @param to The address to return assets to
///  @param amount The amount of assets to return
function returnAssets(address to, uint256 amount) external;;
```
