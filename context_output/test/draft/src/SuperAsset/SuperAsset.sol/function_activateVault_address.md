# Function: activateVault(address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `activateVault(address)`
- **Visibility**: external
- **Source Range**: 7281:404:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function activateVault(address vault) external {
    _onlyManager();
    if (vault == address(0)) revert ZERO_ADDRESS();
    if (!tokenData[vault].isSupportedUnderlyingVault) revert VAULT_NOT_SUPPORTED();
    if (tokenData[vault].isActive) revert TOKEN_ALREADY_ACTIVE();
    tokenData[vault].isActive = true;
    emit VaultActivated(vault);
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
┌─ [0] ⚙️ FUNCTION: SuperAsset.activateVault(address) (NodeID: 0)
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

@notice Activates a previously deactivated vault
 @param vault Address of the vault to activate
