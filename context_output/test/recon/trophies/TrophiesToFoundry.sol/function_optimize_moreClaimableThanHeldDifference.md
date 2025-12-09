# Function: optimize_moreClaimableThanHeldDifference()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `optimize_moreClaimableThanHeldDifference()`
- **Visibility**: public
- **Source Range**: 13300:586:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Optimize the difference between the amount of claimable assets and assets in the system
function optimize_moreClaimableThanHeldDifference() public view returns (int256) {
    address[] memory actors = _getActors();
    uint256 summedClaimableRedemptionsAsAssets;
    for (uint256 i; i < actors.length; i++) {
        summedClaimableRedemptionsAsAssets += superVault.maxWithdraw(actors[i]);
    }
    uint256 totalAssets = _sumStrategyAssets();
    if (summedClaimableRedemptionsAsAssets > totalAssets) {
        return int256(summedClaimableRedemptionsAsAssets) - int256(totalAssets);
    } else {
        return 0;
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

### _sumStrategyAssets()

- **Kind**: internal
- **Source**: 4456:764:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumStrategyAssets()`

```solidity
function _sumStrategyAssets() public view returns (uint256) {
    address asset = superVault.asset();
    uint256 totalAssets;
    totalAssets += IERC20(asset).balanceOf(address(superVaultStrategy));
    address[] memory yieldSources = _getYieldSources();
    for (uint256 i = 0; i < yieldSources.length; i++) {
        if (yieldSources[i] != address(0)) {
            totalAssets += IERC20(asset).balanceOf(yieldSources[i]);
        }
    }
    return totalAssets;
}
```

### _getYieldSources()

- **Kind**: internal
- **Source**: 1799:115:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSources()`

```solidity
/// @notice Returns all yield sources being used
function _getYieldSources() internal view returns (address[] memory) {
    return _yieldSources.values();
}
```

## External Calls

- **SuperVault::maxWithdraw(address)**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.optimize_moreClaimableThanHeldDifference() (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 4)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 6)
          💬 Args: [_yieldSources]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 7)
            💬 Args: [set._inner]
            👁️  Def: private
```

## Documentation

### Function Documentation

@dev Optimize the difference between the amount of claimable assets and assets in the system
