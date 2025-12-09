# Function: switchActor(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 757:96:648
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Start acting as another actor
///  @dev Update ghosts here to make global property checks not fail falsely
function switchActor(uint256 entropy) public updateGhosts() {
    _switchActor(entropy);
}
```

## Related Implementations

### _switchActor(uint256)

- **Kind**: internal
- **Source**: 2547:143:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_switchActor(uint256)`

```solidity
/// @dev Expose this in the `TargetFunctions` contract to let the fuzzer switch actors
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @dev This may reduce fuzzing performance if using multiple actors, if so add explicitly clamped handlers to ManagersTargets using the index of all added actors
///  @notice Switches the current actor based on the entropy
///  @param entropy The entropy to choose a random actor in the array for switching
///  @return target The new active actor
function _switchActor(uint256 entropy) internal returns (address target) {
    target = _actors.at(entropy);
    _actor = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### updateGhosts()

- **Kind**: modifier
- **Source**: 1229:118:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:updateGhosts()`

```solidity
modifier updateGhosts() {
    _currentOp = OpType.DEFAULT;
    __before();
    _;
    __after();
}
```

### __before()

- **Kind**: internal
- **Source**: 1484:781:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__before()`

```solidity
function __before() internal {
    _before.naivePPS = _calculateNaivePPS();
    _before.summedTotalShares = _sumTotalShares();
    _before.summedTotalAssets = _sumStrategyAssets();
    _before.summedPendingRedeem = _sumRequestedRedemptions();
    _before.pendingUserAssets[_getActor()] = _getPendingAsAssets();
    _before.claimableUserAssets[_getActor()] = _getClaimableAsAssets();
    _before.state[_getActor()] = superVaultStrategy.getSuperVaultState(_getActor());
    _before.superVaultShares[_getActor()] = superVault.balanceOf(_getActor());
    _before.strategyAssetBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _before.oraclePPS = superVaultAggregator.getPPS(address(superVaultStrategy));
}
```

### _calculateNaivePPS()

- **Kind**: internal
- **Source**: 3812:638:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_calculateNaivePPS()`

```solidity
/// @notice Calculates the naive price per share by summing all assets across strategy and yield sources
///  @dev inspired by the share price calculation from BaseSuperVaultTest::_updateSuperVaultPPS
///  @return naivePPS The calculated price per share (scaled by 1e18)
function _calculateNaivePPS() internal view returns (uint256 naivePPS) {
    uint256 totalSupply = superVault.totalSupply();
    if (totalSupply == 0) {
        return 0;
    }
    uint256 totalAssets = _sumStrategyAssets();
    naivePPS = (totalAssets * superVault.PRECISION()) / totalSupply;
    return naivePPS;
}
```

### _sumStrategyAssets()

- **Kind**: internal
- **Source**: 4456:764:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumStrategyAssets()`

```solidity
function _sumStrategyAssets() public view returns (uint256) {
    address asset = superVault.asset();
    uint256 totalAssets;
    totalAssets += IERC20(asset).balanceOf(address(superVaultStrategy));
    address[] memory yieldSources = _getYieldSources();
    for (uint256 i = 0; i < yieldSources.length; i++) {
        if (yieldSources[i] != address(0)) {
            totalAssets += IERC20(asset).balanceOf(yieldSources[i]);
        }
    }
    return totalAssets;
}
```

### _getYieldSources()

- **Kind**: internal
- **Source**: 1799:115:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSources()`

```solidity
/// @notice Returns all yield sources being used
function _getYieldSources() internal view returns (address[] memory) {
    return _yieldSources.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

### _sumTotalShares()

- **Kind**: internal
- **Source**: 3160:365:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumTotalShares()`

```solidity
/// @dev total shares in the system is the sum of shares in the escrow and held by all users
function _sumTotalShares() internal view returns (uint256) {
    address[] memory actors = _getActors();
    uint256 totalShares;
    totalShares += superVault.balanceOf(address(superVaultEscrow));
    for (uint256 i; i < actors.length; i++) {
        totalShares += superVault.balanceOf(actors[i]);
    }
    return totalShares;
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### _sumRequestedRedemptions()

- **Kind**: internal
- **Source**: 5226:324:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_sumRequestedRedemptions()`

```solidity
function _sumRequestedRedemptions() internal view returns (uint256) {
    address[] memory actors = _getActors();
    uint256 totalRequested;
    for (uint256 i; i < actors.length; i++) {
        totalRequested += superVault.pendingRedeemRequest(0, actors[i]);
    }
    return totalRequested;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

### _getPendingAsAssets()

- **Kind**: internal
- **Source**: 5556:293:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_getPendingAsAssets()`

```solidity
function _getPendingAsAssets() internal view returns (uint256) {
    uint256 pendingRedemptions = superVault.pendingRedeemRequest(0, _getActor());
    uint256 pendingRedemptionsAsAssets = superVault.convertToAssets(pendingRedemptions);
    return pendingRedemptionsAsAssets;
}
```

### _getClaimableAsAssets()

- **Kind**: internal
- **Source**: 5855:305:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:_getClaimableAsAssets()`

```solidity
function _getClaimableAsAssets() internal view returns (uint256) {
    uint256 claimableRedemptions = superVault.claimableRedeemRequest(0, _getActor());
    uint256 claimableRedemptionsAsAssets = superVault.convertToAssets(claimableRedemptions);
    return claimableRedemptionsAsAssets;
}
```

### __after()

- **Kind**: internal
- **Source**: 2271:770:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__after()`

```solidity
function __after() internal {
    _after.naivePPS = _calculateNaivePPS();
    _after.summedTotalShares = _sumTotalShares();
    _after.summedTotalAssets = _sumStrategyAssets();
    _after.summedPendingRedeem = _sumRequestedRedemptions();
    _after.pendingUserAssets[_getActor()] = _getPendingAsAssets();
    _after.claimableUserAssets[_getActor()] = _getClaimableAsAssets();
    _after.state[_getActor()] = superVaultStrategy.getSuperVaultState(_getActor());
    _after.superVaultShares[_getActor()] = superVault.balanceOf(_getActor());
    _after.strategyAssetBalance = MockERC20(superVault.asset()).balanceOf(address(superVaultStrategy));
    _after.oraclePPS = superVaultAggregator.getPPS(address(superVaultStrategy));
}
```

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## State Variable Writes

- **_actor** (`address`)
- **_currentOp** (`enum OpType`)
- **_before** (`struct BeforeAfter.Vars`)
- **_after** (`struct BeforeAfter.Vars`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 1)
  │   💬 Args: [entropy]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 2)
  │     💬 Args: [_actors, entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 3)
  │       💬 Args: [set._inner, index]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhosts() (NodeID: 4)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 5)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 6)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 7)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 8)
    │ │       💬 Args: [no args]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 9)
    │ │         💬 Args: [_yieldSources]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 10)
    │ │           💬 Args: [set._inner]
    │ │           👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 11)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 12)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 13)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 14)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 15)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 16)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 17)
    │ │       💬 Args: [_yieldSources]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 18)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 19)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 20)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 21)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 22)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 23)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 24)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 25)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 26)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 27)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 28)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 29)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 30)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 31)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 32)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 33)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 34)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 35)
      │     💬 Args: [no args]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 36)
      │       💬 Args: [no args]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 37)
      │         💬 Args: [_yieldSources]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 38)
      │           💬 Args: [set._inner]
      │           👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 39)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 40)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 41)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 42)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 43)
      │   💬 Args: [no args]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 44)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 45)
      │       💬 Args: [_yieldSources]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 46)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 47)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 48)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 49)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 50)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 51)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 52)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 53)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 54)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 55)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 56)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 57)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 58)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 59)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 60)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Start acting as another actor
 @dev Update ghosts here to make global property checks not fail falsely
