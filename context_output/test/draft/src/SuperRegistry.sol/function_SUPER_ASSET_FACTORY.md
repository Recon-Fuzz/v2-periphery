# Function: SUPER_ASSET_FACTORY()

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `SUPER_ASSET_FACTORY()`
- **Visibility**: external
- **Source Range**: 15319:107:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function SUPER_ASSET_FACTORY() external pure returns (bytes32) {
    return _SUPER_ASSET_FACTORY;
}
```

## State Variable Reads

- **_SUPER_ASSET_FACTORY** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.SUPER_ASSET_FACTORY() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Returns the SuperAsset factory registry key
 @return The keccak256 hash used as the registry key for SuperAsset factory
