# Function: cancelChangePrimaryManager(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `cancelChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 27163:836:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function cancelChangePrimaryManager(address strategy) external validStrategy(strategy) {
    if (_strategyData[strategy].mainManager != msg.sender) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    if (_strategyData[strategy].proposedManager == address(0)) {
        revert NO_PENDING_MANAGER_CHANGE();
    }
    address cancelledManager = _strategyData[strategy].proposedManager;
    _strategyData[strategy].proposedManager = address(0);
    _strategyData[strategy].proposedFeeRecipient = address(0);
    _strategyData[strategy].managerChangeEffectiveTime = 0;
    emit PrimaryManagerChangeCancelled(strategy, cancelledManager);
}
```

## Related Implementations

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

## State Variable Reads

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.cancelChangePrimaryManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: UnsafeSuperVaultAggregator.validStrategy(address) (NodeID: 1)
      💬 Args: [strategy]
    └─ [2] ⚙️ FUNCTION: UnsafeSuperVaultAggregator._validStrategy(address) (NodeID: 2)
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

@notice Cancels a pending primary manager change proposal
 @dev Only the current primary manager can cancel the proposal
 @param strategy Address of the strategy
