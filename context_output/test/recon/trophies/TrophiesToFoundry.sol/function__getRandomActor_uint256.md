# Function: _getRandomActor(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `_getRandomActor(uint256)`
- **Visibility**: public
- **Source Range**: 17946:176:631
- **Inherited From**: Setup

## Implementation

```solidity
function _getRandomActor(uint256 entropy) public view returns (address) {
    address[] memory actors = _getActors();
    return actors[entropy % actors.length];
}
```

## Related Implementations

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Setup._getRandomActor(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 2)
        💬 Args: [_actors]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 3)
          💬 Args: [set._inner]
          👁️  Def: private
```
