# Function: executeAddIncentiveTokens()

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `executeAddIncentiveTokens()`
- **Visibility**: external
- **Source Range**: 11082:746:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function executeAddIncentiveTokens() external {
    if ((_proposedAddWhitelistedIncentiveTokensEffectiveTime == 0) || (block.timestamp < _proposedAddWhitelistedIncentiveTokensEffectiveTime)) revert TIMELOCK_NOT_EXPIRED();
    address[] memory tokensToAdd = _proposedWhitelistedIncentiveTokens.values();
    uint256 len = tokensToAdd.length;
    address token;
    for (uint256 i; i < len; i++) {
        token = tokensToAdd[i];
        _isWhitelistedIncentiveToken[token] = true;
        _proposedWhitelistedIncentiveTokens.remove(token);
    }
    emit WhitelistedIncentiveTokensAdded(tokensToAdd);
    _proposedAddWhitelistedIncentiveTokensEffectiveTime = 0;
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

### remove(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11736:156:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:remove(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function remove(AddressSet storage set, address value) internal returns (bool) {
    return _remove(set._inner, bytes32(uint256(uint160(value))));
}
```

### _remove(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 3071:1368:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_remove(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function _remove(Set storage set, bytes32 value) private returns (bool) {
    uint256 position = set._positions[value];
    if (position != 0) {
        uint256 valueIndex = position - 1;
        uint256 lastIndex = set._values.length - 1;
        if (valueIndex != lastIndex) {
            bytes32 lastValue = set._values[lastIndex];
            set._values[valueIndex] = lastValue;
            set._positions[lastValue] = position;
        }
        set._values.pop();
        delete set._positions[value];
        return true;
    } else {
        return false;
    }
}
```

## State Variable Reads

- **_proposedAddWhitelistedIncentiveTokensEffectiveTime** (`uint256`)
- **_proposedWhitelistedIncentiveTokens** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_isWhitelistedIncentiveToken** (`mapping(address => bool)`)
- **_proposedWhitelistedIncentiveTokens** (`struct EnumerableSet.AddressSet`)
- **_proposedAddWhitelistedIncentiveTokensEffectiveTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.executeAddIncentiveTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_proposedWhitelistedIncentiveTokens]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 3)
      💬 Args: [_proposedWhitelistedIncentiveTokens, token]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 4)
        💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Executes a previously proposed whitelisted incentive token update after timelock has expired
