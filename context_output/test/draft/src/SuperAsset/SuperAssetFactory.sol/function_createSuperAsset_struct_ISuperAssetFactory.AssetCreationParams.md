# Function: createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)

**Contract**: [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]

## Metadata

- **Contract**: SuperAssetFactory
- **Signature**: `createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)`
- **Visibility**: external
- **Source Range**: 5392:1753:549

## Implementation

```solidity
/// @inheritdoc ISuperAssetFactory
function createSuperAsset(AssetCreationParams calldata params) external returns (address superAsset, address incentiveFundContract) {
    if (params.incentiveCalculationContract == address(0)) revert ZERO_ADDRESS();
    if (!incentiveCalculationContractsWhitelist[params.incentiveCalculationContract]) revert ICC_NOT_WHITELISTED();
    incentiveFundContract = incentiveFundImplementation.clone();
    superAsset = superAssetImplementation.clone();
    SuperAsset(superAsset).initialize(params.name, params.symbol, params.asset, superGovernor, superRegistry, params.swapFeeInPercentage, params.swapFeeOutPercentage);
    IncentiveFundContract(incentiveFundContract).initialize(superGovernor, superRegistry, superAsset, params.tokenInIncentive, params.tokenOutIncentive);
    data[superAsset] = SuperAssetData({superAssetManager: params.superAssetManager, superAssetStrategist: params.superAssetStrategist, incentiveFundManager: params.incentiveFundManager, incentiveCalculationContract: params.incentiveCalculationContract, incentiveFundContract: incentiveFundContract});
    emit SuperAssetCreated(superAsset, incentiveFundContract, params.incentiveCalculationContract, params.name, params.symbol);
}
```

## External Calls

- **address::clone(address)**
- **SuperAsset::initialize(string,string,address,address,address,uint256,uint256)**
- **IncentiveFundContract::initialize(address,address,address,address,address)**

## State Variable Reads

- **incentiveCalculationContractsWhitelist** (`mapping(address => bool)`)
- **incentiveFundImplementation** (`address`)
- **superAssetImplementation** (`address`)
- **superGovernor** (`address`)
- **superRegistry** (`address`)

## State Variable Writes

- **data** (`mapping(address => struct ISuperAssetFactory.SuperAssetData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetFactory.createSuperAsset(struct ISuperAssetFactory.AssetCreationParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAssetFactory

### Interface Documentation

@notice Creates a new SuperAsset instance with its dependencies
 @param params Parameters for creating the SuperAsset
 @return superAsset Address of the deployed SuperAsset contract
 @return incentiveFund Address of the deployed IncentiveFundContract
