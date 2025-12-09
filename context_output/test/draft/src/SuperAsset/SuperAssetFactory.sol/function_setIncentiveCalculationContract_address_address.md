# Function: setIncentiveCalculationContract(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `setIncentiveCalculationContract(address,address)`
- **Visibility**: external
- **Source Range**: 3713:482:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function setIncentiveCalculationContract(address superAsset, address _incentiveCalculationContract) external {
    if (_incentiveCalculationContract == address(0)) revert ZERO_ADDRESS();
    if (!incentiveCalculationContractsWhitelist[_incentiveCalculationContract]) revert ICC_NOT_WHITELISTED();
    if (msg.sender != data[superAsset].superAssetManager) revert UNAUTHORIZED();
    data[superAsset].incentiveCalculationContract = _incentiveCalculationContract;
}
```

## State Variable Reads

- **incentiveCalculationContractsWhitelist** (`mapping(address => bool)`)
- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## State Variable Writes

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.setIncentiveCalculationContract(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Sets the incentive calculation contract for a SuperAsset
 @param superAsset Address of the SuperAsset contract
 @param incentiveCalculationContract Address of the incentive calculation contract
