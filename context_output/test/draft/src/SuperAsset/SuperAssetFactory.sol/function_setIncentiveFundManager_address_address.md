# Function: setIncentiveFundManager(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `setIncentiveFundManager(address,address)`
- **Visibility**: external
- **Source Range**: 3340:328:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function setIncentiveFundManager(address superAsset, address _incentiveFundManager) external {
    if (_incentiveFundManager == address(0)) revert ZERO_ADDRESS();
    if (msg.sender != data[superAsset].superAssetManager) revert UNAUTHORIZED();
    data[superAsset].incentiveFundManager = _incentiveFundManager;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## State Variable Writes

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.setIncentiveFundManager(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Sets the incentive fund manager for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @param _incentiveFundManager Address of the incentive fund manager
