# Function: getSuperVaultsCount()

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `getSuperVaultsCount()`
- **Visibility**: external
- **Source Range**: 44029:108:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function getSuperVaultsCount() external view returns (uint256) {
    return _superVaults.length();
}
```

## Related Implementations

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 12616:115:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5311:107:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

## State Variable Reads

- **_superVaults** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.getSuperVaultsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 1)
      💬 Args: [_superVaults]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 2)
        💬 Args: [set._inner]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Gets the total number of SuperVaults
 @return count The total number of SuperVaults
