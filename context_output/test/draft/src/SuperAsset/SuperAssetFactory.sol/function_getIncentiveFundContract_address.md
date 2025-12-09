# Function: getIncentiveFundContract(address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `getIncentiveFundContract(address)`
- **Visibility**: external
- **Source Range**: 5014:148:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveFundContract(address superAsset) external view returns (address) {
    return data[superAsset].incentiveFundContract;
}
```

## State Variable Reads

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.getIncentiveFundContract(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Gets the incentive fund contract for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @return incentiveFundContract Address of the incentive fund contract
