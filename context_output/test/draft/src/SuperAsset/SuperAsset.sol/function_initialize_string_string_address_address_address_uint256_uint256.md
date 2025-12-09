# Function: initialize(string,string,address,address,address,uint256,uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `initialize(string,string,address,address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3216:1046:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function initialize(string memory name_, string memory symbol_, address asset, address superGovernor_, address superRegistry_, uint256 swapFeeInPercentage_, uint256 swapFeeOutPercentage_) external {
    if (address(superGovernor) != address(0)) revert ALREADY_INITIALIZED();
    if (swapFeeInPercentage_ > MAX_SWAP_FEE_PERC) revert INVALID_SWAP_FEE_PERCENTAGE();
    if (swapFeeOutPercentage_ > MAX_SWAP_FEE_PERC) revert INVALID_SWAP_FEE_PERCENTAGE();
    swapFeeInPercentage = swapFeeInPercentage_;
    swapFeeOutPercentage = swapFeeOutPercentage_;
    tokenName = name_;
    tokenSymbol = symbol_;
    primaryAsset = asset;
    superGovernor = ISuperGovernor(superGovernor_);
    superRegistry = ISuperRegistry(superRegistry_);
    factory = ISuperAssetFactory(superRegistry.getAddress(superRegistry.SUPER_ASSET_FACTORY()));
}
```

## External Calls

- **ISuperRegistry::getAddress(bytes32)**
- **ISuperRegistry::SUPER_ASSET_FACTORY()**

## State Variable Reads

- **superGovernor** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **MAX_SWAP_FEE_PERC** (`uint256`)
- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

## State Variable Writes

- **swapFeeInPercentage** (`uint256`)
- **swapFeeOutPercentage** (`uint256`)
- **tokenName** (`string`)
- **tokenSymbol** (`string`)
- **primaryAsset** (`address`)
- **superGovernor** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.initialize(string,string,address,address,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Initializes the SuperAsset contract
 @param name_ Name of the token
 @param symbol_ Symbol of the token
 @param asset_ Address of the primary asset
 @param superGovernor_ Address of the SuperGovernor contract
 @param superRegistry_ Address of the SuperRegistry contract
 @param swapFeeInPercentage_ Initial swap fee percentage for deposits
 @param swapFeeOutPercentage_ Initial swap fee percentage for redemptions
