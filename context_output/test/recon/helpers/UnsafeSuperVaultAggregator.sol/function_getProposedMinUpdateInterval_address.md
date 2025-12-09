# Function: getProposedMinUpdateInterval(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getProposedMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 39486:309:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedMinUpdateInterval(address strategy) external view returns (uint256 proposedInterval, uint256 effectiveTime) {
    return (_strategyData[strategy].proposedMinUpdateInterval, _strategyData[strategy].minUpdateIntervalEffectiveTime);
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getProposedMinUpdateInterval(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the proposed minUpdateInterval and effective time
 @param strategy Address of the strategy
 @return proposedInterval The proposed minimum update interval
 @return effectiveTime The timestamp when the proposed interval becomes effective
