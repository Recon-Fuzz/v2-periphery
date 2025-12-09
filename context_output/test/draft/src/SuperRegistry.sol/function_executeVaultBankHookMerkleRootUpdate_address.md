# Function: executeVaultBankHookMerkleRootUpdate(address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `executeVaultBankHookMerkleRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 8902:628:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function executeVaultBankHookMerkleRootUpdate(address hook) external {
    if (!_registeredHooks.contains(hook)) revert HOOK_NOT_APPROVED();
    ISuperRegistry.HookMerkleRootData storage data = vaultBankHooksMerkleRoots[hook];
    bytes32 proposedRoot = data.proposedRoot;
    if (proposedRoot == bytes32(0)) revert NO_PROPOSED_MERKLE_ROOT();
    if (block.timestamp < data.effectiveTime) revert TIMELOCK_NOT_EXPIRED();
    data.currentRoot = proposedRoot;
    data.proposedRoot = bytes32(0);
    data.effectiveTime = 0;
    emit VaultBankHookMerkleRootUpdated(hook, proposedRoot);
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
- **vaultBankHooksMerkleRoots** (`mapping(address => struct ISuperRegistry.HookMerkleRootData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.executeVaultBankHookMerkleRootUpdate(address) (NodeID: 0)
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

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Executes a previously proposed Merkle root update for a specific hook if the effective time has passed.
 @param hook The address of the hook to execute the update for.
