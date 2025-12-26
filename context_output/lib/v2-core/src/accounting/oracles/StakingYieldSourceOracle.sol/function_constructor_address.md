# Function: constructor(address)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 485:103:357

## Implementation

```solidity
constructor(address superLedgerConfiguration_) AbstractYieldSourceOracle(superLedgerConfiguration_) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 1533:118:354
- **Link**: `lib/v2-core/src/accounting/oracles/AbstractYieldSourceOracle.sol:AbstractYieldSourceOracle:constructor(address)`

```solidity
/// @notice Constructor to set the SuperLedgerConfiguration address
///  @param superLedgerConfiguration_ Address of the SuperLedgerConfiguration contract
constructor(address superLedgerConfiguration_) {
    SUPER_LEDGER_CONFIGURATION = superLedgerConfiguration_;
}
```

## State Variable Writes

- **SUPER_LEDGER_CONFIGURATION** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: StakingYieldSourceOracle.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: StakingYieldSourceOracle
  └─ [1] 🏗️ CONSTRUCTOR: AbstractYieldSourceOracle.constructor(address) (NodeID: 1)
      💬 Args: [superLedgerConfiguration_]
      🏗️  Contract: AbstractYieldSourceOracle
```
