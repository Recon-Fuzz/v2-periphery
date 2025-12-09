# Function: setSuperAssetStrategist(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `setSuperAssetStrategist(address,address)`
- **Visibility**: external
- **Source Range**: 2967:328:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function setSuperAssetStrategist(address superAsset, address _superAssetStrategist) external {
    if (_superAssetStrategist == address(0)) revert ZERO_ADDRESS();
    if (msg.sender != data[superAsset].superAssetManager) revert UNAUTHORIZED();
    data[superAsset].superAssetStrategist = _superAssetStrategist;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## State Variable Writes

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.setSuperAssetStrategist(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Sets the strategist for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @param _superAssetStrategist Address of the strategist
