# Function: viewAllLockedAssets()

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `viewAllLockedAssets()`
- **Visibility**: external
- **Source Range**: 1504:118:554
- **Inherited From**: VaultBankSource

## Implementation

```solidity
/// @inheritdoc IVaultBankSource
function viewAllLockedAssets() external view returns (address[] memory) {
    return _lockedAssets.values();
}
```

## Related Implementations

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 13769:273:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    assembly ("memory-safe") {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 6418:109:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

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

- **_lockedAssets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankSource.viewAllLockedAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 1)
      💬 Args: [_lockedAssets]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 2)
        💬 Args: [set._inner]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IVaultBankSource

### Interface Documentation

@notice Get all the locked assets of a destination chain
