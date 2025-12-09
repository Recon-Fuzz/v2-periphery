# Function: help(address,address[],uint256[],uint256[],address[],bytes32,struct VmSafe.Log[])

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol/contract_DebridgeHelper.md]

## Metadata

- **Contract**: DebridgeHelper
- **Signature**: `help(address,address[],uint256[],uint256[],address[],bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 3217:829:310

## Implementation

```solidity
/// @notice helps process multiple destination messages to relay
///  @param srcGate represents the source deBridge gate
///  @param dstGates represents the destination deBridge gate
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param debridgeGateAdmins represents the admin of the debridge gate
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address srcGate, address[] memory dstGates, uint256[] memory forkIds, uint256[] memory destinationChainIds, address[] memory debridgeGateAdmins, bytes32 eventSelector, Vm.Log[] calldata logs) external {
    uint256 chains = destinationChainIds.length;
    for (uint256 i; i < chains; ) {
        _help(HelpArgs({srcGate: srcGate, dstGate: dstGates[i], forkId: forkIds[i], destinationChainId: destinationChainIds[i], eventSelector: eventSelector, logs: logs}), debridgeGateAdmins[i]);
        unchecked {
            ++i;
        }
    }
}
```

## Related Implementations

### _help(struct DebridgeHelper.HelpArgs,address)

- **Kind**: internal
- **Source**: 6273:2418:310
- **Link**: `lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol:DebridgeHelper:_help(struct DebridgeHelper.HelpArgs,address)`

```solidity
/// @notice internal function to process a single destination message to relay
///  @param args represents the help arguments
function _help(HelpArgs memory args, address debridgeGateAdmin) internal {
    LocalVars memory vars;
    vars.originChainId = uint256(block.chainid);
    vars.prevForkId = vm.activeFork();
    uint256 count = args.logs.length;
    for (uint256 i; i < count; ) {
        if ((args.logs[i].topics[0] == args.eventSelector) && (args.logs[i].emitter == args.srcGate)) {
            vm.selectFork(args.forkId);
            vars.destinationChainId = uint256(args.logs[i].topics[2]);
            if (vars.destinationChainId == args.destinationChainId) {
                DebridgeLogData memory logData = _decodeLogData(args.logs[i], args.logs[i].topics[1], vars.destinationChainId);
                vars.logData = logData;
                DeBridgeSignatureVerifierMock _verifier = new DeBridgeSignatureVerifierMock();
                vm.startPrank(debridgeGateAdmin);
                IDebridgeGate(args.dstGate).setSignatureVerifier(address(_verifier));
                vm.stopPrank();
                IDebridgeGate.DebridgeInfo memory debridgeInfo = IDebridgeGate(args.dstGate).getDebridge(logData.debridgeId);
                deal(debridgeInfo.tokenAddress, args.dstGate, logData.amount);
                address receiver = address(bytes20(logData.receiver));
                IDebridgeGate(args.dstGate).claim(logData.debridgeId, logData.amount, vars.originChainId, receiver, logData.nonce, "", logData.autoParams);
            }
        }
        unchecked {
            ++i;
        }
    }
    vm.selectFork(vars.prevForkId);
}
```

### _decodeLogData(struct VmSafe.Log,bytes32,uint256)

- **Kind**: internal
- **Source**: 8697:970:310
- **Link**: `lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol:DebridgeHelper:_decodeLogData(struct VmSafe.Log,bytes32,uint256)`

```solidity
function _decodeLogData(Vm.Log memory log, bytes32 debridgeId, uint256 chainIdTo) internal pure returns (DebridgeLogData memory data) {
    (bytes32 submissionId, uint256 amount, bytes memory receiver, uint256 nonce, uint32 referralCode, IDebridgeGate.FeeParams memory feeParams, bytes memory autoParams, address nativeSender) = abi.decode(log.data, (bytes32, uint256, bytes, uint256, uint32, IDebridgeGate.FeeParams, bytes, address));
    return DebridgeLogData({submissionId: submissionId, debridgeId: debridgeId, amount: amount, receiver: receiver, nonce: nonce, chainIdTo: chainIdTo, referralCode: referralCode, feeParams: feeParams, autoParams: autoParams, nativeSender: nativeSender});
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13254:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6743:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13416:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6905:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13721:152:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7396:179:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14942:120:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15434:1484:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11182:393:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13107:141:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4245:2492:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11581:239:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:339:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cd = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cd);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10872:304:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1847:546:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3076:534:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2556:514:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12013:376:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12451:300:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14700:92:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

## State Variable Reads

- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebridgeHelper.help(address,address[],uint256[],uint256[],address[],bytes32,struct VmSafe.Log[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DebridgeHelper._help(struct DebridgeHelper.HelpArgs,address) (NodeID: 1)
      💬 Args: [HelpArgs({srcGate: srcGate, dstGate: dstGates[i], forkId: forkIds[i], destinationChainId: destinationChainIds[i], eventSelector: eventSelector, logs: logs}), debridgeGateAdmins[i]]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: DebridgeHelper._decodeLogData(struct VmSafe.Log,bytes32,uint256) (NodeID: 2)
    │   💬 Args: [args.logs[i], args.logs[i].topics[1], vars.destinationChainId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 3)
        💬 Args: [debridgeInfo.tokenAddress, args.dstGate, logData.amount]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 4)
          💬 Args: [token, to, give, false]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 5)
        │   💬 Args: [stdstore, token]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 6)
        │     💬 Args: [self, _target]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 7)
        │   💬 Args: [stdstore.target(token), 0x70a08231]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 8)
        │     💬 Args: [self, _sig]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 9)
        │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 10)
        │     💬 Args: [self, who]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 11)
        │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 12)
        │     💬 Args: [self, bytes32(amt)]
        │     👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 13)
        │   │   💬 Args: [self]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 14)
        │   │     💬 Args: [self._keys]
        │   │     👁️  Def: private
        │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 15)
        │   │   💬 Args: [self, false]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 16)
        │   │     💬 Args: [self, _clear]
        │   │     👁️  Def: internal
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 17)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 18)
        │   │   │     💬 Args: [self._keys]
        │   │   │     👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 19)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 20)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 21)
        │   │   │ │   💬 Args: [self]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 22)
        │   │   │ │     💬 Args: [self._keys]
        │   │   │ │     👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 23)
        │   │   │     💬 Args: [rdat, 32 * self._depth]
        │   │   │     👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 24)
        │   │   │   💬 Args: [self, reads[i]]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 25)
        │   │   │ │   💬 Args: [self]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 26)
        │   │   │ │ │   💬 Args: [self]
        │   │   │ │ │   👁️  Def: internal
        │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 27)
        │   │   │ │ │     💬 Args: [self._keys]
        │   │   │ │ │     👁️  Def: private
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 28)
        │   │   │ │     💬 Args: [rdat, 32 * self._depth]
        │   │   │ │     👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 29)
        │   │   │     💬 Args: [self]
        │   │   │     👁️  Def: internal
        │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 30)
        │   │   │   │   💬 Args: [self]
        │   │   │   │   👁️  Def: internal
        │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 31)
        │   │   │   │     💬 Args: [self._keys]
        │   │   │   │     👁️  Def: private
        │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 32)
        │   │   │       💬 Args: [rdat, 32 * self._depth]
        │   │   │       👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 33)
        │   │   │   💬 Args: [self, reads[i]]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 34)
        │   │   │ │   💬 Args: [self, slot, true]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 35)
        │   │   │ │     💬 Args: [self]
        │   │   │ │     👁️  Def: internal
        │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 36)
        │   │   │ │   │   💬 Args: [self]
        │   │   │ │   │   👁️  Def: internal
        │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 37)
        │   │   │ │   │     💬 Args: [self._keys]
        │   │   │ │   │     👁️  Def: private
        │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 38)
        │   │   │ │       💬 Args: [rdat, 32 * self._depth]
        │   │   │ │       👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 39)
        │   │   │     💬 Args: [self, slot, false]
        │   │   │     👁️  Def: internal
        │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 40)
        │   │   │       💬 Args: [self]
        │   │   │       👁️  Def: internal
        │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 41)
        │   │   │     │   💬 Args: [self]
        │   │   │     │   👁️  Def: internal
        │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 42)
        │   │   │     │     💬 Args: [self._keys]
        │   │   │     │     👁️  Def: private
        │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 43)
        │   │   │         💬 Args: [rdat, 32 * self._depth]
        │   │   │         👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 44)
        │   │   │   💬 Args: [offsetLeft, offsetRight]
        │   │   │   👁️  Def: internal
        │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 45)
        │   │       💬 Args: [self]
        │   │       👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 46)
        │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 47)
        │   │     💬 Args: [offsetLeft, offsetRight]
        │   │     👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 48)
        │   │   💬 Args: [self]
        │   │   👁️  Def: internal
        │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 49)
        │   │ │   💬 Args: [self]
        │   │ │   👁️  Def: internal
        │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 50)
        │   │ │     💬 Args: [self._keys]
        │   │ │     👁️  Def: private
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 51)
        │   │     💬 Args: [rdat, 32 * self._depth]
        │   │     👁️  Def: private
        │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 52)
        │       💬 Args: [self]
        │       👁️  Def: internal
        │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 53)
        │         💬 Args: [self]
        │         👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 54)
        │   💬 Args: [stdstore, token]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 55)
        │     💬 Args: [self, _target]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 56)
        │   💬 Args: [stdstore.target(token), 0x18160ddd]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 57)
        │     💬 Args: [self, _sig]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 58)
            💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 59)
              💬 Args: [self, bytes32(amt)]
              👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 60)
            │   💬 Args: [self]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 61)
            │     💬 Args: [self._keys]
            │     👁️  Def: private
            ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 62)
            │   💬 Args: [self, false]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 63)
            │     💬 Args: [self, _clear]
            │     👁️  Def: internal
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 64)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 65)
            │   │     💬 Args: [self._keys]
            │   │     👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 66)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 67)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 68)
            │   │ │   💬 Args: [self]
            │   │ │   👁️  Def: internal
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 69)
            │   │ │     💬 Args: [self._keys]
            │   │ │     👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 70)
            │   │     💬 Args: [rdat, 32 * self._depth]
            │   │     👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 71)
            │   │   💬 Args: [self, reads[i]]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 72)
            │   │ │   💬 Args: [self]
            │   │ │   👁️  Def: internal
            │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 73)
            │   │ │ │   💬 Args: [self]
            │   │ │ │   👁️  Def: internal
            │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 74)
            │   │ │ │     💬 Args: [self._keys]
            │   │ │ │     👁️  Def: private
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 75)
            │   │ │     💬 Args: [rdat, 32 * self._depth]
            │   │ │     👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 76)
            │   │     💬 Args: [self]
            │   │     👁️  Def: internal
            │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 77)
            │   │   │   💬 Args: [self]
            │   │   │   👁️  Def: internal
            │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 78)
            │   │   │     💬 Args: [self._keys]
            │   │   │     👁️  Def: private
            │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 79)
            │   │       💬 Args: [rdat, 32 * self._depth]
            │   │       👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 80)
            │   │   💬 Args: [self, reads[i]]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 81)
            │   │ │   💬 Args: [self, slot, true]
            │   │ │   👁️  Def: internal
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 82)
            │   │ │     💬 Args: [self]
            │   │ │     👁️  Def: internal
            │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 83)
            │   │ │   │   💬 Args: [self]
            │   │ │   │   👁️  Def: internal
            │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 84)
            │   │ │   │     💬 Args: [self._keys]
            │   │ │   │     👁️  Def: private
            │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 85)
            │   │ │       💬 Args: [rdat, 32 * self._depth]
            │   │ │       👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 86)
            │   │     💬 Args: [self, slot, false]
            │   │     👁️  Def: internal
            │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 87)
            │   │       💬 Args: [self]
            │   │       👁️  Def: internal
            │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 88)
            │   │     │   💬 Args: [self]
            │   │     │   👁️  Def: internal
            │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 89)
            │   │     │     💬 Args: [self._keys]
            │   │     │     👁️  Def: private
            │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 90)
            │   │         💬 Args: [rdat, 32 * self._depth]
            │   │         👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 91)
            │   │   💬 Args: [offsetLeft, offsetRight]
            │   │   👁️  Def: internal
            │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 92)
            │       💬 Args: [self]
            │       👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 93)
            │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 94)
            │     💬 Args: [offsetLeft, offsetRight]
            │     👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 95)
            │   💬 Args: [self]
            │   👁️  Def: internal
            │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 96)
            │ │   💬 Args: [self]
            │ │   👁️  Def: internal
            │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 97)
            │ │     💬 Args: [self._keys]
            │ │     👁️  Def: private
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 98)
            │     💬 Args: [rdat, 32 * self._depth]
            │     👁️  Def: private
            └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 99)
                💬 Args: [self]
                👁️  Def: internal
              └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 100)
                  💬 Args: [self]
                  👁️  Def: internal
```

## Documentation

### Function Documentation

@notice helps process multiple destination messages to relay
 @param srcGate represents the source deBridge gate
 @param dstGates represents the destination deBridge gate
 @param forkIds represents the destination chain fork ids
 @param destinationChainIds represents the destination chain ids
 @param debridgeGateAdmins represents the admin of the debridge gate
 @param eventSelector represents a custom event selector
 @param logs represents the recorded message logs
