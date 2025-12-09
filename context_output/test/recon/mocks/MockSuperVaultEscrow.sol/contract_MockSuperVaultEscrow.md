# Contract: MockSuperVaultEscrow

## Metadata

- **Name**: MockSuperVaultEscrow
- **Type**: Contract
- **Path**: test/recon/mocks/MockSuperVaultEscrow.sol

## State Variables

### _initializedReturn_0

```solidity
///    ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️  *
///  -----------------------------------------------------------------*
///       Generally you only need to modify the sections above.      *
///           The code below handles system operations.              *
bool private _initializedReturn_0
```

### _strategyReturn_0

```solidity
address private _strategyReturn_0
```

### _vaultReturn_0

```solidity
address private _vaultReturn_0
```

## Public/External Functions

### escrowShares(address,uint256)

- **Signature**: `escrowShares(address,uint256)`
- **Visibility**: public
- **Source Range**: 503:62:644
- **Details**: [function_escrowShares_address_uint256.md](./function_escrowShares_address_uint256.md)

**Signature:**
```solidity
function escrowShares(address from, uint256 amount) public;
```

### initialize(address,address)

- **Signature**: `initialize(address,address)`
- **Visibility**: public
- **Source Range**: 612:77:644
- **Details**: [function_initialize_address_address.md](./function_initialize_address_address.md)

**Signature:**
```solidity
function initialize(address vaultAddress, address strategyAddress) public;
```

### returnShares(address,uint256)

- **Signature**: `returnShares(address,uint256)`
- **Visibility**: public
- **Source Range**: 738:60:644
- **Details**: [function_returnShares_address_uint256.md](./function_returnShares_address_uint256.md)

**Signature:**
```solidity
function returnShares(address to, uint256 amount) public;
```

### setInitializedReturn(bool)

- **Signature**: `setInitializedReturn(bool)`
- **Visibility**: public
- **Source Range**: 1217:98:644
- **Details**: [function_setInitializedReturn_bool.md](./function_setInitializedReturn_bool.md)

**Signature:**
```solidity
function setInitializedReturn(bool _value0) public;
```

### setStrategyReturn(address)

- **Signature**: `setStrategyReturn(address)`
- **Visibility**: public
- **Source Range**: 1371:95:644
- **Details**: [function_setStrategyReturn_address.md](./function_setStrategyReturn_address.md)

**Signature:**
```solidity
function setStrategyReturn(address _value0) public;
```

### setVaultReturn(address)

- **Signature**: `setVaultReturn(address)`
- **Visibility**: public
- **Source Range**: 1519:89:644
- **Details**: [function_setVaultReturn_address.md](./function_setVaultReturn_address.md)

**Signature:**
```solidity
function setVaultReturn(address _value0) public;
```

### initialized()

- **Signature**: `initialized()`
- **Visibility**: public
- **Source Range**: 3586:94:644
- **Details**: [function_initialized.md](./function_initialized.md)

**Signature:**
```solidity
function initialized() public view returns (bool);
```

### strategy()

- **Signature**: `strategy()`
- **Visibility**: public
- **Source Range**: 3725:91:644
- **Details**: [function_strategy.md](./function_strategy.md)

**Signature:**
```solidity
function strategy() public view returns (address);
```

### vault()

- **Signature**: `vault()`
- **Visibility**: public
- **Source Range**: 3858:85:644
- **Details**: [function_vault.md](./function_vault.md)

**Signature:**
```solidity
function vault() public view returns (address);
```
