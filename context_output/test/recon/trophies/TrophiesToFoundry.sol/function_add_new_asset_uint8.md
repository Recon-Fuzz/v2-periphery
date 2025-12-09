# Function: add_new_asset(uint8)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 1086:144:648
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address) {
    address newAsset = _newAsset(decimals);
    return newAsset;
}
```

## Related Implementations

### _newAsset(uint8)

- **Kind**: internal
- **Source**: 1438:328:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_newAsset(uint8)`

```solidity
/// @notice Creates a new asset and adds it to the list of assets
///  @param decimals The number of decimals for the asset
///  @return The address of the new asset
function _newAsset(uint8 decimals) internal returns (address) {
    address asset_ = address(new MockERC20("Test Token", "TST", decimals));
    _addAsset(asset_);
    __asset = asset_;
    return asset_;
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

## State Variable Reads

- **_assets** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **__asset** (`address`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.add_new_asset(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AssetManager._newAsset(uint8) (NodeID: 1)
      💬 Args: [decimals]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 2)
        💬 Args: [asset_]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
      │   💬 Args: [_assets, target]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
      │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
          💬 Args: [_assets, target]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
          └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
              💬 Args: [set, value]
              👁️  Def: private
```

## Documentation

### Function Documentation

@dev Deploy a new token and add it to the list of assets, then set it as the current asset
