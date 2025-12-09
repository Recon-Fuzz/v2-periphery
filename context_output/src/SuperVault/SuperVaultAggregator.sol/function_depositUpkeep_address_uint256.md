# Function: depositUpkeep(address,uint256)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `depositUpkeep(address,uint256)`
- **Visibility**: external
- **Source Range**: 15668:606:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function depositUpkeep(address strategy, uint256 amount) external validStrategy(strategy) {
    if (amount == 0) revert ZERO_AMOUNT();
    address upkeepToken = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.UPKEEP_TOKEN());
    IERC20(upkeepToken).safeTransferFrom(msg.sender, address(this), amount);
    _strategyUpkeepBalance[strategy] += amount;
    emit UpkeepDeposited(strategy, msg.sender, amount);
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

- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::UPKEEP_TOKEN()**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_strategyUpkeepBalance** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.depositUpkeep(address,uint256) (NodeID: 0)
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

@notice Deposits upkeep tokens for strategy upkeep
 @dev The upkeep token is configurable per chain (UP on mainnet, WETH on L2s, etc.)
 @param strategy Address of the strategy to deposit for
 @param amount Amount of upkeep tokens to deposit
