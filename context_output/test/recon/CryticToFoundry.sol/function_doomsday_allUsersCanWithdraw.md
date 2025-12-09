# Function: doomsday_allUsersCanWithdraw()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `doomsday_allUsersCanWithdraw()`
- **Visibility**: public
- **Source Range**: 14094:789:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Property: all users can withdraw (solvency)
function doomsday_allUsersCanWithdraw() public {
    address[] memory actors = _getActors();
    bool paused = superVaultAggregator.isStrategyPaused(address(superVaultStrategy));
    for (uint256 i; i < actors.length; i++) {
        uint256 withdrawable = superVault.maxWithdraw(actors[i]);
        if ((withdrawable > 0) && (!paused)) {
            vm.prank(actors[i]);
            try superVault.withdraw(withdrawable, actors[i], actors[i]) {} catch {
                t(false, "users should always be able to withdraw unless the system is paused");
            }
        }
    }
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

### t(bool,string)

- **Kind**: internal
- **Source**: 822:105:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    assertTrue(b, reason);
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **UnsafeSuperVaultAggregator::isStrategyPaused(address)**
- **SuperVault::maxWithdraw(address)**
- **Vm::prank(address)**
- **SuperVault::withdraw(uint256,address,address)**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.doomsday_allUsersCanWithdraw() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 2)
  │     💬 Args: [_actors]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 3)
  │       💬 Args: [set._inner]
  │       👁️  Def: private
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 4)
      💬 Args: [false, "users should always be able to withdraw unless the system is paused"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
        💬 Args: [b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: all users can withdraw (solvency)
