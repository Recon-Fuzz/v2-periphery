# Function: createVault(struct ISuperVaultAggregator.VaultCreationParams)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `createVault(struct ISuperVaultAggregator.VaultCreationParams)`
- **Visibility**: external
- **Source Range**: 5799:3519:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function createVault(VaultCreationParams calldata params) external returns (address superVault, address strategy, address escrow) {
    if (((params.asset == address(0)) || (params.mainManager == address(0))) || (params.feeConfig.recipient == address(0))) {
        revert ZERO_ADDRESS();
    }
    /// @dev Check that name and symbol are not empty
    ///       We don't check for anything else and
    ///        it's up to the creator to ensure that the vault
    ///        is created with valid parameters
    if ((bytes(params.name).length == 0) || (bytes(params.symbol).length == 0)) {
        revert INVALID_VAULT_PARAMS();
    }
    VaultCreationLocalVars memory vars;
    vars.currentNonce = _vaultCreationNonce++;
    vars.salt = keccak256(abi.encode(msg.sender, params.asset, params.name, params.symbol, vars.currentNonce));
    superVault = VAULT_IMPLEMENTATION.cloneDeterministic(vars.salt);
    escrow = ESCROW_IMPLEMENTATION.cloneDeterministic(vars.salt);
    strategy = STRATEGY_IMPLEMENTATION.cloneDeterministic(vars.salt);
    SuperVault(superVault).initialize(params.asset, params.name, params.symbol, strategy, escrow);
    SuperVaultEscrow(escrow).initialize(superVault);
    SuperVaultStrategy(payable(strategy)).initialize(superVault, params.feeConfig);
    _superVaults.add(superVault);
    _superVaultStrategies.add(strategy);
    _superVaultEscrows.add(escrow);
    (bool success, uint8 assetDecimals) = params.asset.tryGetAssetDecimals();
    if (!success) revert INVALID_ASSET();
    vars.initialPPS = 10 ** assetDecimals;
    if (params.maxStaleness < SUPER_GOVERNOR.getMinStaleness()) {
        revert MAX_STALENESS_TOO_LOW();
    }
    _strategyData[strategy].pps = vars.initialPPS;
    _strategyData[strategy].lastUpdateTimestamp = block.timestamp;
    _strategyData[strategy].minUpdateInterval = params.minUpdateInterval;
    _strategyData[strategy].maxStaleness = params.maxStaleness;
    _strategyData[strategy].isPaused = false;
    _strategyData[strategy].mainManager = params.mainManager;
    uint256 secondaryLen = params.secondaryManagers.length;
    for (uint256 i; i < secondaryLen; ++i) {
        _strategyData[strategy].secondaryManagers.add(params.secondaryManagers[i]);
    }
    if (_strategyData[strategy].secondaryManagers.length() > MAX_SECONDARY_MANAGERS) {
        revert TOO_MANY_SECONDARY_MANAGERS();
    }
    _strategyData[strategy].deviationThreshold = 5e17;
    emit VaultDeployed(superVault, strategy, escrow, params.asset, params.name, params.symbol, vars.currentNonce);
    emit PPSUpdated(strategy, vars.initialPPS, _strategyData[strategy].lastUpdateTimestamp);
    return (superVault, strategy, escrow);
}
```

## Related Implementations

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

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 12616:115:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
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

## External Calls

- **address::cloneDeterministic(address,bytes32)**
- **SuperVault::initialize(address,string,string,address,address)**
- **SuperVaultEscrow::initialize(address)**
- **SuperVaultStrategy::initialize(address,struct ISuperVaultStrategy.FeeConfig)**
- **address::tryGetAssetDecimals(address)**
- **ISuperGovernor::getMinStaleness()**

## State Variable Reads

- **VAULT_IMPLEMENTATION** (`address`)
- **ESCROW_IMPLEMENTATION** (`address`)
- **STRATEGY_IMPLEMENTATION** (`address`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **MAX_SECONDARY_MANAGERS** (`uint256`)

## State Variable Writes

- **_vaultCreationNonce** (`uint256`)
- **_superVaults** (`struct EnumerableSet.AddressSet`)
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)
- **_superVaultEscrows** (`struct EnumerableSet.AddressSet`)
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.createVault(struct ISuperVaultAggregator.VaultCreationParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 1)
  │   💬 Args: [_superVaults, superVault]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 2)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 3)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 4)
  │   💬 Args: [_superVaultStrategies, strategy]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 5)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 7)
  │   💬 Args: [_superVaultEscrows, escrow]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 8)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 9)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 10)
  │   💬 Args: [_strategyData[strategy].secondaryManagers, params.secondaryManagers[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 11)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 12)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  └─ [1] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 13)
      💬 Args: [_strategyData[strategy].secondaryManagers]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 14)
        💬 Args: [set._inner]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Creates a new SuperVault trio (SuperVault, SuperVaultStrategy, SuperVaultEscrow)
 @param params Parameters for the new vault creation
 @return superVault Address of the created SuperVault
 @return strategy Address of the created SuperVaultStrategy
 @return escrow Address of the created SuperVaultEscrow
