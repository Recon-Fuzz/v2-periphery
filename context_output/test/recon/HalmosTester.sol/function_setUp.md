# Function: setUp()

**Contract**: [test/recon/HalmosTester.sol/contract_HalmosTester.md]

## Metadata

- **Contract**: HalmosTester
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2532:2649:629

## Implementation

```solidity
/// === Setup === ///
///  This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
function setUp() virtual public {
    _addActor(address(0x100));
    _addActor(address(0x200));
    _newAsset(DECIMALS);
    superGovernor = new MockSuperGovernor();
    vaultImpl = new MockSuperVault();
    strategyImpl = new MockSuperVaultStrategy();
    escrowImpl = new MockSuperVaultEscrow();
    superVaultAggregator = new UnsafeSuperVaultAggregator(address(superGovernor), address(vaultImpl), address(strategyImpl), address(escrowImpl));
    ISuperVaultAggregator.VaultCreationParams memory params = ISuperVaultAggregator.VaultCreationParams({asset: _getAsset(), name: "SuperVault", symbol: "SV", mainManager: address(this), secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 100, recipient: address(this)})});
    (address vaultAddr, address strategyAddr, address escrowAddr) = superVaultAggregator.createVault(params);
    superVault = SuperVault(vaultAddr);
    superVaultStrategy = SuperVaultStrategy(payable(strategyAddr));
    superVaultEscrow = SuperVaultEscrow(escrowAddr);
    svm.enableSymbolicStorage(address(this));
    svm.enableSymbolicStorage(address(_getAsset()));
    svm.enableSymbolicStorage(address(superGovernor));
    svm.enableSymbolicStorage(address(superVaultAggregator));
    svm.enableSymbolicStorage(address(superVault));
    svm.enableSymbolicStorage(address(superVaultStrategy));
    svm.enableSymbolicStorage(address(superVaultEscrow));
}
```

## Related Implementations

### _addActor(address)

- **Kind**: internal
- **Source**: 1411:250:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_addActor(address)`

```solidity
/// @notice Adds an actor to the list of actors
function _addActor(address target) internal {
    if (_actors.contains(target)) {
        revert ActorExists();
    }
    if (target == address(this)) {
        revert DefaultActor();
    }
    _actors.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

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
- **Source**: 2214:404:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _newAsset(uint8)

- **Kind**: internal
- **Source**: 1438:328:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_newAsset(uint8)`

```solidity
/// @notice Creates a new asset and adds it to the list of assets
///  @param decimals The number of decimals for the asset
///  @return The address of the new asset
function _newAsset(uint8 decimals) internal returns (address) {
    address asset_ = address(new MockERC20("Test Token", "TST", decimals));
    _addAsset(asset_);
    __asset = asset_;
    return asset_;
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

### _getAsset()

- **Kind**: internal
- **Source**: 938:163:71
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_getAsset()`

```solidity
/// @notice Returns the current active asset
function _getAsset() internal view returns (address) {
    if (__asset == address(0)) {
        revert NotSetup();
    }
    return __asset;
}
```

## External Calls

- **UnsafeSuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SVM::enableSymbolicStorage(address)**

## State Variable Reads

- **DECIMALS** (`uint8`)
- **superGovernor** (`contract MockSuperGovernor`) [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]
- **vaultImpl** (`contract MockSuperVault`) [test/recon/mocks/MockSuperVault.sol/contract_MockSuperVault.md]
- **strategyImpl** (`contract MockSuperVaultStrategy`) [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]
- **escrowImpl** (`contract MockSuperVaultEscrow`) [test/recon/mocks/MockSuperVaultEscrow.sol/contract_MockSuperVaultEscrow.md]
- **superVaultAggregator** (`contract UnsafeSuperVaultAggregator`) [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]
- **superVault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStrategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultEscrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)
- **__asset** (`address`)

## State Variable Writes

- **superGovernor** (`contract MockSuperGovernor`) [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]
- **vaultImpl** (`contract MockSuperVault`) [test/recon/mocks/MockSuperVault.sol/contract_MockSuperVault.md]
- **strategyImpl** (`contract MockSuperVaultStrategy`) [test/recon/mocks/MockSuperVaultStrategy.sol/contract_MockSuperVaultStrategy.md]
- **escrowImpl** (`contract MockSuperVaultEscrow`) [test/recon/mocks/MockSuperVaultEscrow.sol/contract_MockSuperVaultEscrow.md]
- **superVaultAggregator** (`contract UnsafeSuperVaultAggregator`) [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]
- **superVault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStrategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultEscrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **__asset** (`address`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HalmosTester.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 1)
  │   💬 Args: [address(0x100)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 2)
  │ │   💬 Args: [_actors, target]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 3)
  │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │     👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 4)
  │     💬 Args: [_actors, target]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 5)
  │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │       👁️  Def: private
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │         💬 Args: [set, value]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 7)
  │   💬 Args: [address(0x200)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 8)
  │ │   💬 Args: [_actors, target]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 9)
  │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │     👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 10)
  │     💬 Args: [_actors, target]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 11)
  │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │       👁️  Def: private
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 12)
  │         💬 Args: [set, value]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AssetManager._newAsset(uint8) (NodeID: 13)
  │   💬 Args: [DECIMALS]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 14)
  │     💬 Args: [asset_]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 15)
  │   │   💬 Args: [_assets, target]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 16)
  │   │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │   │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 17)
  │       💬 Args: [_assets, target]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 18)
  │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 19)
  │           💬 Args: [set, value]
  │           👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 20)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 21)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

=== Setup === ///
 This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
