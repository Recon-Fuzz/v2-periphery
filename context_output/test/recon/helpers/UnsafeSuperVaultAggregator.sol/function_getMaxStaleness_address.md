# Function: getMaxStaleness(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getMaxStaleness(address)`
- **Visibility**: external
- **Source Range**: 41310:145:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getMaxStaleness(address strategy) external view returns (uint256 staleness) {
    return _strategyData[strategy].maxStaleness;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getMaxStaleness(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the maximum staleness period for a strategy
 @param strategy Address of the strategy
 @return staleness Maximum time allowed between updates
