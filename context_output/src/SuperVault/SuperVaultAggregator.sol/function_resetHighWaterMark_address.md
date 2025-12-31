# Function: resetHighWaterMark(address)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 32394:484:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
///  @dev SECURITY: This function is intended to be used by governance to onboard a new manager without penalizing
///  them for the previous manager's performance.
///  @dev If a manager is replaced while the strategy is below its
///  previous HWM, the new manager would otherwise inherit a "loss" state and be unable to earn performance fees
///  until the fee config are updated after the week timelock.
///  @dev Calling this function resets the HWM to the current PPS, allowing a newly appointed manager to start from a
///  neutral baseline. @dev This function is only callable by SUPER_GOVERNOR
function resetHighWaterMark(address strategy) external validStrategy(strategy) {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    uint256 newHwmPps = _strategyData[strategy].pps;
    ISuperVaultStrategy(strategy).resetHighWaterMark(newHwmPps);
    emit HighWaterMarkReset(strategy, newHwmPps);
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

## External Calls

- **ISuperVaultStrategy::resetHighWaterMark(uint256)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.resetHighWaterMark(address) (NodeID: 0)
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
 @dev SECURITY: This function is intended to be used by governance to onboard a new manager without penalizing
 them for the previous manager's performance.
 @dev If a manager is replaced while the strategy is below its
 previous HWM, the new manager would otherwise inherit a "loss" state and be unable to earn performance fees
 until the fee config are updated after the week timelock.
 @dev Calling this function resets the HWM to the current PPS, allowing a newly appointed manager to start from a
 neutral baseline. @dev This function is only callable by SUPER_GOVERNOR

### Interface Documentation

@notice Resets the strategy's performance-fee high-water mark to PPS
 @dev Only callable by SuperGovernor
 @param strategy Address of the strategy
