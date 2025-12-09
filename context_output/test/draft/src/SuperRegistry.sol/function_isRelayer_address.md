# Function: isRelayer(address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `isRelayer(address)`
- **Visibility**: external
- **Source Range**: 13842:116:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function isRelayer(address relayer) external view returns (bool) {
    return _relayers.contains(relayer);
}
```

## Related Implementations

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 12370:165:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 5101:129:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
}
```

## State Variable Reads

- **_relayers** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.isRelayer(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 1)
      💬 Args: [_relayers, relayer]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 2)
        💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Checks if an address is an approved relayer
 @param relayer The address to check
 @return True if the address is an approved relayer, false otherwise
