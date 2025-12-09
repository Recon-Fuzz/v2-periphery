# Function: superVault_transfer(uint256,uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superVault_transfer(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4993:548:654
- **Inherited From**: SuperVaultTargets

## Implementation

```solidity
/// @dev Propery: _update should never revert
function superVault_transfer(uint256 entropy, uint256 value) public updateGhostsWithOpType(OpType.TRANSFER) {
    address to = _getRandomActor(entropy);
    vm.prank(_getActor());
    try superVault.transfer(to, value) {} catch (bytes memory err) {
        bool expectedError;
        expectedError = checkError(err, "ERC20InsufficientBalance(address,uint256,uint256)");
        t(expectedError, "_update should never revert in transfer");
    }
}
```

## Related Implementations

### _getRandomActor(uint256)

- **Kind**: internal
- **Source**: 17946:176:631
- **Link**: `test/recon/Setup.sol:Setup:_getRandomActor(uint256)`

```solidity
function _getRandomActor(uint256 entropy) public view returns (address) {
    address[] memory actors = _getActors();
    return actors[entropy % actors.length];
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

### checkError(bytes,string)

- **Kind**: internal
- **Source**: 383:765:75
- **Link**: `lib/setup-helpers/src/Utils.sol:Utils:checkError(bytes,string)`

```solidity
/// @dev check if the error returned from a call is the same as the expected error
///  @param err the error returned from a call
///  @param expected the expected error
///  @return true if the error is the same as the expected error, false otherwise
function checkError(bytes memory err, string memory expected) internal pure returns (bool) {
    (string memory revertMsg, bool customError) = _getRevertMsg(err);
    bytes32 errorBytes;
    bytes32 expectedBytes;
    if (customError) {
        errorBytes = bytes32(abi.encodePacked(revertMsg, bytes28(0)));
        expectedBytes = bytes4(keccak256(abi.encodePacked(expected)));
    } else {
        errorBytes = keccak256(abi.encodePacked(revertMsg));
        expectedBytes = keccak256(abi.encodePacked(expected));
    }
    return errorBytes == expectedBytes;
}
```

### _getRevertMsg(bytes)

- **Kind**: internal
- **Source**: 1407:1376:75
- **Link**: `lib/setup-helpers/src/Utils.sol:Utils:_getRevertMsg(bytes)`

```solidity
/// @dev get the revert message from a call
///  @notice based on https://ethereum.stackexchange.com/a/83577
///  @param returnData the return data from a call
///  @return the revert message and a boolean indicating if it's a custom error
function _getRevertMsg(bytes memory returnData) internal pure returns (string memory, bool) {
    if (returnData.length == 0) return ("", false);
    if (returnData.length == (4 + 32)) {
        bool panic = _checkIfPanic(returnData);
        if (panic) {
            return _getPanicCode(returnData);
        }
    }
    bytes4 errorSelector = _getErrorSelector(returnData);
    bytes4 errorStringSelector = bytes4(keccak256("Error(string)"));
    if (errorSelector == errorStringSelector) {
        assembly {
            returnData := add(returnData, 0x04)
        }
        return (abi.decode(returnData, (string)), false);
    }
    return (string(abi.encodePacked(errorSelector)), true);
}
```

### _checkIfPanic(bytes)

- **Kind**: internal
- **Source**: 2789:333:75
- **Link**: `lib/setup-helpers/src/Utils.sol:Utils:_checkIfPanic(bytes)`

```solidity
function _checkIfPanic(bytes memory returnData) internal pure returns (bool) {
    bytes4 panicSignature = bytes4(keccak256(bytes("Panic(uint256)")));
    for (uint256 i = 0; i < 4; i++) {
        if (returnData[i] != panicSignature[i]) {
            return false;
        }
    }
    return true;
}
```

### _getPanicCode(bytes)

- **Kind**: internal
- **Source**: 3128:1732:75
- **Link**: `lib/setup-helpers/src/Utils.sol:Utils:_getPanicCode(bytes)`

```solidity
function _getPanicCode(bytes memory returnData) internal pure returns (string memory, bool) {
    uint256 panicCode;
    for (uint256 i = 4; i < 36; i++) {
        panicCode = panicCode << 8;
        panicCode |= uint8(returnData[i]);
    }
    if (panicCode == 1) {
        return (Panic.assertionPanic, false);
    } else if (panicCode == 17) {
        return (Panic.arithmeticPanic, false);
    } else if (panicCode == 18) {
        return (Panic.divisionPanic, false);
    } else if (panicCode == 33) {
        return (Panic.enumPanic, false);
    } else if (panicCode == 34) {
        return (Panic.arrayPanic, false);
    } else if (panicCode == 49) {
        return (Panic.emptyArrayPanic, false);
    } else if (panicCode == 50) {
        return (Panic.outOfBoundsPanic, false);
    } else if (panicCode == 65) {
        return (Panic.memoryPanic, false);
    } else if (panicCode == 81) {
        return (Panic.functionPanic, false);
    }
    return ("Undefined panic code", false);
}
```

### _getErrorSelector(bytes)

- **Kind**: internal
- **Source**: 4866:221:75
- **Link**: `lib/setup-helpers/src/Utils.sol:Utils:_getErrorSelector(bytes)`

```solidity
function _getErrorSelector(bytes memory returnData) internal pure returns (bytes4 errorSelector) {
    assembly {
        errorSelector := mload(add(returnData, 0x20))
    }
    return errorSelector;
}
```

### t(bool,string)

- **Kind**: internal
- **Source**: 822:105:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    assertTrue(b, reason);
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
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

- **Vm::prank(address)**
- **SuperVault::transfer(address,uint256)**

## Native Transfers

- **superVault** (computed)

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_currentOp** (`enum OpType`)
- **_before** (`struct BeforeAfter.Vars`)
- **_after** (`struct BeforeAfter.Vars`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTargets.superVault_transfer(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Setup._getRandomActor(uint256) (NodeID: 1)
  │   💬 Args: [entropy]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 3)
  │       💬 Args: [_actors]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 4)
  │         💬 Args: [set._inner]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Utils.checkError(bytes,string) (NodeID: 6)
  │   💬 Args: [err, "ERC20InsufficientBalance(address,uint256,uint256)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Utils._getRevertMsg(bytes) (NodeID: 7)
  │     💬 Args: [err]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Utils._checkIfPanic(bytes) (NodeID: 8)
  │   │   💬 Args: [returnData]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Utils._getPanicCode(bytes) (NodeID: 9)
  │   │   💬 Args: [returnData]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Utils._getErrorSelector(bytes) (NodeID: 10)
  │       💬 Args: [returnData]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 11)
  │   💬 Args: [expectedError, "_update should never revert in transfer"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 12)
  │     💬 Args: [b, reason]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhostsWithOpType(enum OpType) (NodeID: 13)
      💬 Args: [OpType.TRANSFER]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 14)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 15)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 16)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 17)
    │ │       💬 Args: [no args]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 18)
    │ │         💬 Args: [_yieldSources]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 19)
    │ │           💬 Args: [set._inner]
    │ │           👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 20)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 21)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 22)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 23)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 24)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 25)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 26)
    │ │       💬 Args: [_yieldSources]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 27)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 28)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 29)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 30)
    │ │       💬 Args: [_actors]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 31)
    │ │         💬 Args: [set._inner]
    │ │         👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 32)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 33)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 34)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 35)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 36)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 37)
    │ │     💬 Args: [no args]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 38)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 39)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 40)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 41)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 42)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._calculateNaivePPS() (NodeID: 43)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 44)
      │     💬 Args: [no args]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 45)
      │       💬 Args: [no args]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 46)
      │         💬 Args: [_yieldSources]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 47)
      │           💬 Args: [set._inner]
      │           👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumTotalShares() (NodeID: 48)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 49)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 50)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 51)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumStrategyAssets() (NodeID: 52)
      │   💬 Args: [no args]
      │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 53)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 54)
      │       💬 Args: [_yieldSources]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 55)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._sumRequestedRedemptions() (NodeID: 56)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 57)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 58)
      │       💬 Args: [_actors]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 59)
      │         💬 Args: [set._inner]
      │         👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 60)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getPendingAsAssets() (NodeID: 61)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 62)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 63)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BeforeAfter._getClaimableAsAssets() (NodeID: 64)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 65)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 66)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 67)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 68)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 69)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Propery: _update should never revert
