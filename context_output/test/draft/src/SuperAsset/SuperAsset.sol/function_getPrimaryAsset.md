# Function: getPrimaryAsset()

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `getPrimaryAsset()`
- **Visibility**: external
- **Source Range**: 40695:95:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function getPrimaryAsset() external view returns (address) {
    return primaryAsset;
}
```

## State Variable Reads

- **primaryAsset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.getPrimaryAsset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Returns the primary asset of the SuperAsset
 @return The address of the primary asset
