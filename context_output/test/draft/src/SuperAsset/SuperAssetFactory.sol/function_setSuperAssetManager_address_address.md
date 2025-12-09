# Function: setSuperAssetManager(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `setSuperAssetManager(address,address)`
- **Visibility**: external
- **Source Range**: 2504:418:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function setSuperAssetManager(address superAsset, address _superAssetManager) external {
    if (_superAssetManager == address(0)) revert ZERO_ADDRESS();
    if ((msg.sender != data[superAsset].superAssetManager) && (msg.sender != superRegistry)) revert UNAUTHORIZED();
    data[superAsset].superAssetManager = _superAssetManager;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)
- **superRegistry** (`address`)

## State Variable Writes

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.setSuperAssetManager(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Sets the manager for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @param _superAssetManager Address of the manager
