# Function: setSwapFeeOutPercentage(uint256)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `setSwapFeeOutPercentage(uint256)`
- **Visibility**: external
- **Source Range**: 7989:230:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function setSwapFeeOutPercentage(uint256 _feePercentage) external {
    _onlyManager();
    if (_feePercentage > MAX_SWAP_FEE_PERC) revert INVALID_SWAP_FEE_PERCENTAGE();
    swapFeeOutPercentage = _feePercentage;
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

- **MAX_SWAP_FEE_PERC** (`uint256`)
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **swapFeeOutPercentage** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.setSwapFeeOutPercentage(uint256) (NodeID: 0)
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

@notice Sets the swap fee percentage for redemptions (output operations)
 @param _feePercentage The fee percentage (scaled by SWAP_FEE_PERC)
