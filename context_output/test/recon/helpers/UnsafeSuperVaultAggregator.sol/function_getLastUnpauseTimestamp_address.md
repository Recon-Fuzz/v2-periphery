# Function: getLastUnpauseTimestamp(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getLastUnpauseTimestamp(address)`
- **Visibility**: external
- **Source Range**: 42142:161:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getLastUnpauseTimestamp(address strategy) external view returns (uint256 timestamp) {
    return _strategyData[strategy].lastUnpauseTimestamp;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getLastUnpauseTimestamp(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the last unpause timestamp for a strategy
 @param strategy Address of the strategy
 @return timestamp Last unpause timestamp (0 if never unpaused)
