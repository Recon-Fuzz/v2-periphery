# Function: isPPSStale(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `isPPSStale(address)`
- **Visibility**: external
- **Source Range**: 43890:131:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function isPPSStale(address strategy) external view returns (bool isStale) {
    return _strategyData[strategy].ppsStale;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.isPPSStale(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Checks if a strategy's PPS is stale
 @dev PPS is automatically set to stale when the strategy is paused due to
      lack of upkeep payment in `SuperVaultAggregator`
 @param strategy Address of the strategy
 @return isStale True if stale, false otherwise
