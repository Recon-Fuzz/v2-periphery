# Function: getUpkeepBalance(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `getUpkeepBalance(address)`
- **Visibility**: external
- **Source Range**: 44278:140:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getUpkeepBalance(address strategy) external view returns (uint256 balance) {
    return _strategyUpkeepBalance[strategy];
}
```

## State Variable Reads

- **_strategyUpkeepBalance** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.getUpkeepBalance(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the current upkeep balance for a strategy
 @param strategy Address of the strategy
 @return balance Current upkeep balance in upkeep tokens
