# Function: property_totalAssets()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_totalAssets()`
- **Visibility**: public
- **Source Range**: 4424:408:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: SUM(shares) * PPS == totalAssets
function property_totalAssets() public {
    uint256 totalShares = _sumTotalShares();
    uint256 pps = superVaultAggregator.getPPS(address(superVaultStrategy));
    uint256 implicitTotalAssets = (totalShares * pps) / superVault.PRECISION();
    uint256 vaultTotalAssets = superVault.totalAssets();
    eq(implicitTotalAssets, vaultTotalAssets, "totalShares * pps != totalAssets");
}
```

## Related Implementations

### _sumTotalShares()

- **Kind**: internal
- **Source**: 3160:365:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumTotalShares()`

```solidity
/// @dev total shares in the system is the sum of shares in the escrow and held by all users
function _sumTotalShares() internal view returns (uint256) {
    address[] memory actors = _getActors();
    uint256 totalShares;
    totalShares += superVault.balanceOf(address(superVaultEscrow));
    for (uint256 i; i < actors.length; i++) {
        totalShares += superVault.balanceOf(actors[i]);
    }
    return totalShares;
}
```

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

### eq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 909:181:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a == b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **UnsafeSuperVaultAggregator::getPPS(address)**
- **SuperVault::PRECISION()**
- **SuperVault::totalAssets()**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 3)
  │       💬 Args: [_actors]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 4)
  │         💬 Args: [set._inner]
  │         👁️  Def: private
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [implicitTotalAssets, vaultTotalAssets, "totalShares * pps != totalAssets"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: SUM(shares) * PPS == totalAssets
