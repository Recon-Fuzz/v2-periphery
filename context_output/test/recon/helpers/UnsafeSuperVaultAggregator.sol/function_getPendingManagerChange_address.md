# Function: getPendingManagerChange(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getPendingManagerChange(address)`
- **Visibility**: external
- **Source Range**: 42728:267:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getPendingManagerChange(address strategy) external view returns (address proposedManager, uint256 effectiveTime) {
    return (_strategyData[strategy].proposedManager, _strategyData[strategy].managerChangeEffectiveTime);
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getPendingManagerChange(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets pending primary manager change details
 @param strategy Address of the strategy
 @return proposedManager Address of the proposed new manager (address(0) if no pending change)
 @return effectiveTime Timestamp when the change can be executed (0 if no pending change)
