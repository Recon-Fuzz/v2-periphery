# Function: setWeight(address,uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `setWeight(address,uint256)`
- **Visibility**: external
- **Source Range**: 8257:378:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function setWeight(address vault, uint256 weight) external {
    _onlyManager();
    if (vault == address(0)) revert ZERO_ADDRESS();
    if ((!tokenData[vault].isSupportedUnderlyingVault) && (!tokenData[vault].isSupportedERC20)) {
        revert NOT_SUPPORTED_TOKEN();
    }
    tokenData[vault].weights = weight;
    emit WeightSet(vault, weight);
}
```

## Related Implementations

### _onlyManager()

- **Kind**: internal
- **Source**: 42332:139:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:_onlyManager()`

```solidity
function _onlyManager() internal view {
    if (msg.sender != factory.getSuperAssetManager(address(this))) revert UNAUTHORIZED();
}
```

## State Variable Reads

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.setWeight(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperAsset._onlyManager() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Sets the weight for a vault
 @param vault The vault address
 @param weight The weight percentage (scaled by PRECISION)
