# Function: isMainManager(address,address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `isMainManager(address,address)`
- **Visibility**: public
- **Source Range**: 43043:155:634

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
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.isMainManager(address,address) (NodeID: 0)
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
