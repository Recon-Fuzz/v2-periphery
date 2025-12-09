# Function: getIncentiveCalculationContract(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `getIncentiveCalculationContract(address)`
- **Visibility**: external
- **Source Range**: 4807:162:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveCalculationContract(address superAsset) external view returns (address) {
    return data[superAsset].incentiveCalculationContract;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.getIncentiveCalculationContract(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Gets the incentive calculation contract for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @return incentiveCalculationContract Address of the incentive calculation contract
