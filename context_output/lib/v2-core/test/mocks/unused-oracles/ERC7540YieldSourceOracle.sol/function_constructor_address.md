# Function: constructor(address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 698:103:498

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
┌─ [0] 🏗️ CONSTRUCTOR: ERC7540YieldSourceOracle.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC7540YieldSourceOracle
  └─ [1] 🏗️ CONSTRUCTOR: AbstractYieldSourceOracle.constructor(address) (NodeID: 1)
      💬 Args: [superLedgerConfiguration_]
      🏗️  Contract: AbstractYieldSourceOracle
```
