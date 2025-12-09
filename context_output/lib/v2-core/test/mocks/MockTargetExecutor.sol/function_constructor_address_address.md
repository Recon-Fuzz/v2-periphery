# Function: constructor(address,address)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1213:239:487

## Implementation

```solidity
constructor(address ledgerConfiguration_, address superCollectiveVault_) {
    LEDGER_CONFIGURATION = ISuperLedgerConfiguration(ledgerConfiguration_);
    SUPER_COLLECTIVE_VAULT = ISuperCollectiveVault(superCollectiveVault_);
}
```

## State Variable Writes

- **LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **SUPER_COLLECTIVE_VAULT** (`contract ISuperCollectiveVault`) [lib/v2-core/test/mocks/ISuperCollectiveVault.sol/interface_ISuperCollectiveVault.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockTargetExecutor.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockTargetExecutor
```
