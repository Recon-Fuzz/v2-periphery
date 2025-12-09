# Function: doomsday_primaryManagerAlwaysChangeable()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `doomsday_primaryManagerAlwaysChangeable()`
- **Visibility**: public
- **Source Range**: 12910:758:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Property: primary manager can always be replaced by governance via `changePrimaryManager`
function doomsday_primaryManagerAlwaysChangeable() public {
    address strategy = address(superVaultStrategy);
    address newManager = _getActor();
    _switchActor(1);
    address feeRecipient = _getActor();
    vm.prank(address(this));
    try superGovernor.changePrimaryManager(strategy, newManager, feeRecipient) {} catch (bytes memory err) {
        bool expectedError;
        expectedError = checkError(err, "MANAGER_TAKEOVERS_FROZEN()");
        t(!expectedError, "Primary manager should always be changeable if not paused");
    }
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
- **Source**: 1096:159:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    if (!b) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **_actor** (`address`)
- **_actors** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.doomsday_primaryManagerAlwaysChangeable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 2)
  │   💬 Args: [1]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 3)
  │     💬 Args: [_actors, entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 4)
  │       💬 Args: [set._inner, index]
  │       👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Utils.checkError(bytes,string) (NodeID: 6)
  │   💬 Args: [err, "MANAGER_TAKEOVERS_FROZEN()"]
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
  └─ [1] ⚙️ FUNCTION: CryticAsserts.t(bool,string) (NodeID: 11)
      💬 Args: [!expectedError, "Primary manager should always be changeable if not paused"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: primary manager can always be replaced by governance via `changePrimaryManager`
