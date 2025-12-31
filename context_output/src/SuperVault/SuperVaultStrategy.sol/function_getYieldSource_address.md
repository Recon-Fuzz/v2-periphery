# Function: getYieldSource(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `getYieldSource(address)`
- **Visibility**: external
- **Source Range**: 24957:152:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function getYieldSource(address source) external view returns (YieldSource memory) {
    return YieldSource({oracle: yieldSources[source]});
}
```

## State Variable Reads

- **yieldSources** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.getYieldSource(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get a yield source's configuration
