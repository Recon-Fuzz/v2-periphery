# Function: setEnergyToUSDExchangeRatio(uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `setEnergyToUSDExchangeRatio(uint256)`
- **Visibility**: external
- **Source Range**: 8673:192:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function setEnergyToUSDExchangeRatio(uint256 newRatio) external {
    _onlyManager();
    energyToUSDExchangeRatio = newRatio;
    emit EnergyToUSDExchangeRatioSet(newRatio);
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

- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **energyToUSDExchangeRatio** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.setEnergyToUSDExchangeRatio(uint256) (NodeID: 0)
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

@notice Sets the exchange ratio between energy units and USD
 @param newRatio The new exchange ratio (scaled by PRECISION)
 @dev This is the ratio between energy units and USD
 @dev No checks on zero on purpose in case we want to disable incentives
