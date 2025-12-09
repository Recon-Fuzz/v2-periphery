# Function: property_escrowBalance()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `property_escrowBalance()`
- **Visibility**: public
- **Source Range**: 2373:465:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: balanceOf(escrow) >= SUM(controllers.pendingRedeemRequest)
function property_escrowBalance() public {
    address[] memory actors = _getActors();
    uint256 escrowBalance = superVault.balanceOf(address(superVaultEscrow));
    uint256 pendingActorShares;
    for (uint256 i; i < actors.length; i++) {
        pendingActorShares += superVault.pendingRedeemRequest(0, actors[i]);
    }
    gte(escrowBalance, pendingActorShares, "balanceOf(escrow) < SUM(controllers.pendingRedeemRequest)");
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

### gte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 312:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertGe(a, b, reason);
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 17502:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left < right) {
        vm.assertGe(left, right, err);
    }
}
```

## External Calls

- **SuperVault::balanceOf(address)**
- **SuperVault::pendingRedeemRequest(uint256,address)**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_escrowBalance() (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 4)
      💬 Args: [escrowBalance, pendingActorShares, "balanceOf(escrow) < SUM(controllers.pendingRedeemRequest)"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 5)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: balanceOf(escrow) >= SUM(controllers.pendingRedeemRequest)
