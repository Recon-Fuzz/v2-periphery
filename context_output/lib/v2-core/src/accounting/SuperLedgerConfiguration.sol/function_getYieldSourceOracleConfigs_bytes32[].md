# Function: getYieldSourceOracleConfigs(bytes32[])

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `getYieldSourceOracleConfigs(bytes32[])`
- **Visibility**: external
- **Source Range**: 12074:434:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getYieldSourceOracleConfigs(bytes32[] calldata yieldSourceOracleIds) virtual external view returns (YieldSourceOracleConfig[] memory configs) {
    uint256 length = yieldSourceOracleIds.length;
    configs = new YieldSourceOracleConfig[](length);
    for (uint256 i; i < length; ++i) {
        configs[i] = yieldSourceOracleConfig[yieldSourceOracleIds[i]];
    }
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.getYieldSourceOracleConfigs(bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Retrieves configurations for multiple yield source oracles in a single call
 @dev Batch version of getYieldSourceOracleConfig for gas efficiency
      Returns an array of configurations in the same order as the input IDs
 @param yieldSourceOracleIds Array of yield source oracle IDs to retrieve
 @return configs Array of configuration structs for the specified yield source oracles
