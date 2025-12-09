# Function: executeChangePrimaryManager(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `executeChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 28047:1802:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function executeChangePrimaryManager(address strategy) external validStrategy(strategy) {
    if (_strategyData[strategy].proposedManager == address(0)) revert NO_PENDING_MANAGER_CHANGE();
    if (block.timestamp < _strategyData[strategy].managerChangeEffectiveTime) revert TIMELOCK_NOT_EXPIRED();
    address newManager = _strategyData[strategy].proposedManager;
    address oldManager = _strategyData[strategy].mainManager;
    _strategyData[strategy].secondaryManagers.clear();
    if (pendingUpkeepWithdrawals[strategy].effectiveTime != 0) {
        delete pendingUpkeepWithdrawals[strategy];
        emit UpkeepWithdrawalCancelled(strategy);
    }
    _strategyData[strategy].proposedHooksRoot = bytes32(0);
    _strategyData[strategy].hooksRootEffectiveTime = 0;
    _strategyData[strategy].proposedMinUpdateInterval = 0;
    _strategyData[strategy].minUpdateIntervalEffectiveTime = 0;
    _strategyData[strategy].mainManager = newManager;
    address feeRecipient = _strategyData[strategy].proposedFeeRecipient;
    ISuperVaultStrategy(strategy).changeFeeRecipient(feeRecipient);
    _strategyData[strategy].proposedManager = address(0);
    _strategyData[strategy].proposedFeeRecipient = address(0);
    _strategyData[strategy].managerChangeEffectiveTime = 0;
    emit PrimaryManagerChanged(strategy, oldManager, newManager, feeRecipient);
}
```

## Related Implementations

### clear(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 12206:83:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:clear(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Removes all the values from a set. O(n).
///  WARNING: Developers should keep in mind that this function has an unbounded cost and using it may render the
///  function uncallable if the set grows to the point where clearing it consumes too much gas to fit in a block.
function clear(AddressSet storage set) internal {
    _clear(set._inner);
}
```

### _clear(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4783:237:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_clear(struct EnumerableSet.Set)`

```solidity
///  @dev Removes all the values from a set. O(n).
///  WARNING: This function has an unbounded cost that scales with set size. Developers should keep in mind that
///  using it may render the function uncallable if the set grows to the point where clearing it consumes too much
///  gas to fit in a block.
function _clear(Set storage set) private {
    uint256 len = _length(set);
    for (uint256 i = 0; i < len; ++i) {
        delete set._positions[set._values[i]];
    }
    Arrays.unsafeSetLength(set._values, 0);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5311:107:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

### unsafeSetLength(bytes32[],uint256)

- **Kind**: internal
- **Source**: 19534:160:275
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Arrays.sol:Arrays:unsafeSetLength(bytes32[],uint256)`

```solidity
///  @dev Helper to set the length of a dynamic array. Directly writing to `.length` is forbidden.
///  WARNING: this does not clear elements if length is reduced, of initialize elements if length is increased.
function unsafeSetLength(bytes32[] storage array, uint256 len) internal {
    assembly ("memory-safe") {
        sstore(array.slot, len)
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

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.executeChangePrimaryManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.clear(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_strategyData[strategy].secondaryManagers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._clear(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 3)
  │   │   💬 Args: [set]
  │   │   👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: Arrays.unsafeSetLength(bytes32[],uint256) (NodeID: 4)
  │       💬 Args: [set._values, 0]
  │       👁️  Def: internal
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

### Interface Documentation

@notice Executes a previously proposed change to the primary manager after timelock
 @param strategy Address of the strategy
