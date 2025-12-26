# Function: initialize(address)

**Contract**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

## Metadata

- **Contract**: SuperVaultEscrow
- **Signature**: `initialize(address)`
- **Visibility**: external
- **Source Range**: 1407:276:512

## Implementation

```solidity
/// @inheritdoc ISuperVaultEscrow
function initialize(address vaultAddress) external {
    if (initialized) revert ALREADY_INITIALIZED();
    if (vaultAddress == address(0)) revert ZERO_ADDRESS();
    initialized = true;
    vault = vaultAddress;
    emit Initialized(vaultAddress);
}
```

## State Variable Reads

- **initialized** (`bool`)

## State Variable Writes

- **initialized** (`bool`)
- **vault** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrow.initialize(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultEscrow

### Interface Documentation

@notice Initialize the escrow with required parameters
 @param vaultAddress The vault contract address
