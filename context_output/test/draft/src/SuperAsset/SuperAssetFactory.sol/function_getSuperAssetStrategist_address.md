# Function: getSuperAssetStrategist(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `getSuperAssetStrategist(address)`
- **Visibility**: external
- **Source Range**: 4425:146:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function getSuperAssetStrategist(address superAsset) external view returns (address) {
    return data[superAsset].superAssetStrategist;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.getSuperAssetStrategist(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Gets the strategist for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @return superAssetStrategist Address of the strategist
