# Function: executeMinUpdateIntervalChange(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `executeMinUpdateIntervalChange(address)`
- **Visibility**: external
- **Source Range**: 39042:989:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function executeMinUpdateIntervalChange(address strategy) external validStrategy(strategy) {
    if (_strategyData[strategy].minUpdateIntervalEffectiveTime == 0) {
        revert NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE();
    }
    if (block.timestamp < _strategyData[strategy].minUpdateIntervalEffectiveTime) {
        revert TIMELOCK_NOT_EXPIRED();
    }
    uint256 newInterval = _strategyData[strategy].proposedMinUpdateInterval;
    uint256 oldInterval = _strategyData[strategy].minUpdateInterval;
    _strategyData[strategy].proposedMinUpdateInterval = 0;
    _strategyData[strategy].minUpdateIntervalEffectiveTime = 0;
    _strategyData[strategy].minUpdateInterval = newInterval;
    emit MinUpdateIntervalChanged(strategy, oldInterval, newInterval);
}
```

## Related Implementations

### validStrategy(address)

- **Kind**: modifier
- **Source**: 4358:93:511
- **Link**: `src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator:validStrategy(address)`

```solidity
/// @notice Validates that a strategy exists (has been created by this aggregator)
modifier validStrategy(address strategy) {
    _validStrategy(strategy);
    _;
}
```

### _validStrategy(address)

- **Kind**: internal
- **Source**: 4457:145:511
- **Link**: `src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator:_validStrategy(address)`

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

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.executeMinUpdateIntervalChange(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: SuperVaultAggregator.validStrategy(address) (NodeID: 1)
      💬 Args: [strategy]
    └─ [2] ⚙️ FUNCTION: SuperVaultAggregator._validStrategy(address) (NodeID: 2)
        💬 Args: [strategy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
          💬 Args: [_superVaultStrategies, strategy]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Executes a previously proposed minUpdateInterval change after timelock
 @param strategy Address of the strategy whose minUpdateInterval to update
 @dev Can be called by anyone after the timelock period has elapsed
