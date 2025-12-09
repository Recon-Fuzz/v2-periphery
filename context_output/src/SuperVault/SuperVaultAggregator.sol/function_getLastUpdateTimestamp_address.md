# Function: getLastUpdateTimestamp(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getLastUpdateTimestamp(address)`
- **Visibility**: external
- **Source Range**: 42828:159:511

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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getLastUpdateTimestamp(address) (NodeID: 0)
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
