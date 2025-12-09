# Function: removeVault(address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `removeVault(address)`
- **Visibility**: external
- **Source Range**: 6671:572:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function removeVault(address vault) external {
    _onlyManager();
    if (vault == address(0)) revert ZERO_ADDRESS();
    tokenData[vault].isActive = false;
    if (IERC20(vault).balanceOf(address(this)) == 0) {
        _supportedAssets.remove(vault);
        tokenData[vault].oracle = address(0);
        tokenData[vault].isSupportedUnderlyingVault = false;
    }
    emit VaultRemoved(vault);
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

### remove(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11736:156:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:remove(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function remove(AddressSet storage set, address value) internal returns (bool) {
    return _remove(set._inner, bytes32(uint256(uint160(value))));
}
```

### _remove(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 3071:1368:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_remove(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function _remove(Set storage set, bytes32 value) private returns (bool) {
    uint256 position = set._positions[value];
    if (position != 0) {
        uint256 valueIndex = position - 1;
        uint256 lastIndex = set._values.length - 1;
        if (valueIndex != lastIndex) {
            bytes32 lastValue = set._values[lastIndex];
            set._values[valueIndex] = lastValue;
            set._positions[lastValue] = position;
        }
        set._values.pop();
        delete set._positions[value];
        return true;
    } else {
        return false;
    }
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **_supportedAssets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.removeVault(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperAsset._onlyManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 2)
      💬 Args: [_supportedAssets, vault]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 3)
        💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Removes a vault from whitelist
 @param vault Address of the vault to remove
