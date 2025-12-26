# Function: getAllYieldSourceOracleIdsByOwner(address)

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `getAllYieldSourceOracleIdsByOwner(address)`
- **Visibility**: external
- **Source Range**: 11573:165:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getAllYieldSourceOracleIdsByOwner(address owner) virtual external view returns (bytes32[] memory) {
    return yieldSourceOracleIdsByOwner[owner];
}
```

## State Variable Reads

- **yieldSourceOracleIdsByOwner** (`mapping(address => bytes32[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.getAllYieldSourceOracleIdsByOwner(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Retrieves all yield source oracle IDs owned by a specific address
 @param owner The address to query for owned yield source oracle IDs
 @return Array of yield source oracle IDs owned by the specified address
