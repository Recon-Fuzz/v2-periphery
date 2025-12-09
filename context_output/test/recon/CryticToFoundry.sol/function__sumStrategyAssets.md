# Function: _sumStrategyAssets()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `_sumStrategyAssets()`
- **Visibility**: public
- **Source Range**: 4456:764:626
- **Inherited From**: BeforeAfter

## Implementation

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

## Related Implementations

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

## External Calls

- **SuperVault::asset()**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 2)
        💬 Args: [_yieldSources]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 3)
          💬 Args: [set._inner]
          👁️  Def: private
```
