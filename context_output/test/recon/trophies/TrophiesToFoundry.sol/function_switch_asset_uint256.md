# Function: switch_asset(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 897:84:648
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public {
    _switchAsset(entropy);
}
```

## Related Implementations

### _switchAsset(uint256)

- **Kind**: internal
- **Source**: 2588:127:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_switchAsset(uint256)`

```solidity
/// @notice Switches the current asset based on the entropy
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @param entropy The entropy to choose a random asset in the array for switching
function _switchAsset(uint256 entropy) internal {
    address target = _assets.at(entropy);
    __asset = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

## State Variable Reads

- **_assets** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **__asset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.switch_asset(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AssetManager._switchAsset(uint256) (NodeID: 1)
      💬 Args: [entropy]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 2)
        💬 Args: [_assets, entropy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 3)
          💬 Args: [set._inner, index]
          👁️  Def: private
```

## Documentation

### Function Documentation

@dev Starts using a new asset
