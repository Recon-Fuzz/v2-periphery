# Function: getProposedSuperBankHookMerkleRoot(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getProposedSuperBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 32074:381:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getProposedSuperBankHookMerkleRoot(address hook) external view returns (bytes32 proposedRoot, uint256 effectiveTime) {
    if (!_registeredHooks.contains(hook)) revert HOOK_NOT_APPROVED();
    ISuperGovernor.HookMerkleRootData storage data = superBankHooksMerkleRoots[hook];
    return (data.proposedRoot, data.effectiveTime);
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

- **_registeredHooks** (`struct EnumerableSet.AddressSet`)
- **superBankHooksMerkleRoots** (`mapping(address => struct ISuperGovernor.HookMerkleRootData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getProposedSuperBankHookMerkleRoot(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 1)
      💬 Args: [_registeredHooks, hook]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 2)
        💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the proposed Merkle root and its effective time for a specific hook.
 @param hook The address of the hook to get the proposed Merkle root for.
 @return proposedRoot The proposed Merkle root.
 @return effectiveTime The timestamp when the proposed root will become effective.
