# Function: constructor(address,address,address,address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `constructor(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 5167:554:511

## Implementation

```solidity
/// @notice Initializes the SuperVaultAggregator
///  @param superGovernor_ Address of the SuperGovernor contract
///  @param vaultImpl_ Address of the pre-deployed SuperVault implementation
///  @param strategyImpl_ Address of the pre-deployed SuperVaultStrategy implementation
///  @param escrowImpl_ Address of the pre-deployed SuperVaultEscrow implementation
constructor(address superGovernor_, address vaultImpl_, address strategyImpl_, address escrowImpl_) {
    if (superGovernor_ == address(0)) revert ZERO_ADDRESS();
    if (vaultImpl_ == address(0)) revert ZERO_ADDRESS();
    if (strategyImpl_ == address(0)) revert ZERO_ADDRESS();
    if (escrowImpl_ == address(0)) revert ZERO_ADDRESS();
    SUPER_GOVERNOR = ISuperGovernor(superGovernor_);
    VAULT_IMPLEMENTATION = vaultImpl_;
    STRATEGY_IMPLEMENTATION = strategyImpl_;
    ESCROW_IMPLEMENTATION = escrowImpl_;
}
```

## State Variable Writes

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **VAULT_IMPLEMENTATION** (`address`)
- **STRATEGY_IMPLEMENTATION** (`address`)
- **ESCROW_IMPLEMENTATION** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperVaultAggregator.constructor(address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperVaultAggregator
```

## Documentation

### Function Documentation

@notice Initializes the SuperVaultAggregator
 @param superGovernor_ Address of the SuperGovernor contract
 @param vaultImpl_ Address of the pre-deployed SuperVault implementation
 @param strategyImpl_ Address of the pre-deployed SuperVaultStrategy implementation
 @param escrowImpl_ Address of the pre-deployed SuperVaultEscrow implementation
