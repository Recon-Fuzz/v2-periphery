# Function: acceptManagerRole(bytes32)

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `acceptManagerRole(bytes32)`
- **Visibility**: external
- **Source Range**: 10961:376:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function acceptManagerRole(bytes32 yieldSourceOracleId) virtual external {
    if (pendingManager[yieldSourceOracleId] != msg.sender) revert NOT_PENDING_MANAGER();
    yieldSourceOracleConfig[yieldSourceOracleId].manager = msg.sender;
    delete pendingManager[yieldSourceOracleId];
    emit ManagerRoleTransferAccepted(yieldSourceOracleId, msg.sender);
}
```

## State Variable Reads

- **pendingManager** (`mapping(bytes32 => address)`)

## State Variable Writes

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **pendingManager** (`mapping(bytes32 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.acceptManagerRole(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Accepts the pending manager role transfer
 @dev Second step in the two-step process for transferring management rights
      Can only be called by the address designated as the pending manager
      Completes the transfer, giving the caller full management rights
 @param yieldSourceOracleId The yield source oracle ID to accept management of
