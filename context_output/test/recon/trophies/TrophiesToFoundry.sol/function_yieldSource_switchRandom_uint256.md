# Function: yieldSource_switchRandom(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `yieldSource_switchRandom(uint256)`
- **Visibility**: public
- **Source Range**: 13008:170:655
- **Inherited From**: YieldSourceTargets

## Implementation

```solidity
function yieldSource_switchRandom(uint256 entropy) public {
    _switchYieldSource(entropy);
}
```

## Related Implementations

### _switchYieldSource(uint256)

- **Kind**: internal
- **Source**: 5113:170:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_switchYieldSource(uint256)`

```solidity
/// @notice Switches the current yield source based on the entropy
///  @param entropy The entropy to choose a random yield source in the array for switching
function _switchYieldSource(uint256 entropy) internal {
    address target = _yieldSources.at(entropy % _yieldSources.length());
    __yieldSource = target;
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

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 9106:115:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4463:107:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
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

- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **__yieldSource** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: YieldSourceTargets.yieldSource_switchRandom(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: YieldManager._switchYieldSource(uint256) (NodeID: 1)
      💬 Args: [entropy]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 2)
        💬 Args: [_yieldSources, entropy % _yieldSources.length()]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 4)
      │   💬 Args: [_yieldSources]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 5)
      │     💬 Args: [set._inner]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 3)
          💬 Args: [set._inner, index]
          👁️  Def: private
```
