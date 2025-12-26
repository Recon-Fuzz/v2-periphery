# Contract: SuperVaultEscrow

## Metadata

- **Name**: SuperVaultEscrow
- **Type**: Contract
- **Path**: src/SuperVault/SuperVaultEscrow.sol
- **Documentation**: @title SuperVaultEscrow
   @author Superform Labs
   @notice Escrow contract for SuperVault shares during request/claim process

## Implements Interfaces

- **ISuperVaultEscrow** [src/interfaces/SuperVault/ISuperVaultEscrow.sol/interface_ISuperVaultEscrow.md]

## State Variables

### initialized

```solidity
bool public initialized
```

### vault

```solidity
address public vault
```

## Errors

### ALREADY_INITIALIZED (inherited from ISuperVaultEscrow)

```solidity
error ALREADY_INITIALIZED();
```

### UNAUTHORIZED (inherited from ISuperVaultEscrow)

```solidity
error UNAUTHORIZED();
```

### ZERO_ADDRESS (inherited from ISuperVaultEscrow)

```solidity
error ZERO_ADDRESS();
```

### ZERO_AMOUNT (inherited from ISuperVaultEscrow)

```solidity
error ZERO_AMOUNT();
```

## Events

### Initialized (inherited from ISuperVaultEscrow)

```solidity
/// @notice Emitted when escrow is initialized
///  @param vault The vault contract address
event Initialized(address indexed vault);
```

### SharesEscrowed (inherited from ISuperVaultEscrow)

```solidity
/// @notice Emitted when shares are transferred to escrow
///  @param from The address shares were transferred from
///  @param amount The amount of shares escrowed
event SharesEscrowed(address indexed from, uint256 amount);
```

### SharesReturned (inherited from ISuperVaultEscrow)

```solidity
/// @notice Emitted when shares are returned from escrow
///  @param to The address shares were returned to
///  @param amount The amount of shares returned
event SharesReturned(address indexed to, uint256 amount);
```

### AssetsReturned (inherited from ISuperVaultEscrow)

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
- **Source Range**: 1407:276:512
- **Details**: [function_initialize_address.md](./function_initialize_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultEscrow
function initialize(address vaultAddress) external;
```

### escrowShares(address,uint256)

- **Signature**: `escrowShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 1910:237:512
- **Details**: [function_escrowShares_address_uint256.md](./function_escrowShares_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultEscrow
function escrowShares(address from, uint256 amount) external onlyVault();
```

### returnShares(address,uint256)

- **Signature**: `returnShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 2191:212:512
- **Details**: [function_returnShares_address_uint256.md](./function_returnShares_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultEscrow
function returnShares(address to, uint256 amount) external onlyVault();
```

### returnAssets(address,uint256)

- **Signature**: `returnAssets(address,uint256)`
- **Visibility**: external
- **Source Range**: 2447:283:512
- **Details**: [function_returnAssets_address_uint256.md](./function_returnAssets_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultEscrow
function returnAssets(address to, uint256 amount) external onlyVault();
```
