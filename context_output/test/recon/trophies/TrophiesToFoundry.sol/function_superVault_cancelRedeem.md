# Function: superVault_cancelRedeem()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superVault_cancelRedeem()`
- **Visibility**: public
- **Source Range**: 1288:1624:654
- **Inherited From**: SuperVaultTargets

## Implementation

```solidity
/// @dev Property: pendingRedeemRequest should be 0 after a user calls cancelRedeem
///  @dev Property: averageRequestPPS should be 0 after a user calls cancelRedeem
///  @dev Property: user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem
function superVault_cancelRedeem() public updateGhostsWithOpType(OpType.CANCEL) {
    uint256 pendingRedeemRequestsBefore = superVault.pendingRedeemRequest(0, _getActor());
    uint256 pendingRedeemRequestsAsAssets = superVault.convertToAssets(pendingRedeemRequestsBefore);
    uint256 balanceBefore = MockERC20(superVault.asset()).balanceOf(_getActor());
    vm.prank(_getActor());
    superVault.cancelRedeemRequest(0, _getActor());
    address[] memory controllers = new address[](1);
    controllers[0] = _getActor();
    superVaultStrategy.fulfillCancelRedeemRequests(controllers);
    uint256 pendingRedeemRequestsAfter = superVault.pendingRedeemRequest(0, _getActor());
    uint256 averageRequestPPS = superVaultStrategy.getSuperVaultState(_getActor()).averageRequestPPS;
    uint256 balanceAfter = MockERC20(superVault.asset()).balanceOf(_getActor());
    eq(pendingRedeemRequestsAfter, 0, "pendingRedeemRequests should be 0 after cancelling a redemption");
    eq(averageRequestPPS, 0, "averageRequestPPS should be 0 after cancelling a redemption");
    lte(balanceAfter - balanceBefore, pendingRedeemRequestsAsAssets, "user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem");
}
```

## Related Implementations

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

### eq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 695:121:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertEq(a, b, reason);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### lte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 567:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:lte(uint256,uint256,string)`

```solidity
function lte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertLe(a, b, reason);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 16150:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left > right) {
        vm.assertLe(left, right, err);
    }
}
```

### updateGhostsWithOpType(enum OpType)

- **Kind**: modifier
- **Source**: 1353:125:626
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:updateGhostsWithOpType(enum OpType)`

```solidity
modifier updateGhostsWithOpType(OpType op) {
    _currentOp = op;
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

- **SuperVault::pendingRedeemRequest(uint256,address)**
- **SuperVault::convertToAssets(uint256)**
- **MockERC20::balanceOf(address)**
- **SuperVault::asset()**
- **Vm::prank(address)**
- **SuperVault::cancelRedeemRequest(uint256,address)**
- **SuperVaultStrategy::fulfillCancelRedeemRequests(address[])**
- **SuperVaultStrategy::getSuperVaultState(address)**

## State Variable Reads

- **_actor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **_actors** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_currentOp** (`enum OpType`)
- **_before** (`struct BeforeAfter.Vars`)
- **_after** (`struct BeforeAfter.Vars`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTargets.superVault_cancelRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.eq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [pendingRedeemRequestsAfter, 0, "pendingRedeemRequests should be 0 after cancelling a redemption"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.eq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [averageRequestPPS, 0, "averageRequestPPS should be 0 after cancelling a redemption"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.lte(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [balanceAfter - balanceBefore, pendingRedeemRequestsAsAssets, "user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 14)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhostsWithOpType(enum OpType) (NodeID: 15)
      💬 Args: [OpType.CANCEL]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 16)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 17)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 18)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 19)
    │ │       💬 Args: [no args]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 20)
    │ │         💬 Args: [_yieldSources]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 21)
    │ │           💬 Args: [set._inner]
    │ │           👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 22)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 23)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 24)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 25)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 26)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 27)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 28)
    │ │       💬 Args: [_yieldSources]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 29)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 30)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 31)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 32)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 33)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 34)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 35)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 36)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 37)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 38)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 39)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 40)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 41)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 42)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 43)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 44)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 45)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 46)
      │     💬 Args: [no args]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 47)
      │       💬 Args: [no args]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 48)
      │         💬 Args: [_yieldSources]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 49)
      │           💬 Args: [set._inner]
      │           👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 50)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 51)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 52)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 53)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 54)
      │   💬 Args: [no args]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 55)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 56)
      │       💬 Args: [_yieldSources]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 57)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 58)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 59)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 60)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 61)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 62)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 63)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 64)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 65)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 66)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 67)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 68)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 69)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 70)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 71)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: pendingRedeemRequest should be 0 after a user calls cancelRedeem
 @dev Property: averageRequestPPS should be 0 after a user calls cancelRedeem
 @dev Property: user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem
