# Function: pauseStrategy(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `pauseStrategy(address)`
- **Visibility**: external
- **Source Range**: 18674:571:634

## Implementation

```solidity
/// @notice Manually pauses a strategy
///  @param strategy Address of the strategy to pause
///  @dev Only the main or secondary manager of the strategy can pause it
function pauseStrategy(address strategy) external validStrategy(strategy) {
    if (!isAnyManager(msg.sender, strategy)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    if (_strategyData[strategy].isPaused) {
        revert STRATEGY_ALREADY_PAUSED();
    }
    _strategyData[strategy].isPaused = true;
    _strategyData[strategy].ppsStale = true;
    emit StrategyPaused(strategy);
}
```

## Related Implementations

### isAnyManager(address,address)

- **Kind**: internal
- **Source**: 43680:301:634
- **Link**: `test/recon/helpers/UnsafeSuperVaultAggregator.sol:UnsafeSuperVaultAggregator:isAnyManager(address,address)`

```solidity
/// @inheritdoc ISuperVaultAggregator
function isAnyManager(address manager, address strategy) public view returns (bool) {
    StrategyData storage data = _strategyData[strategy];
    return (data.mainManager == manager) || data.secondaryManagers.contains(manager);
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

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.pauseStrategy(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.isAnyManager(address,address) (NodeID: 1)
  │   💬 Args: [msg.sender, strategy]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 2)
  │     💬 Args: [data.secondaryManagers, manager]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 3)
  │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: UnsafeSuperVaultAggregator.validStrategy(address) (NodeID: 4)
      💬 Args: [strategy]
    └─ [2] ⚙️ FUNCTION: UnsafeSuperVaultAggregator._validStrategy(address) (NodeID: 5)
        💬 Args: [strategy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 6)
          💬 Args: [_superVaultStrategies, strategy]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
```

## Documentation

### Function Documentation

@notice Manually pauses a strategy
 @param strategy Address of the strategy to pause
 @dev Only the main or secondary manager of the strategy can pause it

### Interface Documentation

@notice Manually pauses a strategy
 @param strategy Address of the strategy to pause
