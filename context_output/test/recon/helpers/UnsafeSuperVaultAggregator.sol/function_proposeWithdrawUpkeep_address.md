# Function: proposeWithdrawUpkeep(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `proposeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 16000:849:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeWithdrawUpkeep(address strategy) external validStrategy(strategy) {
    if (msg.sender != _strategyData[strategy].mainManager) {
        revert UNAUTHORIZED_UPDATE_AUTHORITY();
    }
    uint256 currentBalance = _strategyUpkeepBalance[strategy];
    if (currentBalance == 0) revert ZERO_AMOUNT();
    pendingUpkeepWithdrawals[strategy] = UpkeepWithdrawalRequest({amount: currentBalance, effectiveTime: block.timestamp + UPKEEP_WITHDRAWAL_TIMELOCK});
    emit UpkeepWithdrawalProposed(strategy, msg.sender, currentBalance, block.timestamp + UPKEEP_WITHDRAWAL_TIMELOCK);
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
- **_strategyUpkeepBalance** (`mapping(address => uint256)`)
- **UPKEEP_WITHDRAWAL_TIMELOCK** (`uint256`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.proposeWithdrawUpkeep(address) (NodeID: 0)
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

@notice Proposes withdrawal of upkeep tokens from strategy upkeep balance (starts 24h timelock)
 @dev Only the main manager can propose. Withdraws full balance at time of proposal.
 @param strategy Address of the strategy to withdraw from
