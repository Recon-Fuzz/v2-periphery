# Function: asset_mint(address,uint128)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 2253:133:648
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin() {
    MockERC20(superVault.asset()).mint(to, amt);
}
```

## Related Implementations

### asAdmin()

- **Kind**: modifier
- **Source**: 5816:70:631
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
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

## External Calls

- **MockERC20::mint(address,uint256)**
- **SuperVault::asset()**

## State Variable Reads

- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## State Variable Writes

- **_currentOp** (`enum OpType`)
- **_before** (`struct BeforeAfter.Vars`)
- **_after** (`struct BeforeAfter.Vars`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.asset_mint(address,uint128) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
  │   💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhosts() (NodeID: 2)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 4)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 5)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 6)
    │ │       💬 Args: [no args]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 7)
    │ │         💬 Args: [_yieldSources]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 8)
    │ │           💬 Args: [set._inner]
    │ │           👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 9)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 10)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 11)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 12)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 13)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 14)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 15)
    │ │       💬 Args: [_yieldSources]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 16)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 17)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 18)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 19)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 20)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 21)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 22)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 23)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 24)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 25)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 26)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 27)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 28)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 29)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 30)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 31)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 32)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 33)
      │     💬 Args: [no args]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 34)
      │       💬 Args: [no args]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 35)
      │         💬 Args: [_yieldSources]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 36)
      │           💬 Args: [set._inner]
      │           👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 37)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 38)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 39)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 40)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 41)
      │   💬 Args: [no args]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 42)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 43)
      │       💬 Args: [_yieldSources]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 44)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 45)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 46)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 47)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 48)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 49)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 50)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 51)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 52)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 53)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 54)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 55)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 56)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 57)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 58)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
