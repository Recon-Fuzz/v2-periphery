# Function: setTargetAllocation(address,uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `setTargetAllocation(address,uint256)`
- **Visibility**: external
- **Source Range**: 10150:524:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function setTargetAllocation(address token, uint256 allocation) external {
    _onlyStrategist();
    if (token == address(0)) revert ZERO_ADDRESS();
    if ((!tokenData[token].isSupportedUnderlyingVault) && (!tokenData[token].isSupportedERC20)) {
        revert NOT_SUPPORTED_TOKEN();
    }
    tokenData[token].targetAllocations = allocation;
    emit TargetAllocationSet(token, allocation);
}
```

## Related Implementations

### _onlyStrategist()

- **Kind**: internal
- **Source**: 42181:145:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:_onlyStrategist()`

```solidity
function _onlyStrategist() internal view {
    if (msg.sender != factory.getSuperAssetStrategist(address(this))) revert UNAUTHORIZED();
}
```

## State Variable Reads

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.setTargetAllocation(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperAsset._onlyStrategist() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Sets the target allocation for a token
 @param token The token address
 @param allocation The target allocation percentage (scaled by PRECISION)
