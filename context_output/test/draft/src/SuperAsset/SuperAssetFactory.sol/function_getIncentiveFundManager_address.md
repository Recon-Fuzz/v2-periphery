# Function: getIncentiveFundManager(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `getIncentiveFundManager(address)`
- **Visibility**: external
- **Source Range**: 4616:146:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveFundManager(address superAsset) external view returns (address) {
    return data[superAsset].incentiveFundManager;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.getIncentiveFundManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Gets the incentive fund manager for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @return incentiveFundManager Address of the incentive fund manager
