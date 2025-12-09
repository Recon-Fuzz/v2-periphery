# Function: changePrimaryManager(address,address,address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `changePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 23822:2287:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
///  @dev SECURITY: This is the emergency governance override function
///  @dev Clears ALL pending proposals and secondary managers to prevent malicious manager attacks:
///       - Pending manager change proposals
///       - Pending hooks root proposals
///       - Pending minUpdateInterval proposals
///       - ALL secondary managers (they may be controlled by malicious manager)
///  @dev This ensures clean slate for new manager without inherited vulnerabilities
function changePrimaryManager(address strategy, address newManager, address feeRecipient) external validStrategy(strategy) {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    if ((newManager == address(0)) || (feeRecipient == address(0))) revert ZERO_ADDRESS();
    address oldManager = _strategyData[strategy].mainManager;
    _strategyData[strategy].proposedManager = address(0);
    _strategyData[strategy].managerChangeEffectiveTime = 0;
    _strategyData[strategy].proposedHooksRoot = bytes32(0);
    _strategyData[strategy].hooksRootEffectiveTime = 0;
    _strategyData[strategy].proposedMinUpdateInterval = 0;
    _strategyData[strategy].minUpdateIntervalEffectiveTime = 0;
    address[] memory clearedSecondaryManagers = _strategyData[strategy].secondaryManagers.values();
    for (uint256 i = 0; i < clearedSecondaryManagers.length; i++) {
        _strategyData[strategy].secondaryManagers.remove(clearedSecondaryManagers[i]);
        emit SecondaryManagerRemoved(strategy, clearedSecondaryManagers[i]);
    }
    if (pendingUpkeepWithdrawals[strategy].effectiveTime != 0) {
        delete pendingUpkeepWithdrawals[strategy];
        emit UpkeepWithdrawalCancelled(strategy);
    }
    ISuperVaultStrategy(strategy).changeFeeRecipient(feeRecipient);
    _strategyData[strategy].mainManager = newManager;
    emit PrimaryManagerChanged(strategy, oldManager, newManager, feeRecipient);
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

### validStrategy(address)

- **Kind**: modifier
- **Source**: 4207:93:634
- **Link**: `test/recon/helpers/UnsafeSuperVaultAggregator.sol:UnsafeSuperVaultAggregator:validStrategy(address)`

```solidity
/// @notice Validates that a strategy exists (has been created by this aggregator)
modifier validStrategy(address strategy) {
    _validStrategy(strategy);
    _;
}
```

### _validStrategy(address)

- **Kind**: internal
- **Source**: 4306:145:634
- **Link**: `test/recon/helpers/UnsafeSuperVaultAggregator.sol:UnsafeSuperVaultAggregator:_validStrategy(address)`

```solidity
function _validStrategy(address strategy) internal view {
    if (!_superVaultStrategies.contains(strategy)) revert UNKNOWN_STRATEGY();
}
```

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

## External Calls

- **ISuperVaultStrategy::changeFeeRecipient(address)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.changePrimaryManager(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_strategyData[strategy].secondaryManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 3)
  │   💬 Args: [_strategyData[strategy].secondaryManagers, clearedSecondaryManagers[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 4)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: UnsafeSuperVaultAggregator.validStrategy(address) (NodeID: 5)
      💬 Args: [strategy]
    └─ [2] ⚙️ FUNCTION: UnsafeSuperVaultAggregator._validStrategy(address) (NodeID: 6)
        💬 Args: [strategy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 7)
          💬 Args: [_superVaultStrategies, strategy]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 8)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator
 @dev SECURITY: This is the emergency governance override function
 @dev Clears ALL pending proposals and secondary managers to prevent malicious manager attacks:
      - Pending manager change proposals
      - Pending hooks root proposals
      - Pending minUpdateInterval proposals
      - ALL secondary managers (they may be controlled by malicious manager)
 @dev This ensures clean slate for new manager without inherited vulnerabilities

### Interface Documentation

@notice Changes the primary manager of a strategy immediately (only callable by SuperGovernor)
 @notice A manager can either be secondary or primary
 @param strategy Address of the strategy
 @param newManager Address of the new primary manager
 @param feeRecipient Address of the new fee recipient
