# Function: transferManagerRole(bytes32,address)

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `transferManagerRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 10430:479:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function transferManagerRole(bytes32 yieldSourceOracleId, address newManager) virtual external {
    YieldSourceOracleConfig memory config = yieldSourceOracleConfig[yieldSourceOracleId];
    if (config.manager != msg.sender) revert NOT_MANAGER();
    if (newManager == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    pendingManager[yieldSourceOracleId] = newManager;
    emit ManagerRoleTransferStarted(yieldSourceOracleId, msg.sender, newManager);
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)

## State Variable Writes

- **pendingManager** (`mapping(bytes32 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.transferManagerRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Initiates the transfer of manager role to a new address
 @dev First step in a two-step process for transferring management rights
      Only the current manager can initiate the transfer
      The transfer must be accepted by the new manager to complete
 @param yieldSourceOracleId The yield source oracle ID to transfer management of
 @param newManager The address of the proposed new manager
