# Function: setTargetAllocations(address[],uint256[])

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `setTargetAllocations(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 9386:726:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function setTargetAllocations(address[] calldata tokens, uint256[] calldata allocations) external {
    _onlyStrategist();
    uint256 lenTokens = tokens.length;
    if (lenTokens != allocations.length) revert INVALID_INPUT();
    for (uint256 i; i < lenTokens; i++) {
        if (tokens[i] == address(0)) revert ZERO_ADDRESS();
        if ((!tokenData[tokens[i]].isSupportedUnderlyingVault) && (!tokenData[tokens[i]].isSupportedERC20)) {
            revert NOT_SUPPORTED_TOKEN();
        }
    }
    for (uint256 i; i < lenTokens; i++) {
        tokenData[tokens[i]].targetAllocations = allocations[i];
        emit TargetAllocationSet(tokens[i], allocations[i]);
    }
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
┌─ [0] ⚙️ FUNCTION: SuperAsset.setTargetAllocations(address[],uint256[]) (NodeID: 0)
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

@notice Sets target allocations for multiple tokens at once
 @param tokens Array of token addresses
 @param allocations Array of target allocation percentages (scaled by PRECISION)
