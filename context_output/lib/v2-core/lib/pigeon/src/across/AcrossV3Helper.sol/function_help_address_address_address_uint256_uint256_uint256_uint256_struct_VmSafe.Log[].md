# Function: help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[])

**Contract**: [lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol/contract_AcrossV3Helper.md]

## Metadata

- **Contract**: AcrossV3Helper
- **Signature**: `help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 2957:701:306

## Implementation

```solidity
/// @notice helps process a single destination message to relay
///  @param sourceSpokePool represents the across spoke pool on the source chain
///  @param destinationSpokePool represents the across spoke pool on the destination chain
///  @param relayer represents the relayer address
///  @param warpTimestamp represents the warp timestamp
///  @param forkId represents the destination chain fork id
///  @param refundChainId represents the refund chain id
///  @param logs represents the recorded message logs
function help(address sourceSpokePool, address destinationSpokePool, address relayer, uint256 warpTimestamp, uint256 forkId, uint256 destinationChainId, uint256 refundChainId, Vm.Log[] calldata logs) external {
    _help(HelpArgs({sourceSpokePool: sourceSpokePool, destinationSpokePool: destinationSpokePool, relayer: relayer, forkId: forkId, destinationChainId: destinationChainId, refundChainId: refundChainId, warpTimestamp: warpTimestamp, logs: logs}));
}
```

## Related Implementations

### _help(struct AcrossV3Helper.HelpArgs)

- **Kind**: internal
- **Source**: 5843:2711:306
- **Link**: `lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol:AcrossV3Helper:_help(struct AcrossV3Helper.HelpArgs)`

```solidity
/// @notice internal function to process a single destination message to relay
///  @param args represents the help arguments
function _help(HelpArgs memory args) internal {
    LocalVars memory vars;
    vars.originChainId = uint256(block.chainid);
    vars.prevForkId = vm.activeFork();
    vm.selectFork(args.forkId);
    if (args.warpTimestamp > 0) {
        vm.warp(args.warpTimestamp);
    }
    vm.startBroadcast(args.relayer);
    for (uint256 i; i < args.logs.length; i++) {
        if (((args.logs[i].topics[0] == FundsDeposited) || (args.logs[i].topics[0] == V3FundsDeposited)) && (args.logs[i].emitter == args.sourceSpokePool)) {
            vars.destinationChainId = uint256(args.logs[i].topics[1]);
            if (vars.destinationChainId == args.destinationChainId) {
                vars.logData = _decodeLogData(args.logs[i]);
                assertEq(vars.destinationChainId, args.destinationChainId);
                deal(vars.logData.outputToken, args.relayer, vars.logData.outputAmount);
                IERC20(vars.logData.outputToken).approve(args.destinationSpokePool, vars.logData.outputAmount);
                IAcrossSpokePoolV3(args.destinationSpokePool).fillV3Relay(IAcrossSpokePoolV3.V3RelayData({depositor: address(uint160(uint256(args.logs[i].topics[2]))), recipient: vars.logData.recipient, exclusiveRelayer: vars.logData.exclusiveRelayer, inputToken: vars.logData.inputToken, outputToken: vars.logData.outputToken, inputAmount: vars.logData.inputAmount, outputAmount: vars.logData.outputAmount, originChainId: vars.originChainId, depositId: uint32(uint256(args.logs[i].topics[1])), fillDeadline: vars.logData.fillDeadline, exclusivityDeadline: vars.logData.exclusivityDeadline, message: vars.logData.message}), args.refundChainId);
            }
        }
    }
    vm.stopBroadcast();
    vm.selectFork(vars.prevForkId);
}
```

### _decodeLogData(struct VmSafe.Log)

- **Kind**: internal
- **Source**: 11492:1021:306
- **Link**: `lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol:AcrossV3Helper:_decodeLogData(struct VmSafe.Log)`

```solidity
function _decodeLogData(Vm.Log memory log) internal pure returns (AcrossV3LogData memory data) {
    (address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint32 quoteTimestamp, uint32 fillDeadline, uint32 exclusivityDeadline, address recipient, address exclusiveRelayer, bytes memory message) = abi.decode(log.data, (address, address, uint256, uint256, uint32, uint32, uint32, address, address, bytes));
    return AcrossV3LogData({inputToken: inputToken, outputToken: outputToken, inputAmount: inputAmount, outputAmount: outputAmount, quoteTimestamp: quoteTimestamp, fillDeadline: fillDeadline, exclusivityDeadline: exclusivityDeadline, recipient: recipient, exclusiveRelayer: exclusiveRelayer, message: message});
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
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

- **FundsDeposited** (`bytes32`)
- **V3FundsDeposited** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AcrossV3Helper.help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AcrossV3Helper._help(struct AcrossV3Helper.HelpArgs) (NodeID: 1)
      💬 Args: [HelpArgs({sourceSpokePool: sourceSpokePool, destinationSpokePool: destinationSpokePool, relayer: relayer, forkId: forkId, destinationChainId: destinationChainId, refundChainId: refundChainId, warpTimestamp: warpTimestamp, logs: logs})]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AcrossV3Helper._decodeLogData(struct VmSafe.Log) (NodeID: 2)
    │   💬 Args: [args.logs[i]]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
    │   💬 Args: [vars.destinationChainId, args.destinationChainId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 4)
        💬 Args: [vars.logData.outputToken, args.relayer, vars.logData.outputAmount]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 5)
          💬 Args: [token, to, give, false]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 6)
        │   💬 Args: [stdstore, token]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 7)
        │     💬 Args: [self, _target]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 8)
        │   💬 Args: [stdstore.target(token), 0x70a08231]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 9)
        │     💬 Args: [self, _sig]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 10)
        │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 11)
        │     💬 Args: [self, who]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 12)
        │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 13)
        │     💬 Args: [self, bytes32(amt)]
        │     👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 14)
        │   │   💬 Args: [self]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 15)
        │   │     💬 Args: [self._keys]
        │   │     👁️  Def: private
        │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 16)
        │   │   💬 Args: [self, false]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 17)
        │   │     💬 Args: [self, _clear]
        │   │     👁️  Def: internal
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 18)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 19)
        │   │   │     💬 Args: [self._keys]
        │   │   │     👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 20)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 21)
        │   │   │   💬 Args: [self]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 22)
        │   │   │ │   💬 Args: [self]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 23)
        │   │   │ │     💬 Args: [self._keys]
        │   │   │ │     👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 24)
        │   │   │     💬 Args: [rdat, 32 * self._depth]
        │   │   │     👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 25)
        │   │   │   💬 Args: [self, reads[i]]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 26)
        │   │   │ │   💬 Args: [self]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 27)
        │   │   │ │ │   💬 Args: [self]
        │   │   │ │ │   👁️  Def: internal
        │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 28)
        │   │   │ │ │     💬 Args: [self._keys]
        │   │   │ │ │     👁️  Def: private
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 29)
        │   │   │ │     💬 Args: [rdat, 32 * self._depth]
        │   │   │ │     👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 30)
        │   │   │     💬 Args: [self]
        │   │   │     👁️  Def: internal
        │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 31)
        │   │   │   │   💬 Args: [self]
        │   │   │   │   👁️  Def: internal
        │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 32)
        │   │   │   │     💬 Args: [self._keys]
        │   │   │   │     👁️  Def: private
        │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 33)
        │   │   │       💬 Args: [rdat, 32 * self._depth]
        │   │   │       👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 34)
        │   │   │   💬 Args: [self, reads[i]]
        │   │   │   👁️  Def: internal
        │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 35)
        │   │   │ │   💬 Args: [self, slot, true]
        │   │   │ │   👁️  Def: internal
        │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 36)
        │   │   │ │     💬 Args: [self]
        │   │   │ │     👁️  Def: internal
        │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 37)
        │   │   │ │   │   💬 Args: [self]
        │   │   │ │   │   👁️  Def: internal
        │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 38)
        │   │   │ │   │     💬 Args: [self._keys]
        │   │   │ │   │     👁️  Def: private
        │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 39)
        │   │   │ │       💬 Args: [rdat, 32 * self._depth]
        │   │   │ │       👁️  Def: private
        │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 40)
        │   │   │     💬 Args: [self, slot, false]
        │   │   │     👁️  Def: internal
        │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 41)
        │   │   │       💬 Args: [self]
        │   │   │       👁️  Def: internal
        │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 42)
        │   │   │     │   💬 Args: [self]
        │   │   │     │   👁️  Def: internal
        │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 43)
        │   │   │     │     💬 Args: [self._keys]
        │   │   │     │     👁️  Def: private
        │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 44)
        │   │   │         💬 Args: [rdat, 32 * self._depth]
        │   │   │         👁️  Def: private
        │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 45)
        │   │   │   💬 Args: [offsetLeft, offsetRight]
        │   │   │   👁️  Def: internal
        │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 46)
        │   │       💬 Args: [self]
        │   │       👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 47)
        │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
        │   │   👁️  Def: internal
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 48)
        │   │     💬 Args: [offsetLeft, offsetRight]
        │   │     👁️  Def: internal
        │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 49)
        │   │   💬 Args: [self]
        │   │   👁️  Def: internal
        │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 50)
        │   │ │   💬 Args: [self]
        │   │ │   👁️  Def: internal
        │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 51)
        │   │ │     💬 Args: [self._keys]
        │   │ │     👁️  Def: private
        │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 52)
        │   │     💬 Args: [rdat, 32 * self._depth]
        │   │     👁️  Def: private
        │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 53)
        │       💬 Args: [self]
        │       👁️  Def: internal
        │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 54)
        │         💬 Args: [self]
        │         👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 55)
        │   💬 Args: [stdstore, token]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 56)
        │     💬 Args: [self, _target]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 57)
        │   💬 Args: [stdstore.target(token), 0x18160ddd]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 58)
        │     💬 Args: [self, _sig]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 59)
            💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 60)
              💬 Args: [self, bytes32(amt)]
              👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 61)
            │   💬 Args: [self]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 62)
            │     💬 Args: [self._keys]
            │     👁️  Def: private
            ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 63)
            │   💬 Args: [self, false]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 64)
            │     💬 Args: [self, _clear]
            │     👁️  Def: internal
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 65)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 66)
            │   │     💬 Args: [self._keys]
            │   │     👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 67)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 68)
            │   │   💬 Args: [self]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 69)
            │   │ │   💬 Args: [self]
            │   │ │   👁️  Def: internal
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 70)
            │   │ │     💬 Args: [self._keys]
            │   │ │     👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 71)
            │   │     💬 Args: [rdat, 32 * self._depth]
            │   │     👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 72)
            │   │   💬 Args: [self, reads[i]]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 73)
            │   │ │   💬 Args: [self]
            │   │ │   👁️  Def: internal
            │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 74)
            │   │ │ │   💬 Args: [self]
            │   │ │ │   👁️  Def: internal
            │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 75)
            │   │ │ │     💬 Args: [self._keys]
            │   │ │ │     👁️  Def: private
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 76)
            │   │ │     💬 Args: [rdat, 32 * self._depth]
            │   │ │     👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 77)
            │   │     💬 Args: [self]
            │   │     👁️  Def: internal
            │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 78)
            │   │   │   💬 Args: [self]
            │   │   │   👁️  Def: internal
            │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 79)
            │   │   │     💬 Args: [self._keys]
            │   │   │     👁️  Def: private
            │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 80)
            │   │       💬 Args: [rdat, 32 * self._depth]
            │   │       👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 81)
            │   │   💬 Args: [self, reads[i]]
            │   │   👁️  Def: internal
            │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 82)
            │   │ │   💬 Args: [self, slot, true]
            │   │ │   👁️  Def: internal
            │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 83)
            │   │ │     💬 Args: [self]
            │   │ │     👁️  Def: internal
            │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 84)
            │   │ │   │   💬 Args: [self]
            │   │ │   │   👁️  Def: internal
            │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 85)
            │   │ │   │     💬 Args: [self._keys]
            │   │ │   │     👁️  Def: private
            │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 86)
            │   │ │       💬 Args: [rdat, 32 * self._depth]
            │   │ │       👁️  Def: private
            │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 87)
            │   │     💬 Args: [self, slot, false]
            │   │     👁️  Def: internal
            │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 88)
            │   │       💬 Args: [self]
            │   │       👁️  Def: internal
            │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 89)
            │   │     │   💬 Args: [self]
            │   │     │   👁️  Def: internal
            │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 90)
            │   │     │     💬 Args: [self._keys]
            │   │     │     👁️  Def: private
            │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 91)
            │   │         💬 Args: [rdat, 32 * self._depth]
            │   │         👁️  Def: private
            │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 92)
            │   │   💬 Args: [offsetLeft, offsetRight]
            │   │   👁️  Def: internal
            │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 93)
            │       💬 Args: [self]
            │       👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 94)
            │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
            │   👁️  Def: internal
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 95)
            │     💬 Args: [offsetLeft, offsetRight]
            │     👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 96)
            │   💬 Args: [self]
            │   👁️  Def: internal
            │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 97)
            │ │   💬 Args: [self]
            │ │   👁️  Def: internal
            │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 98)
            │ │     💬 Args: [self._keys]
            │ │     👁️  Def: private
            │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 99)
            │     💬 Args: [rdat, 32 * self._depth]
            │     👁️  Def: private
            └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 100)
                💬 Args: [self]
                👁️  Def: internal
              └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 101)
                  💬 Args: [self]
                  👁️  Def: internal
```

## Documentation

### Function Documentation

@notice helps process a single destination message to relay
 @param sourceSpokePool represents the across spoke pool on the source chain
 @param destinationSpokePool represents the across spoke pool on the destination chain
 @param relayer represents the relayer address
 @param warpTimestamp represents the warp timestamp
 @param forkId represents the destination chain fork id
 @param refundChainId represents the refund chain id
 @param logs represents the recorded message logs
