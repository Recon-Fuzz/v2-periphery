# Function: manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])`
- **Visibility**: external
- **Source Range**: 20091:580:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function manageYieldSources(address[] calldata sources, address[] calldata oracles, YieldSourceAction[] calldata actionTypes) external {
    _isPrimaryManager(msg.sender);
    uint256 length = sources.length;
    if (length == 0) revert ZERO_LENGTH();
    if (oracles.length != length) revert INVALID_ARRAY_LENGTH();
    if (actionTypes.length != length) revert INVALID_ARRAY_LENGTH();
    for (uint256 i; i < length; ++i) {
        _manageYieldSource(sources[i], oracles[i], actionTypes[i]);
    }
}
```

## Related Implementations

### _isPrimaryManager(address)

- **Kind**: internal
- **Source**: 35738:203:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isPrimaryManager(address)`

```solidity
/// @notice Internal function to check if a manager is the primary manager
///  @param manager_ The manager to check
function _isPrimaryManager(address manager_) internal view {
    if (!_getSuperVaultAggregator().isMainManager(manager_, address(this))) {
        revert MANAGER_NOT_AUTHORIZED();
    }
}
```

### _getSuperVaultAggregator()

- **Kind**: internal
- **Source**: 35041:251:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_getSuperVaultAggregator()`

```solidity
/// @notice Internal function to get the SuperVaultAggregator
///  @return The SuperVaultAggregator
function _getSuperVaultAggregator() internal view returns (ISuperVaultAggregator) {
    address aggregatorAddress = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_VAULT_AGGREGATOR());
    return ISuperVaultAggregator(aggregatorAddress);
}
```

### _manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)

- **Kind**: internal
- **Source**: 36170:434:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)`

```solidity
/// @notice Internal function to manage a yield source
///  @param source Address of the yield source
///  @param oracle Address of the oracle
///  @param actionType Type of action (see YieldSourceAction enum)
function _manageYieldSource(address source, address oracle, YieldSourceAction actionType) internal {
    if (actionType == YieldSourceAction.Add) {
        _addYieldSource(source, oracle);
    } else if (actionType == YieldSourceAction.UpdateOracle) {
        _updateYieldSourceOracle(source, oracle);
    } else if (actionType == YieldSourceAction.Remove) {
        _removeYieldSource(source);
    }
}
```

### _addYieldSource(address,address)

- **Kind**: internal
- **Source**: 36760:408:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_addYieldSource(address,address)`

```solidity
/// @notice Internal function to add a yield source
///  @param source Address of the yield source
///  @param oracle Address of the oracle
function _addYieldSource(address source, address oracle) internal {
    if ((source == address(0)) || (oracle == address(0))) revert ZERO_ADDRESS();
    if (yieldSources[source] != address(0)) revert YIELD_SOURCE_ALREADY_EXISTS();
    yieldSources[source] = oracle;
    if (!yieldSourcesList.add(source)) revert YIELD_SOURCE_ALREADY_EXISTS();
    emit YieldSourceAdded(source, oracle);
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11418:150:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2497:406:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._positions[value] = set._values.length;
        return true;
    } else {
        return false;
    }
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

### _updateYieldSourceOracle(address,address)

- **Kind**: internal
- **Source**: 37336:365:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_updateYieldSourceOracle(address,address)`

```solidity
/// @notice Internal function to update a yield source's oracle
///  @param source Address of the yield source
///  @param oracle Address of the oracle
function _updateYieldSourceOracle(address source, address oracle) internal {
    if (oracle == address(0)) revert ZERO_ADDRESS();
    address oldOracle = yieldSources[source];
    if (oldOracle == address(0)) revert YIELD_SOURCE_NOT_FOUND();
    yieldSources[source] = oracle;
    emit YieldSourceOracleUpdated(source, oldOracle, oracle);
}
```

### _removeYieldSource(address)

- **Kind**: internal
- **Source**: 37816:369:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_removeYieldSource(address)`

```solidity
/// @notice Internal function to remove a yield source
///  @param source Address of the yield source
function _removeYieldSource(address source) internal {
    if (yieldSources[source] == address(0)) revert YIELD_SOURCE_NOT_FOUND();
    delete yieldSources[source];
    if (!yieldSourcesList.remove(source)) revert YIELD_SOURCE_NOT_FOUND();
    emit YieldSourceRemoved(source);
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

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **yieldSources** (`mapping(address => address)`)

## State Variable Writes

- **yieldSources** (`mapping(address => address)`)
- **yieldSourcesList** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isPrimaryManager(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperVaultStrategy._manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction) (NodeID: 3)
      💬 Args: [sources[i], oracles[i], actionTypes[i]]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._addYieldSource(address,address) (NodeID: 4)
    │   💬 Args: [source, oracle]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
    │     💬 Args: [yieldSourcesList, source]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._updateYieldSourceOracle(address,address) (NodeID: 8)
    │   💬 Args: [source, oracle]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._removeYieldSource(address) (NodeID: 9)
        💬 Args: [source]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 10)
          💬 Args: [yieldSourcesList, source]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 11)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Batch manage multiple yield sources in a single transaction
 @param sources Array of yield source addresses
 @param oracles Array of oracle addresses (used for adding/updating, ignored for removal)
 @param actionTypes Array of action types (see YieldSourceAction enum)
