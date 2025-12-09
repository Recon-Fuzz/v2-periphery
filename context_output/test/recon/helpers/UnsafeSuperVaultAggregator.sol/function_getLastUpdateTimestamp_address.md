# Function: getLastUpdateTimestamp(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getLastUpdateTimestamp(address)`
- **Visibility**: external
- **Source Range**: 40901:159:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getLastUpdateTimestamp(address strategy) external view returns (uint256 timestamp) {
    return _strategyData[strategy].lastUpdateTimestamp;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getLastUpdateTimestamp(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the last update timestamp for a strategy's PPS
 @param strategy Address of the strategy
 @return timestamp Last update timestamp
