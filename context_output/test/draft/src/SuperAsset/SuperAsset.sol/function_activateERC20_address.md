# Function: activateERC20(address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `activateERC20(address)`
- **Visibility**: external
- **Source Range**: 5639:394:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function activateERC20(address token) external {
    _onlyManager();
    if (token == address(0)) revert ZERO_ADDRESS();
    if (!tokenData[token].isSupportedERC20) revert TOKEN_NOT_SUPPORTED();
    if (tokenData[token].isActive) revert TOKEN_ALREADY_ACTIVE();
    tokenData[token].isActive = true;
    emit ERC20Activated(token);
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
┌─ [0] ⚙️ FUNCTION: SuperAsset.activateERC20(address) (NodeID: 0)
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

@notice Activates a previously deactivated ERC20 token
 @param token Address of the token to activate
