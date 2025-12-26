# Function: isMainManager(address,address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `isMainManager(address,address)`
- **Visibility**: public
- **Source Range**: 44970:155:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function isMainManager(address manager, address strategy) public view returns (bool) {
    return _strategyData[strategy].mainManager == manager;
}
```

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.isMainManager(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Checks if an address is the main manager for a strategy
 @param manager Address of the manager
 @param strategy Address of the strategy
 @return isMainManager True if the address is the main manager, false otherwise
