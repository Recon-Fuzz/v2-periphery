# Function: getUpkeepBalance(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getUpkeepBalance(address)`
- **Visibility**: external
- **Source Range**: 42351:140:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getUpkeepBalance(address) (NodeID: 0)
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
