# Function: constructor(address,address)

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 3253:380:360

## Implementation

```solidity
/// @notice Initializes the SuperDestinationExecutor with required references
///  @param ledgerConfiguration_ Address of the ledger configuration contract for fee calculations
///  @param superDestinationValidator_ Address of the validator contract used to verify cross-chain messages
constructor(address ledgerConfiguration_, address superDestinationValidator_) SuperExecutorBase(ledgerConfiguration_) {
    if (superDestinationValidator_ == address(0)) {
        revert ADDRESS_NOT_VALID();
    }
    SUPER_DESTINATION_VALIDATOR = superDestinationValidator_;
}
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

- **SUPER_DESTINATION_VALIDATOR** (`address`)
- **LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperDestinationExecutor.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperDestinationExecutor
  └─ [1] 🏗️ CONSTRUCTOR: SuperExecutorBase.constructor(address) (NodeID: 1)
      💬 Args: [ledgerConfiguration_]
      🏗️  Contract: SuperExecutorBase
```

## Documentation

### Function Documentation

@notice Initializes the SuperDestinationExecutor with required references
 @param ledgerConfiguration_ Address of the ledger configuration contract for fee calculations
 @param superDestinationValidator_ Address of the validator contract used to verify cross-chain messages
