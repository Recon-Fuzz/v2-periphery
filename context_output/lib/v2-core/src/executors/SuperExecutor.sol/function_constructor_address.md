# Function: constructor(address)

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 667:85:361

## Implementation

```solidity
/// @notice Initializes the SuperExecutor with ledger configuration
///  @param ledgerConfiguration_ Address of the ledger configuration contract for fee calculations
constructor(address ledgerConfiguration_) SuperExecutorBase(ledgerConfiguration_) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 3309:220:362
- **Link**: `lib/v2-core/src/executors/SuperExecutorBase.sol:SuperExecutorBase:constructor(address)`

```solidity
/// @notice Initializes the executor with ledger configuration
///  @dev Sets up the immutable references needed for accounting and fee calculations
///  @param superLedgerConfiguration_ Address of the ledger configuration contract
constructor(address superLedgerConfiguration_) {
    if (superLedgerConfiguration_ == address(0)) revert ADDRESS_NOT_VALID();
    LEDGER_CONFIGURATION = ISuperLedgerConfiguration(superLedgerConfiguration_);
}
```

## State Variable Writes

- **LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperExecutor.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperExecutor
  └─ [1] 🏗️ CONSTRUCTOR: SuperExecutorBase.constructor(address) (NodeID: 1)
      💬 Args: [ledgerConfiguration_]
      🏗️  Contract: SuperExecutorBase
```

## Documentation

### Function Documentation

@notice Initializes the SuperExecutor with ledger configuration
 @param ledgerConfiguration_ Address of the ledger configuration contract for fee calculations
