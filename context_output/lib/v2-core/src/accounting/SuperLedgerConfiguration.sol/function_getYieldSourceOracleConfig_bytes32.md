# Function: getYieldSourceOracleConfig(bytes32)

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `getYieldSourceOracleConfig(bytes32)`
- **Visibility**: external
- **Source Range**: 11790:232:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getYieldSourceOracleConfig(bytes32 yieldSourceOracleId) virtual external view returns (YieldSourceOracleConfig memory) {
    return yieldSourceOracleConfig[yieldSourceOracleId];
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.getYieldSourceOracleConfig(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Retrieves the current configuration for a yield source oracle
 @dev Used by components that need oracle and fee information
      Returns the complete configuration structure including all parameters
 @param yieldSourceOracleId The unique identifier for the yield source oracle
 @return Complete configuration struct for the specified yield source oracle
