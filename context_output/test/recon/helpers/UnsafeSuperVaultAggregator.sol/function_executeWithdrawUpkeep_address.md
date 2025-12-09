# Function: executeWithdrawUpkeep(address)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `executeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 16897:1415:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function executeWithdrawUpkeep(address strategy) external validStrategy(strategy) {
    UpkeepWithdrawalRequest memory request = pendingUpkeepWithdrawals[strategy];
    if (request.effectiveTime == 0) revert UPKEEP_WITHDRAWAL_NOT_FOUND();
    if (block.timestamp < request.effectiveTime) revert UPKEEP_WITHDRAWAL_NOT_READY();
    uint256 currentBalance = _strategyUpkeepBalance[strategy];
    uint256 withdrawalAmount = (currentBalance < request.amount) ? currentBalance : request.amount;
    if (withdrawalAmount == 0) revert ZERO_AMOUNT();
    delete pendingUpkeepWithdrawals[strategy];
    address upkeepToken = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.UPKEEP_TOKEN());
    unchecked {
        _strategyUpkeepBalance[strategy] -= withdrawalAmount;
    }
    address mainManager = _strategyData[strategy].mainManager;
    IERC20(upkeepToken).safeTransfer(mainManager, withdrawalAmount);
    emit UpkeepWithdrawn(strategy, mainManager, withdrawalAmount);
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

## External Calls

- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::UPKEEP_TOKEN()**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)
- **_strategyUpkeepBalance** (`mapping(address => uint256)`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **pendingUpkeepWithdrawals** (`mapping(address => struct ISuperVaultAggregator.UpkeepWithdrawalRequest)`)
- **_strategyUpkeepBalance** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.executeWithdrawUpkeep(address) (NodeID: 0)
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

@notice Executes a pending upkeep withdrawal after 24h timelock
 @dev Anyone can execute, but funds go to the main manager of the strategy
 @param strategy Address of the strategy to withdraw from
