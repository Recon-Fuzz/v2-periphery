# Function: test_LongTermHolder_vs_ActiveTrader()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_LongTermHolder_vs_ActiveTrader()`
- **Visibility**: public
- **Source Range**: 27743:1373:580

## Implementation

```solidity
///  @notice Test simulating different user personas: Long-term holder vs Active trader
///  @dev This test demonstrates how different user behaviors interact with the SuperVault system
function test_LongTermHolder_vs_ActiveTrader() public {
    UserPersona memory holder;
    UserPersona memory trader;
    holder.account = accInstances[0].account;
    trader.account = accInstances[1].account;
    holder.depositAmount = 10_000e6;
    trader.depositAmount = 2000e6;
    console2.log("=== SETTING UP USER PERSONAS ===");
    console2.log("Long-term holder:", holder.account);
    console2.log("Active trader:", trader.account);
    _getTokens(address(asset), holder.account, holder.depositAmount);
    _getTokens(address(asset), trader.account, trader.depositAmount * 5);
    holder.initialBalance = asset.balanceOf(holder.account);
    trader.initialBalance = asset.balanceOf(trader.account);
    console2.log("Holder initial balance:", holder.initialBalance);
    console2.log("Trader initial balance:", trader.initialBalance);
    _executeInitialDeposits(holder, trader);
    _executeActiveTradingPeriod(trader);
    _executeLongTermHolding(holder);
    _executeFinalRedemptions(holder, trader);
    console2.log("=== TEST COMPLETED SUCCESSFULLY ===");
}
```

## Related Implementations

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### _getTokens(address,address,uint256)

- **Kind**: internal
- **Source**: 3137:118:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_getTokens(address,address,uint256)`

```solidity
function _getTokens(address token_, address to_, uint256 amount_) internal {
    deal(token_, to_, amount_);
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _executeInitialDeposits(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)

- **Kind**: internal
- **Source**: 426247:893:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_executeInitialDeposits(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)`

```solidity
/// @notice Execute initial deposits phase
function _executeInitialDeposits(UserPersona memory holder, UserPersona memory trader) internal {
    console2.log("\n=== PHASE 1: INITIAL DEPOSITS ===");
    _depositForAccount(accInstances[0], holder.depositAmount);
    holder.shares = vault.balanceOf(holder.account);
    console2.log("Holder deposited and received shares:", holder.shares);
    _depositForAccount(accInstances[1], trader.depositAmount);
    trader.shares = vault.balanceOf(trader.account);
    console2.log("Trader deposited and received shares:", trader.shares);
    uint256 totalDeposited = holder.depositAmount + trader.depositAmount;
    _depositFreeAssetsFromSingleAmount(totalDeposited, address(fluidVault), address(aaveVault));
}
```

### _depositForAccount(struct AccountInstance,uint256)

- **Kind**: internal
- **Source**: 33451:142:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositForAccount(struct AccountInstance,uint256)`

```solidity
function _depositForAccount(AccountInstance memory accInst, uint256 depositAmount) internal {
    __deposit(accInst, depositAmount);
}
```

### __deposit(struct AccountInstance,uint256)

- **Kind**: internal
- **Source**: 23833:884:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__deposit(struct AccountInstance,uint256)`

```solidity
function __deposit(AccountInstance memory accInst, uint256 depositAmount) internal {
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0);
    ISuperExecutor.ExecutorEntry memory entry = ISuperExecutor.ExecutorEntry({hooksAddresses: hooksAddresses, hooksData: hooksData});
    UserOpData memory userOpData = _getExecOps(accInst, superExecutorOnEth, abi.encode(entry));
    executeOp(userOpData);
}
```

### _getHookAddress(uint64,string)

- **Kind**: internal
- **Source**: 21123:153:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getHookAddress(uint64,string)`

```solidity
function _getHookAddress(uint64 chainId, string memory hookName) internal view returns (address) {
    return hookAddresses[chainId][hookName];
}
```

### _createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)

- **Kind**: internal
- **Source**: 12335:449:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)`

```solidity
function _createApproveAndDeposit4626HookData(bytes32 yieldSourceOracleId, address vault, address token, uint256 amount, bool usePrevHookAmount, address vaultBank, uint256 dstChainId) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, token, amount, usePrevHookAmount, vaultBank, dstChainId);
}
```

### _getYieldSourceOracleId(bytes32,address)

- **Kind**: internal
- **Source**: 4752:156:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getYieldSourceOracleId(bytes32,address)`

```solidity
function _getYieldSourceOracleId(bytes32 id, address sender) internal pure returns (bytes32) {
    return keccak256(abi.encodePacked(id, sender));
}
```

### _getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)

- **Kind**: internal
- **Source**: 3424:376:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)`

```solidity
function _getExecOps(AccountInstance memory instance, ISuperExecutor superExecutor, bytes memory data) internal returns (UserOpData memory userOpData) {
    return instance.getExecOps(address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator));
}
```

### getExecOps(struct AccountInstance,address,uint256,bytes,address)

- **Kind**: internal
- **Source**: 4143:577:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getExecOps(struct AccountInstance,address,uint256,bytes,address)`

```solidity
/// @notice Configures a userOp to execute a single operation
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param target The address of the contract to call
///  @param value The amount of ether to send
///  @param callData The data to send to the contract
///  @param txValidator The address of the transaction validator
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function getExecOps(AccountInstance memory instance, address target, uint256 value, bytes memory callData, address txValidator) internal returns (UserOpData memory userOpData) {
    bytes memory erc7579ExecCall = HelperBase(instance.accountHelper).encode(target, value, callData);
    (userOpData.userOp, userOpData.userOpHash) = HelperBase(instance.accountHelper).execUserOp(instance, erc7579ExecCall, txValidator);
    userOpData.entrypoint = instance.aux.entrypoint;
}
```

### executeOp(struct UserOpData)

- **Kind**: internal
- **Source**: 2902:141:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:executeOp(struct UserOpData)`

```solidity
function executeOp(UserOpData memory userOpData) public returns (ExecutionReturnData memory) {
    return userOpData.execUserOps();
}
```

### execUserOps(struct UserOpData)

- **Kind**: internal
- **Source**: 3413:243:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:execUserOps(struct UserOpData)`

```solidity
/// @notice Executes userOps on the entrypoint
///  @param userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
///  @return ExecutionReturnData struct containing the logs from the execution
function execUserOps(UserOpData memory userOpData) internal returns (ExecutionReturnData memory) {
    return ERC4337Helpers.exec4337(userOpData.userOp, userOpData.entrypoint);
}
```

### exec4337(struct PackedUserOperation,contract IEntryPoint)

- **Kind**: internal
- **Source**: 5908:333:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation,contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation memory userOp, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory logs) {
    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
    userOps[0] = userOp;
    return exec4337(userOps, onEntryPoint);
}
```

### exec4337(struct PackedUserOperation[],contract IEntryPoint)

- **Kind**: internal
- **Source**: 1486:4373:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation[],contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory executionData) {
    ExecutionContext memory ctx = ExecutionContext({isExpectRevert: getExpectRevert(), beneficiary: payable(address(0x69)), userOpCalldata: "", success: false, returnData: ""});
    if (envOr("SIMULATE", false) || getSimulateUserOp()) {
        bool simulationSuccess = userOps[0].simulateUserOp(address(onEntryPoint));
        if (ctx.isExpectRevert == 0) {
            require(simulationSuccess, "UserOperation simulation failed");
        }
    }
    recordLogs();
    ctx.userOpCalldata = abi.encodeCall(IEntryPoint.handleOps, (userOps, ctx.beneficiary));
    (ctx.success, ctx.returnData) = address(onEntryPoint).call(ctx.userOpCalldata);
    if (ctx.isExpectRevert == 0) {
        require(ctx.success, "UserOperation execution failed");
    } else if ((ctx.isExpectRevert == 2) && (!ctx.success)) {
        checkRevertMessage(ctx.returnData);
    }
    VmSafe.Log[] memory logs = getRecordedLogs();
    executionData = ExecutionReturnData(logs);
    uint256 totalUserOpGas = 0;
    for (uint256 i; i < logs.length; i++) {
        if (logs[i].topics[0] == 0x49628fd1471006c1482da88028e9ce4dbb080b815c9b0344d39e5a8e6ec1419f) {
            (uint256 nonce, bool userOpSuccess, , uint256 actualGasUsed) = abi.decode(logs[i].data, (uint256, bool, uint256, uint256));
            totalUserOpGas = actualGasUsed;
            if (!userOpSuccess) {
                bytes32 userOpHash = logs[i].topics[1];
                if (ctx.isExpectRevert == 0) {
                    bytes memory revertReason = getUserOpRevertReason(logs, userOpHash);
                    address account = address(bytes20(logs[i].topics[2]));
                    revert UserOperationReverted(userOpHash, account, getLabel(account), nonce, revertReason);
                } else {
                    if (ctx.isExpectRevert == 2) {
                        checkRevertMessage(getUserOpRevertReason(logs, userOpHash));
                    }
                    clearExpectRevert();
                }
            }
        } else if (logs[i].topics[0] == 0xd21d0b289f126c4b473ea641963e766833c2f13866e4ff480abd787c100ef123) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            writeInstalledModule(InstalledModule(moduleType, module), logs[i].emitter);
        } else if (logs[i].topics[0] == 0x341347516a9de374859dfda710fa4828b2d48cb57d4fbe4c1149612b8e02276e) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            InstalledModule[] memory installedModules = getInstalledModules(logs[i].emitter);
            for (uint256 j; j < installedModules.length; j++) {
                if ((installedModules[j].moduleAddress == module) && (installedModules[j].moduleType == moduleType)) {
                    removeInstalledModule(j, logs[i].emitter);
                    break;
                }
            }
        }
    }
    string memory gasIdentifier = getGasIdentifier();
    if ((envOr("GAS", false) && (bytes(gasIdentifier).length > 0)) && (bytes(gasIdentifier).length < 50)) {
        calculateGas(userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas);
    }
    for (uint256 i; i < userOps.length; i++) {
        emit ModuleKitLogs.ModuleKit_Exec4337(userOps[i].sender);
    }
}
```

### getExpectRevert()

- **Kind**: free-function
- **Source**: 588:163:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevert()`

```solidity
function getExpectRevert() view returns (uint256 value) {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        value := sload(slot)
    }
}
```

### getSimulateUserOp()

- **Kind**: free-function
- **Source**: 1949:166:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getSimulateUserOp()`

```solidity
function getSimulateUserOp() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.SimulateUserOp");
    assembly {
        value := sload(slot)
    }
}
```

### envOr(string,bool)

- **Kind**: internal
- **Source**: 4355:148:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,bool)`

```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### simulateUserOp(struct PackedUserOperation,address)

- **Kind**: internal
- **Source**: 1279:1591:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:simulateUserOp(struct PackedUserOperation,address)`

```solidity
///  Simulates a UserOperation and validates the ERC-4337 rules
///  @dev This function will revert if the UserOperation is invalid
///  @dev If the simulation fails, the rules might not be checked correctly so simulationSuccess
///  should be handled accordingly
///  @dev This function is used for v0.7 ERC-4337
///  @param userOp The PackedUserOperation to simulate
///  @param onEntryPoint The address of the entry point to simulate the UserOperation on
///  @return simulationSuccess True if the simulation was successful, false otherwise
function simulateUserOp(PackedUserOperation memory userOp, address onEntryPoint) internal returns (bool simulationSuccess) {
    _preSimulation();
    bytes memory epCallData = abi.encodeCall(IEntryPointSimulations.simulateValidation, (userOp));
    bytes memory returnData;
    (simulationSuccess, returnData) = address(onEntryPoint).call(epCallData);
    if (!simulationSuccess) {
        return simulationSuccess;
    }
    IEntryPointSimulations.ValidationResult memory result = abi.decode(returnData, (IEntryPointSimulations.ValidationResult));
    if (result.returnInfo.accountValidationData != 0) {
        bool sigFailed = (result.returnInfo.accountValidationData & 1) == 1;
        if (sigFailed) {
            simulationSuccess = false;
        }
    }
    UserOperationDetails memory userOpDetails = UserOperationDetails({entryPoint: onEntryPoint, sender: userOp.sender, initCode: userOp.initCode, paymasterAndData: userOp.paymasterAndData});
    _postSimulation(userOpDetails);
}
```

### _preSimulation()

- **Kind**: internal
- **Source**: 4794:514:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_preSimulation()`

```solidity
///  Pre-simulation setup
function _preSimulation() internal {
    uint256 snapShotId = snapshotState();
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        sstore(snapShotSlot, snapShotId)
    }
    startMappingRecording();
    startDebugTraceRecording();
}
```

### snapshotState()

- **Kind**: free-function
- **Source**: 394:86:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:snapshotState()`

```solidity
function snapshotState() returns (uint256) {
    return Vm(VM_ADDR).snapshotState();
}
```

### startMappingRecording()

- **Kind**: free-function
- **Source**: 579:77:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startMappingRecording()`

```solidity
function startMappingRecording() {
    Vm(VM_ADDR).startMappingRecording();
}
```

### startDebugTraceRecording()

- **Kind**: free-function
- **Source**: 961:83:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startDebugTraceRecording()`

```solidity
function startDebugTraceRecording() {
    Vm(VM_ADDR).startDebugTraceRecording();
}
```

### _postSimulation(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 5436:688:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_postSimulation(struct UserOperationDetails)`

```solidity
///  Post-simulation validation
///  @param userOpDetails The UserOperationDetails to validate
function _postSimulation(UserOperationDetails memory userOpDetails) internal {
    VmSafe.DebugStep[] memory debugTrace = stopAndReturnDebugTraceRecording();
    ERC4337SpecsParser.parseValidation(userOpDetails, debugTrace);
    stopMappingRecording();
    uint256 snapShotId;
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        snapShotId := sload(snapShotSlot)
    }
    revertToState(snapShotId);
}
```

### stopAndReturnDebugTraceRecording()

- **Kind**: free-function
- **Source**: 1046:148:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopAndReturnDebugTraceRecording()`

```solidity
function stopAndReturnDebugTraceRecording() returns (VmSafe.DebugStep[] memory steps) {
    return Vm(VM_ADDR).stopAndReturnDebugTraceRecording();
}
```

### parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 1656:1779:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])`

```solidity
///  Parses and validates the ERC-4337 rules
///  @param userOpDetails The UserOperationDetails to validate
///  @param debugTrace A trace of used opcodes, stack and memory to validate
function parseValidation(UserOperationDetails memory userOpDetails, VmSafe.DebugStep[] memory debugTrace) internal {
    Entities memory entities = getEntities(userOpDetails);
    (VmSafe.DebugStep[] memory filteredUserOpSteps, VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps) = filterDebugTrace(debugTrace, entities, userOpDetails.entryPoint);
    validateBannedOpcodes(filteredUserOpSteps, entities);
    validateBannedOpcodes(filteredPaymasterUserOpSteps, entities);
    validateOutOfGas(filteredUserOpSteps);
    validateOutOfGas(filteredPaymasterUserOpSteps);
    validateBannedStorageLocations(filteredUserOpSteps, entities, userOpDetails);
    validateBannedStorageLocations(filteredPaymasterUserOpSteps, entities, userOpDetails);
    validateCalls(filteredUserOpSteps, entities, userOpDetails.entryPoint);
    validateCalls(filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint);
    validateExtOpcodes(filteredUserOpSteps, entities);
    validateExtOpcodes(filteredPaymasterUserOpSteps, entities);
    validateCreate(filteredUserOpSteps, entities, userOpDetails);
    validateCreate(filteredPaymasterUserOpSteps, entities, userOpDetails);
}
```

### getEntities(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 25300:1252:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getEntities(struct UserOperationDetails)`

```solidity
///  Returns the entities of the UserOperation
///  @param userOpDetails The UserOperationDetails to get the entities of
///  @return entities The entities of the UserOperation
function getEntities(UserOperationDetails memory userOpDetails) internal view returns (Entities memory entities) {
    address factory;
    if (userOpDetails.initCode.length > 20) {
        bytes memory initCode = userOpDetails.initCode;
        assembly {
            factory := mload(add(initCode, 20))
        }
    }
    address paymaster;
    if (userOpDetails.paymasterAndData.length > 20) {
        bytes memory paymasterAndData = userOpDetails.paymasterAndData;
        assembly {
            paymaster := mload(add(paymasterAndData, 20))
        }
    }
    address aggregator;
    entities = Entities({account: userOpDetails.sender, factory: factory, isFactoryStaked: isStaked(factory, userOpDetails.entryPoint), paymaster: paymaster, isPaymasterStaked: isStaked(paymaster, userOpDetails.entryPoint), aggregator: aggregator, isAggregatorStaked: isStaked(aggregator, userOpDetails.entryPoint)});
}
```

### isStaked(address,address)

- **Kind**: internal
- **Source**: 28211:470:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isStaked(address,address)`

```solidity
///  Returns whether the entity is staked
///  @param entity The entity to check
///  @return isEntityStaked Whether the entity is staked
function isStaked(address entity, address entryPoint) internal view returns (bool isEntityStaked) {
    IStakeManager.DepositInfo memory deposit = IStakeManager(entryPoint).getDepositInfo(entity);
    isEntityStaked = (deposit.stake >= MIN_STAKE_VALUE) && (deposit.unstakeDelaySec >= MIN_UNSTAKE_DELAY);
}
```

### filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 6062:2998:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Filter debug trace, we are interested in the following debug traces:
///  - Entrypoint -> validateUserOp
///  - Entrypoint - validatePaymasterUserOp
///  @param debugTrace The debug trace to filter
///  @param entities The entities of the userOp
///  @param entryPoint The entryPoint address
///  @return filteredUserOpSteps The filtered debug steps
///  @return filteredPaymasterUserOpSteps The filtered debug steps
function filterDebugTrace(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, address entryPoint) private pure returns (VmSafe.DebugStep[] memory, VmSafe.DebugStep[] memory) {
    VmSafe.DebugStep[] memory filteredUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    uint256 filteredUserOpStepsLength;
    uint256 filteredPaymasterUserOpStepsLength;
    uint256 startDepth = 0;
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].contractAddr == entryPoint) {
            startDepth = debugTrace[i].depth;
            break;
        }
    }
    address currentContractAddr;
    for (uint256 i = 0; i < debugTrace.length; i++) {
        if ((debugTrace[i].depth == startDepth) && (debugTrace[i].contractAddr == entryPoint)) {
            if ((debugTrace[i].opcode == 0xF1) || (debugTrace[i].opcode == 0xFA)) {
                currentContractAddr = address(uint160(uint256(debugTrace[i].stack[1])));
            }
            continue;
        }
        if (debugTrace[i].depth > startDepth) {
            if (currentContractAddr == entities.account) {
                filteredUserOpSteps[filteredUserOpStepsLength++] = debugTrace[i];
            } else if (currentContractAddr == entities.paymaster) {
                filteredPaymasterUserOpSteps[filteredPaymasterUserOpStepsLength++] = debugTrace[i];
            }
        }
    }
    assembly {
        mstore(filteredUserOpSteps, filteredUserOpStepsLength)
        mstore(filteredPaymasterUserOpSteps, filteredPaymasterUserOpStepsLength)
    }
    return (filteredUserOpSteps, filteredPaymasterUserOpSteps);
}
```

### validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 3559:2043:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates that no banned opcodes are used
///  @param debugTrace The debug trace to validate
function validateBannedOpcodes(VmSafe.DebugStep[] memory debugTrace, Entities memory entities) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (isForbiddenOpcode(debugTrace[i].opcode)) {
            if (debugTrace[i].opcode == 0x5A) {
                if (((i + 1) >= debugTrace.length) || ((((debugTrace[i + 1].opcode != 0xF1) && (debugTrace[i + 1].opcode != 0xF4)) && (debugTrace[i + 1].opcode != 0xF2)) && (debugTrace[i + 1].opcode != 0xFA))) {
                    revert InvalidOpcode(debugTrace[i].contractAddr, 0x5A);
                }
            } else if (((debugTrace[i].opcode == 0x31) || (debugTrace[i].opcode == 0x47)) && isEntityAndStaked(entities, debugTrace[i].contractAddr)) {
                continue;
            } else {
                revert InvalidOpcode(debugTrace[i].contractAddr, debugTrace[i].opcode);
            }
        }
    }
}
```

### isForbiddenOpcode(uint8)

- **Kind**: internal
- **Source**: 29220:729:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isForbiddenOpcode(uint8)`

```solidity
///  Checks if the opcode is a forbidden opcode
///  @param opcode The opcode to check
///  @return isForbidden Whether the opcode is forbidden
function isForbiddenOpcode(uint8 opcode) private pure returns (bool isForbidden) {
    return ((((((((((((((opcode == 0x3A) || (opcode == 0x45)) || (opcode == 0x44)) || (opcode == 0x42)) || (opcode == 0x48)) || (opcode == 0x40)) || (opcode == 0x43)) || (opcode == 0x47)) || (opcode == 0x31)) || (opcode == 0x32)) || (opcode == 0x5A)) || (opcode == 0xF0)) || (opcode == 0x41)) || (opcode == 0xFE)) || (opcode == 0xFF);
}
```

### isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 26835:634:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns whether something is an entity and is staked
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
///  @return addressIsEntityAndStaked Whether the address is an entity and is staked
function isEntityAndStaked(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntityAndStaked) {
    if (toCheck == entities.account) {
        addressIsEntityAndStaked = true;
    } else if (toCheck == entities.factory) {
        addressIsEntityAndStaked = entities.isFactoryStaked;
    } else if (toCheck == entities.paymaster) {
        addressIsEntityAndStaked = entities.isPaymasterStaked;
    } else if (toCheck == entities.aggregator) {
        addressIsEntityAndStaked = entities.isAggregatorStaked;
    }
}
```

### validateOutOfGas(struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 9203:345:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateOutOfGas(struct VmSafe.DebugStep[])`

```solidity
///  Validate that the simulation does not revert with Out of Gas
///  @param debugTrace The debug trace to validate
function validateOutOfGas(VmSafe.DebugStep[] memory debugTrace) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].isOutOfGas) {
            revert("[OP-020] Simulation reverts with Out of Gas");
        }
    }
}
```

### validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 9851:4230:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates that no banned storage locations are accessed
///  @param debugTrace The debug trace to validate
///  @param entities  The entities of the userOp
///  @param userOpDetails The UserOperationDetails to validate
function validateBannedStorageLocations(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, UserOperationDetails memory userOpDetails) internal {
    for (uint256 i; i < debugTrace.length; i++) {
        VmSafe.DebugStep memory currentStep = debugTrace[i];
        if ((((currentStep.opcode != 0x54) && (currentStep.opcode != 0x55)) && (currentStep.opcode != 0x5C)) && (currentStep.opcode != 0x5D)) {
            continue;
        }
        address currentAccessAccount = currentStep.contractAddr;
        bytes32 currentSlot = bytes32(uint256(currentStep.stack[0]));
        bool notEntity = !isEntity(entities, currentAccessAccount);
        if (currentAccessAccount == entities.account) {
            continue;
        }
        /// Access to associated storage of the account in an external (non-entity) contract
        bool accountAlreadyExists = (entities.account.code.length != 0) || ((currentAccessAccount == userOpDetails.entryPoint) && (entities.account != address(0)));
        bool isFactoryStaked = entities.isFactoryStaked;
        if ((notEntity && isAssociatedStorage(currentSlot, currentAccessAccount, entities.account)) && (accountAlreadyExists || isFactoryStaked)) {
            continue;
        }
        if (entities.isFactoryStaked || entities.isPaymasterStaked) {
            if (((currentAccessAccount == entities.factory) && entities.isFactoryStaked) || ((currentAccessAccount == entities.paymaster) && entities.isPaymasterStaked)) {
                continue;
            } else if (notEntity && ((isAssociatedStorage(currentSlot, currentAccessAccount, entities.factory) && entities.isFactoryStaked) || (isAssociatedStorage(currentSlot, currentAccessAccount, entities.paymaster) && entities.isPaymasterStaked))) {
                continue;
            } else if (notEntity && ((currentStep.opcode == 0x54) || (currentStep.opcode == 0x5C))) {
                continue;
            }
        }
        bool isWrite = (currentStep.opcode == 0x55) || (currentStep.opcode == 0x5D);
        revert InvalidStorageLocation(currentAccessAccount, getLabel(currentAccessAccount), currentSlot, isWrite ? bytes32(uint256(currentStep.stack[1])) : bytes32(0), isWrite);
    }
}
```

### isEntity(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 27643:388:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntity(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns wether something is an entity
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
function isEntity(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntity) {
    if ((((toCheck == entities.account) || (toCheck == entities.factory)) || (toCheck == entities.paymaster)) || (toCheck == entities.aggregator)) {
        addressIsEntity = true;
    }
}
```

### isAssociatedStorage(bytes32,address,address)

- **Kind**: internal
- **Source**: 20836:774:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isAssociatedStorage(bytes32,address,address)`

```solidity
///  Returns whether the current storage slot matches a specific entity
///  @param currentSlot The current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param entity The entity to check
///  @return isAssociated Whether the current storage slot matches a specific entity
function isAssociatedStorage(bytes32 currentSlot, address currentAccessAccount, address entity) internal returns (bool isAssociated) {
    if (slotMatchesEntity(currentSlot, entity)) {
        isAssociated = true;
    } else {
        (bool found, bytes32 key) = getMappingParent(currentAccessAccount, currentSlot);
        if (found) {
            if (slotMatchesEntity(key, entity)) {
                isAssociated = true;
            }
        }
    }
}
```

### slotMatchesEntity(bytes32,address)

- **Kind**: internal
- **Source**: 23408:355:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:slotMatchesEntity(bytes32,address)`

```solidity
///  Returns whether the current storage slot matches an entity
///  @param slot The current storage slot
///  @param entity The entity to check
///  @return _ Whether the current storage slot matches an entity
function slotMatchesEntity(bytes32 slot, address entity) internal pure returns (bool) {
    if (slot == bytes32(0)) {
        return false;
    }
    return slot == bytes32(uint256(uint160(entity)));
}
```

### getMappingParent(address,bytes32)

- **Kind**: internal
- **Source**: 24067:1014:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getMappingParent(address,bytes32)`

```solidity
///  Returns the parent of the current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param currentSlot The current storage slot
///  @return found Whether the parent was found
///  @return key The parent slot
function getMappingParent(address currentAccessAccount, bytes32 currentSlot) internal returns (bool found, bytes32 key) {
    (bool _found, bytes32 _key, ) = getMappingKeyAndParentOf(currentAccessAccount, currentSlot);
    if (_found) {
        found = _found;
        key = _key;
    } else {
        for (uint256 k = 1; (k <= 128) && (k <= uint256(currentSlot)); k++) {
            (_found, _key, ) = getMappingKeyAndParentOf(currentAccessAccount, bytes32(uint256(currentSlot) - k));
            if (_found) {
                found = _found;
                key = _key;
                break;
            }
        }
    }
}
```

### getMappingKeyAndParentOf(address,bytes32)

- **Kind**: free-function
- **Source**: 735:163:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getMappingKeyAndParentOf(address,bytes32)`

```solidity
function getMappingKeyAndParentOf(address target, bytes32 slot) returns (bool, bytes32, bytes32) {
    return Vm(VM_ADDR).getMappingKeyAndParentOf(target, slot);
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 289:103:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 14362:2479:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Validates *CALL operations in the trace (CALL, DELEGATECALL, CALLCODE, STATICCALL)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param entryPoint The EntryPoint contract address
function validateCalls(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, address entryPoint) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if ((((op != 0xF1) && (op != 0xF2)) && (op != 0xF4)) && (op != 0xFA)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[1])));
        uint256 value = ((op == 0xF1) || (op == 0xF2)) ? uint256(debugSteps[i].stack[2]) : 0;
        bytes memory callData = debugSteps[i].memoryInput;
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] Cannot *CALL addresses without code");
        }
        bool callerIsAccount = debugSteps[i].contractAddr == entities.account;
        bool callerIsFactory = debugSteps[i].contractAddr == entities.factory;
        bool calleeIsEntryPoint = targetAddr == entryPoint;
        if (value > 0) {
            if (!((callerIsAccount || callerIsFactory) && calleeIsEntryPoint)) {
                revert("[OP-061] Cannot use value except from account or factory to EntryPoint");
            }
        }
        if (calleeIsEntryPoint) {
            bytes4 selector;
            if (callData.length >= 4) {
                selector = bytes4(abi.encodePacked(callData[0], callData[1], callData[2], callData[3]));
            }
            if (!(((callerIsAccount || callerIsFactory) && (selector == bytes4(0xb760faf9))) || (callerIsAccount && (callData.length == 0)))) {
                revert("[OP-052] Cannot call EntryPoint except depositTo from factory or account");
            }
        }
    }
}
```

### isPrecompile(address)

- **Kind**: internal
- **Source**: 28874:160:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isPrecompile(address)`

```solidity
///  Returns whether the address is a precompile
///  @param target The address to check
///  @return isPrecompile Whether the address is a precompile
function isPrecompile(address target) internal pure returns (bool) {
    return (uint256(uint160(target)) <= 0x09) || (uint256(uint160(target)) == 0x100);
}
```

### validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 17061:862:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates EXT* operations in the trace (EXTCODESIZE, EXTCODEHASH, EXTCODECOPY)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
function validateExtOpcodes(VmSafe.DebugStep[] memory debugSteps, Entities memory entities) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if (((op != 0x3B) && (op != 0x3C)) && (op != 0x3F)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[0])));
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] EXT* opcodes cannot access addresses without code");
        }
    }
}
```

### validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 18178:1122:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates CREATE operations in the trace
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param userOpDetails The UserOperationDetails containing initCode
function validateCreate(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, UserOperationDetails memory userOpDetails) internal pure {
    uint256 createCount = 0;
    for (uint256 i = 0; i < debugSteps.length; i++) {
        if (debugSteps[i].opcode == 0xF5) {
            createCount++;
            if (userOpDetails.initCode.length == 0) {
                revert("[OP-031] CREATE2 not allowed without initCode");
            }
            if (createCount > 1) {
                revert("[OP-031] Multiple CREATE2 operations not allowed");
            }
            address createdAddr = address(uint160(uint256(debugSteps[i].stack[0])));
            if (createdAddr != entities.account) {
                revert("[OP-031] CREATE2 must deploy the account contract");
            }
        }
    }
}
```

### stopMappingRecording()

- **Kind**: free-function
- **Source**: 658:75:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopMappingRecording()`

```solidity
function stopMappingRecording() {
    Vm(VM_ADDR).stopMappingRecording();
}
```

### revertToState(uint256)

- **Kind**: free-function
- **Source**: 482:95:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:revertToState(uint256)`

```solidity
function revertToState(uint256 id) returns (bool) {
    return Vm(VM_ADDR).revertToState(id);
}
```

### recordLogs()

- **Kind**: free-function
- **Source**: 1458:55:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:recordLogs()`

```solidity
function recordLogs() {
    Vm(VM_ADDR).recordLogs();
}
```

### checkRevertMessage(bytes)

- **Kind**: internal
- **Source**: 6800:719:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:checkRevertMessage(bytes)`

```solidity
function checkRevertMessage(bytes memory actualReason) internal view {
    bytes memory revertMessage = getExpectRevertMessage();
    if (actualReason.length >= 4) {
        bytes4 actual = bytes4(actualReason);
        bytes4 expected = bytes4(revertMessage);
        if (actual == bytes4(0x65c8fd4d)) {
            return parseFailedOpWithRevert(actualReason, revertMessage);
        } else if (actual != expected) {
            revert InvalidRevertMessageBytes(revertMessage, actualReason);
        }
        return;
    }
    if (revertMessage.length != actualReason.length) {
        revert InvalidRevertMessageBytes(revertMessage, actualReason);
    }
}
```

### getExpectRevertMessage()

- **Kind**: free-function
- **Source**: 753:180:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevertMessage()`

```solidity
function getExpectRevertMessage() view returns (bytes memory data) {
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        data := sload(slot)
    }
}
```

### parseFailedOpWithRevert(bytes,bytes)

- **Kind**: internal
- **Source**: 7525:1258:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:parseFailedOpWithRevert(bytes,bytes)`

```solidity
function parseFailedOpWithRevert(bytes memory actualReason, bytes memory revertMessage) internal pure {
    uint256 bytesOffset;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, 0x40)
        bytesOffset := mload(ptr)
    }
    bytes memory actual;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, bytesOffset)
        let innerLength := mload(ptr)
        actual := mload(0x40)
        mstore(actual, innerLength)
        let srcPtr := add(ptr, 0x20)
        let destPtr := add(actual, 0x20)
        mstore(destPtr, mload(srcPtr))
        mstore(0x40, add(add(actual, 0x20), innerLength))
    }
    if (revertMessage.length == 4) {
        bytes4 expected = bytes4(revertMessage);
        if (expected != bytes4(actual)) {
            revert InvalidRevertMessage(expected, bytes4(actual));
        }
    } else {
        if (keccak256(actual) != keccak256(revertMessage)) {
            revert InvalidRevertMessageBytes(revertMessage, actual);
        }
    }
}
```

### getRecordedLogs()

- **Kind**: free-function
- **Source**: 1515:102:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getRecordedLogs()`

```solidity
function getRecordedLogs() returns (VmSafe.Log[] memory) {
    return Vm(VM_ADDR).getRecordedLogs();
}
```

### getUserOpRevertReason(struct VmSafe.Log[],bytes32)

- **Kind**: internal
- **Source**: 6247:547:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:getUserOpRevertReason(struct VmSafe.Log[],bytes32)`

```solidity
function getUserOpRevertReason(VmSafe.Log[] memory logs, bytes32 userOpHash) internal pure returns (bytes memory revertReason) {
    for (uint256 i; i < logs.length; i++) {
        if ((logs[i].topics[0] == 0x1c4fada7374c0a9ee8841fc38afe82932dc0f8e69012e927f061a8bae611a201) && (logs[i].topics[1] == userOpHash)) {
            (, revertReason) = abi.decode(logs[i].data, (uint256, bytes));
        }
    }
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 1066:103:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### clearExpectRevert()

- **Kind**: free-function
- **Source**: 935:230:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:clearExpectRevert()`

```solidity
function clearExpectRevert() {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, 0)
    }
    slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        sstore(slot, 0)
    }
}
```

### writeInstalledModule(struct InstalledModule,address)

- **Kind**: free-function
- **Source**: 6700:1960:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeInstalledModule(struct InstalledModule,address)`

```solidity
// Failed to render writeInstalledModule(struct InstalledModule,address) implementation (FunctionDefinition#96186). Check logs for details.
```

### getInstalledModules(address)

- **Kind**: free-function
- **Source**: 10596:2115:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getInstalledModules(address)`

```solidity
function getInstalledModules(address account) view returns (InstalledModule[] memory modules) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let structSize := 0x40
        let size := mul(length, structSize)
        let totalSize := add(add(size, 0x40), mul(0x20, length))
        let freeMemoryPtr := mload(0x40)
        modules := freeMemoryPtr
        mstore(modules, length)
        mstore(0x40, add(freeMemoryPtr, totalSize))
        let storageLocation := sload(headSlot)
        for {
            let i := 0
        } lt(i, length) {
            i := add(i, 1)
        } {
            let structLocation := add(add(freeMemoryPtr, add(0x40, mul(i, structSize))), mul(0x20, length))
            let moduleType := sload(storageLocation)
            let moduleAddress := sload(add(storageLocation, 0x20))
            mstore(add(freeMemoryPtr, add(0x20, mul(i, 0x20))), structLocation)
            mstore(structLocation, moduleType)
            mstore(add(structLocation, 0x20), moduleAddress)
            storageLocation := sload(add(storageLocation, 0x60))
        }
    }
}
```

### removeInstalledModule(uint256,address)

- **Kind**: free-function
- **Source**: 8701:1838:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:removeInstalledModule(uint256,address)`

```solidity
function removeInstalledModule(uint256 index, address account) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    bytes32 tailSlot = keccak256(abi.encode("ModuleKit.InstalledModuleTail.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let elementSlot := sload(headSlot)
        if lt(index, length) {
            for {
                let i := 0
            } lt(i, index) {
                i := add(i, 1)
            } {
                elementSlot := sload(add(elementSlot, 0x60))
            }
            let prevSlot := sload(add(elementSlot, 0x40))
            let nextSlot := sload(add(elementSlot, 0x60))
            sstore(add(prevSlot, 0x60), nextSlot)
            sstore(add(nextSlot, 0x40), prevSlot)
            if eq(elementSlot, sload(headSlot)) {
                sstore(headSlot, nextSlot)
            }
            if eq(elementSlot, sload(tailSlot)) {
                sstore(tailSlot, prevSlot)
            }
            sstore(elementSlot, 0)
            sstore(add(elementSlot, 0x20), 0)
            sstore(add(elementSlot, 0x40), 0)
            sstore(add(elementSlot, 0x60), 0)
            sstore(lengthSlot, sub(length, 1))
        }
    }
}
```

### getGasIdentifier()

- **Kind**: free-function
- **Source**: 1476:151:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getGasIdentifier()`

```solidity
function getGasIdentifier() view returns (string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    id = readString(slot);
}
```

### readString(bytes32)

- **Kind**: free-function
- **Source**: 13545:742:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:readString(bytes32)`

```solidity
function readString(bytes32 slot) view returns (string memory) {
    uint256 length;
    assembly {
        length := sload(slot)
    }
    bytes memory strBytes = new bytes(length);
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        bytes32 data;
        assembly {
            data := sload(charSlot)
        }
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            strBytes[i + j] = bytes1(uint8(uint256(data >> (248 - (j * 8)))));
        }
    }
    return string(strBytes);
}
```

### calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)

- **Kind**: internal
- **Source**: 8789:510:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)`

```solidity
function calculateGas(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint, address beneficiary, string memory gasIdentifier, uint256 totalUserOpGas) internal {
    bytes memory userOpCalldata = abi.encodeWithSelector(onEntryPoint.handleOps.selector, userOps, beneficiary);
    GasParser.parseAndWriteGas(userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas);
}
```

### parseAndWriteGas(bytes,address,string,address,uint256)

- **Kind**: internal
- **Source**: 243:1164:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:parseAndWriteGas(bytes,address,string,address,uint256)`

```solidity
function parseAndWriteGas(bytes memory userOpCalldata, address entrypoint, string memory gasIdentifier, address sender, uint256 totalUserOpGas) internal {
    string memory fileName = string.concat("./gas_calculations/", gasIdentifier, ".json");
    GasCalculations memory gasCalculations = GasCalculations({creation: GasDebug(entrypoint).getGasConsumed(sender, 0), validation: GasDebug(entrypoint).getGasConsumed(sender, 1), execution: GasDebug(entrypoint).getGasConsumed(sender, 2), total: totalUserOpGas, arbitrum: getArbitrumL1Gas(userOpCalldata), opStack: getOpStackL1Gas(userOpCalldata)});
    GasCalculations memory prevGasCalculations;
    if (exists(fileName)) {
        string memory fileContent = readFile(fileName);
        prevGasCalculations = parsePrevGasReport(fileContent);
    }
    string memory finalJson = formatGasToWrite(gasIdentifier, prevGasCalculations, gasCalculations);
    writeJson(finalJson, fileName);
    writeGasIdentifier("");
}
```

### getArbitrumL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1197:185:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getArbitrumL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on Arbitrum L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on Arbitrum L1.
function getArbitrumL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    bytes memory compressed = LibZip.flzCompress(data);
    calldataGas = getCallDataGas(compressed);
}
```

### flzCompress(bytes)

- **Kind**: internal
- **Source**: 1102:3958:322
- **Link**: `lib/v2-core/lib/solady/src/utils/LibZip.sol:LibZip:flzCompress(bytes)`

```solidity
/// @dev Returns the compressed `data`.
function flzCompress(bytes memory data) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        function ms8 (d_, v_) -> _d {
            mstore8(d_, v_)
            _d := add(d_, 1)
        }
        function u24 (p_) -> _u {
            _u := mload(p_)
            _u := or(shl(16, byte(2, _u)), or(shl(8, byte(1, _u)), byte(0, _u)))
        }
        function cmp (p_, q_, e_) -> _l {
            for {
                e_ := sub(e_, q_)
            } lt(_l, e_) {
                _l := add(_l, 1)
            } {
                e_ := mul(iszero(byte(0, xor(mload(add(p_, _l)), mload(add(q_, _l))))), e_)
            }
        }
        function literals (runs_, src_, dest_) -> _o {
            for {
                _o := dest_
            } iszero(lt(runs_, 0x20)) {
                runs_ := sub(runs_, 0x20)
            } {
                mstore(ms8(_o, 31), mload(src_))
                _o := add(_o, 0x21)
                src_ := add(src_, 0x20)
            }
            if iszero(runs_) {
                leave
            }
            mstore(ms8(_o, sub(runs_, 1)), mload(src_))
            _o := add(1, add(_o, runs_))
        }
        function mt (l_, d_, o_) -> _o {
            for {
                d_ := sub(d_, 1)
            } iszero(lt(l_, 263)) {
                l_ := sub(l_, 262)
            } {
                o_ := ms8(ms8(ms8(o_, add(224, shr(8, d_))), 253), and(0xff, d_))
            }
            if iszero(lt(l_, 7)) {
                _o := ms8(ms8(ms8(o_, add(224, shr(8, d_))), sub(l_, 7)), and(0xff, d_))
                leave
            }
            _o := ms8(ms8(o_, add(shl(5, l_), shr(8, d_))), and(0xff, d_))
        }
        function setHash (i_, v_) {
            let p_ := add(mload(0x40), shl(2, i_))
            mstore(p_, xor(mload(p_), shl(224, xor(shr(224, mload(p_)), v_))))
        }
        function getHash (i_) -> _h {
            _h := shr(224, mload(add(mload(0x40), shl(2, i_))))
        }
        function hash (v_) -> _r {
            _r := and(shr(19, mul(2654435769, v_)), 0x1fff)
        }
        function setNextHash (ip_, ipStart_) -> _ip {
            setHash(hash(u24(ip_)), sub(ip_, ipStart_))
            _ip := add(ip_, 1)
        }
        result := mload(0x40)
        calldatacopy(result, calldatasize(), 0x8000)
        let op := add(result, 0x8000)
        let a := add(data, 0x20)
        let ipStart := a
        let ipLimit := sub(add(ipStart, mload(data)), 13)
        for {
            let ip := add(2, a)
        } lt(ip, ipLimit) {} {
            let r := 0
            let d := 0
            for {} 1 {} {
                let s := u24(ip)
                let h := hash(s)
                r := add(ipStart, getHash(h))
                setHash(h, sub(ip, ipStart))
                d := sub(ip, r)
                if iszero(lt(ip, ipLimit)) {
                    break
                }
                ip := add(ip, 1)
                if iszero(gt(d, 0x1fff)) {
                    if eq(s, u24(r)) {
                        break
                    }
                }
            }
            if iszero(lt(ip, ipLimit)) {
                break
            }
            ip := sub(ip, 1)
            if gt(ip, a) {
                op := literals(sub(ip, a), a, op)
            }
            let l := cmp(add(r, 3), add(ip, 3), add(ipLimit, 9))
            op := mt(l, d, op)
            ip := setNextHash(setNextHash(add(ip, l), ipStart), ipStart)
            a := ip
        }
        let end := sub(literals(sub(add(ipStart, mload(data)), a), a, op), 0x7fe0)
        let o := add(result, 0x20)
        mstore(result, sub(end, o))
        for {} iszero(gt(o, end)) {
            o := add(o, 0x20)
        } {
            mstore(o, mload(add(o, 0x7fe0)))
        }
        mstore(end, 0)
        mstore(0x40, add(end, 0x20))
    }
}
```

### getCallDataGas(bytes)

- **Kind**: free-function
- **Source**: 768:254:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getCallDataGas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata.
function getCallDataGas(bytes memory data) pure returns (uint256 calldataGas) {
    for (uint256 i = 0; i < data.length; i++) {
        if (data[i] == 0x00) {
            calldataGas += 4;
        } else {
            calldataGas += 16;
        }
    }
}
```

### getOpStackL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1555:300:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getOpStackL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on OpStack L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on OpStack L1.
function getOpStackL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    uint256 opStackConstant = 2028;
    UD60x18 opStackScalar = ud(0.684e18);
    calldataGas = intoUint256(PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)) + opStackConstant;
}
```

### ud(uint256)

- **Kind**: free-function
- **Source**: 3445:86:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:ud(uint256)`

```solidity
/// @notice Alias for {wrap}.
function ud(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### intoUint256(UD60x18)

- **Kind**: free-function
- **Source**: 2647:97:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:intoUint256(UD60x18)`

```solidity
/// @notice Casts a UD60x18 number into uint128.
///  @dev This is basically an alias for {unwrap}.
function intoUint256(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### intoUD60x18(uint256)

- **Kind**: internal
- **Source**: 3135:112:109
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/casting/Uint256.sol:PRBMathCastingUint256:intoUD60x18(uint256)`

```solidity
/// @notice Casts a uint256 number to UD60x18.
function intoUD60x18(uint256 x) internal pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mul(UD60x18,UD60x18)

- **Kind**: free-function
- **Source**: 18914:128:137
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Math.sol:mul(UD60x18,UD60x18)`

```solidity
/// @notice Multiplies two UD60x18 numbers together, returning a new UD60x18 number.
///  @dev Uses {Common.mulDiv} to enable overflow-safe multiplication and division.
///  Notes:
///  - Refer to the notes in {Common.mulDiv}.
///  Requirements:
///  - Refer to the requirements in {Common.mulDiv}.
///  @dev See the documentation in {Common.mulDiv18}.
///  @param x The multiplicand as a UD60x18 number.
///  @param y The multiplier as a UD60x18 number.
///  @return result The product as a UD60x18 number.
///  @custom:smtchecker abstract-function-nondet
function mul(UD60x18 x, UD60x18 y) pure returns (UD60x18 result) {
    result = wrap(Common.mulDiv18(x.unwrap(), y.unwrap()));
}
```

### wrap(uint256)

- **Kind**: free-function
- **Source**: 3865:88:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:wrap(uint256)`

```solidity
/// @notice Wraps a uint256 number into the UD60x18 value type.
function wrap(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mulDiv18(uint256,uint256)

- **Kind**: free-function
- **Source**: 19680:819:107
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/Common.sol:mulDiv18(uint256,uint256)`

```solidity
/// @notice Calculates x*y÷1e18 with 512-bit precision.
///  @dev A variant of {mulDiv} with constant folding, i.e. in which the denominator is hard coded to 1e18.
///  Notes:
///  - The body is purposely left uncommented; to understand how this works, see the documentation in {mulDiv}.
///  - The result is rounded toward zero.
///  - We take as an axiom that the result cannot be `MAX_UINT256` when x and y solve the following system of equations:
///  $$
///  \begin{cases}
///      x * y = MAX\_UINT256 * UNIT \\
///      (x * y) \% UNIT \geq \frac{UNIT}{2}
///  \end{cases}
///  $$
///  Requirements:
///  - Refer to the requirements in {mulDiv}.
///  - The result must fit in uint256.
///  @param x The multiplicand as an unsigned 60.18-decimal fixed-point number.
///  @param y The multiplier as an unsigned 60.18-decimal fixed-point number.
///  @return result The result as an unsigned 60.18-decimal fixed-point number.
///  @custom:smtchecker abstract-function-nondet
function mulDiv18(uint256 x, uint256 y) pure returns (uint256 result) {
    uint256 prod0;
    uint256 prod1;
    assembly ("memory-safe") {
        let mm := mulmod(x, y, not(0))
        prod0 := mul(x, y)
        prod1 := sub(sub(mm, prod0), lt(mm, prod0))
    }
    if (prod1 == 0) {
        unchecked {
            return prod0 / UNIT;
        }
    }
    if (prod1 >= UNIT) {
        revert PRBMath_MulDiv18_Overflow(x, y);
    }
    uint256 remainder;
    assembly ("memory-safe") {
        remainder := mulmod(x, y, UNIT)
        result := mul(or(div(sub(prod0, remainder), UNIT_LPOTD), mul(sub(prod1, gt(remainder, prod0)), add(div(sub(0, UNIT_LPOTD), UNIT_LPOTD), 1))), UNIT_INVERSE)
    }
}
```

### unwrap(UD60x18)

- **Kind**: free-function
- **Source**: 3707:92:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:unwrap(UD60x18)`

```solidity
/// @notice Unwraps a UD60x18 number into uint256.
function unwrap(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### exists(string)

- **Kind**: free-function
- **Source**: 3719:96:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:exists(string)`

```solidity
function exists(string memory path) view returns (bool) {
    return Vm(VM_ADDR).exists(path);
}
```

### readFile(string)

- **Kind**: free-function
- **Source**: 3608:109:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:readFile(string)`

```solidity
function readFile(string memory path) view returns (string memory) {
    return Vm(VM_ADDR).readFile(path);
}
```

### parsePrevGasReport(string)

- **Kind**: free-function
- **Source**: 2023:722:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parsePrevGasReport(string)`

```solidity
/// @notice Parse the previous gas report from a file.
///  @param fileContent The content of the file.
///  @return prevGasCalculations The previous gas calculations.
function parsePrevGasReport(string memory fileContent) pure returns (GasCalculations memory prevGasCalculations) {
    prevGasCalculations.total = parseUintFromASCII(parseJson(fileContent, ".Total"));
    prevGasCalculations.creation = parseUintFromASCII(parseJson(fileContent, ".Phases.Creation"));
    prevGasCalculations.validation = parseUintFromASCII(parseJson(fileContent, ".Phases.Validation"));
    prevGasCalculations.execution = parseUintFromASCII(parseJson(fileContent, ".Phases.Execution"));
    prevGasCalculations.arbitrum = parseUintFromASCII(parseJson(fileContent, ".Calldata.Arbitrum"));
    prevGasCalculations.opStack = parseUintFromASCII(parseJson(fileContent, ".Calldata.OP-Stack"));
}
```

### parseUintFromASCII(bytes)

- **Kind**: free-function
- **Source**: 2865:632:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parseUintFromASCII(bytes)`

```solidity
/// @notice Parse a uint256 from ASCII.
///  @param ascii The ASCII to be parsed.
///  @return _ret The parsed uint256.
function parseUintFromASCII(bytes memory ascii) pure returns (uint256 _ret) {
    bytes memory prevTotal;
    uint256 offset = (ascii.length > 32) ? 32 : 0;
    for (uint256 i; i < ascii.length; i++) {
        if (ascii[i] == 0x28) {
            break;
        } else {
            if (i >= offset) {
                prevTotal = abi.encodePacked(prevTotal, ascii[i]);
            }
        }
    }
    uint256 j = 1;
    for (uint256 i = prevTotal.length - 1; i > 0; i--) {
        if ((uint8(prevTotal[i]) >= 48) && (uint8(prevTotal[i]) <= 57)) {
            _ret += (uint8(prevTotal[i]) - 48) * j;
            j *= 10;
        }
    }
}
```

### parseJson(string,string)

- **Kind**: free-function
- **Source**: 4352:134:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:parseJson(string,string)`

```solidity
function parseJson(string memory json, string memory key) pure returns (bytes memory) {
    return Vm(VM_ADDR).parseJson(json, key);
}
```

### formatGasToWrite(string,struct GasCalculations,struct GasCalculations)

- **Kind**: internal
- **Source**: 1413:2033:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:formatGasToWrite(string,struct GasCalculations,struct GasCalculations)`

```solidity
function formatGasToWrite(string memory gasIdentifier, GasCalculations memory prevGasCalculations, GasCalculations memory gasCalculations) internal returns (string memory finalJson) {
    string memory jsonObj = string(abi.encodePacked(gasIdentifier));
    serializeString(jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total}));
    string memory phasesObj = "phases";
    serializeString(phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation}));
    serializeString(phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation}));
    string memory phasesOutput = serializeString(phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution}));
    string memory l2sObj = "l2s";
    serializeString(l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack}));
    string memory l2sOutput = serializeString(l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum}));
    serializeString(jsonObj, "Phases", phasesOutput);
    finalJson = serializeString(jsonObj, "Calldata", l2sOutput);
}
```

### serializeString(string,string,string)

- **Kind**: free-function
- **Source**: 3290:213:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:serializeString(string,string,string)`

```solidity
function serializeString(string memory objectKey, string memory valueKey, string memory value) returns (string memory json) {
    return Vm(VM_ADDR).serializeString(objectKey, valueKey, value);
}
```

### formatGasValue(uint256,uint256)

- **Kind**: free-function
- **Source**: 3669:445:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGasValue(uint256,uint256)`

```solidity
/// @notice Format the gas value.
///  @param prevValue The previous gas value.
///  @param newValue The new gas value.
///  @return formattedValue The formatted gas value.
function formatGasValue(uint256 prevValue, uint256 newValue) pure returns (string memory formattedValue) {
    if (prevValue == 0) {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas");
    } else {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas (diff: ", formatGas(int256(newValue) - int256(prevValue)), ")");
    }
}
```

### formatGas(int256)

- **Kind**: free-function
- **Source**: 4268:455:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGas(int256)`

```solidity
/// @notice Format the gas value with underscores for readability.
///  @param value The gas value to be formatted.
///  @return The formatted gas value.
function formatGas(int256 value) pure returns (string memory) {
    string memory str = toString(value);
    bytes memory bStr = bytes(str);
    bytes memory result = new bytes(bStr.length + ((bStr.length - 1) / 3));
    uint256 j = result.length;
    for (uint256 i = 0; i < bStr.length; i++) {
        if ((i > 0) && ((i % 3) == 0)) {
            result[--j] = "_";
        }
        result[--j] = bStr[(bStr.length - i) - 1];
    }
    return string(result);
}
```

### toString(int256)

- **Kind**: free-function
- **Source**: 3924:104:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(int256)`

```solidity
function toString(int256 input) pure returns (string memory) {
    return Vm(VM_ADDR).toString(input);
}
```

### writeJson(string,string)

- **Kind**: free-function
- **Source**: 3505:101:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:writeJson(string,string)`

```solidity
function writeJson(string memory json, string memory path) {
    Vm(VM_ADDR).writeJson(json, path);
}
```

### writeGasIdentifier(string)

- **Kind**: free-function
- **Source**: 1337:137:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeGasIdentifier(string)`

```solidity
function writeGasIdentifier(string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    writeString(slot, id);
}
```

### writeString(bytes32,string)

- **Kind**: free-function
- **Source**: 12883:660:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeString(bytes32,string)`

```solidity
function writeString(bytes32 slot, string memory value) {
    bytes memory strBytes = bytes(value);
    uint256 length = strBytes.length;
    assembly {
        sstore(slot, length)
    }
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 data;
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            data |= bytes32(uint256(uint8(strBytes[i + j])) << (248 - (j * 8)));
        }
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        assembly {
            sstore(charSlot, data)
        }
    }
}
```

### _depositFreeAssetsFromSingleAmount(uint256,address,address)

- **Kind**: internal
- **Source**: 35772:225:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssetsFromSingleAmount(uint256,address,address)`

```solidity
function _depositFreeAssetsFromSingleAmount(uint256 depositAmount, address vault1, address vault2) internal {
    _depositFreeAssetsFromSingleAmount(depositAmount, address(strategy), address(asset), vault1, vault2);
}
```

### _depositFreeAssetsFromSingleAmount(uint256,address,address,address,address)

- **Kind**: internal
- **Source**: 36287:581:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssetsFromSingleAmount(uint256,address,address,address,address)`

```solidity
function _depositFreeAssetsFromSingleAmount(uint256 depositAmount, address strat, address assetToDeposit, address vault1, address vault2) internal {
    (address[] memory fulfillHooksAddresses, bytes[] memory fulfillHooksData, uint256[] memory expectedAssetsOrSharesOut) = __prepareDepositHookData(depositAmount, assetToDeposit, vault1, vault2);
    __executeDepositHooks(depositAmount, strat, fulfillHooksAddresses, fulfillHooksData, expectedAssetsOrSharesOut);
}
```

### __prepareDepositHookData(uint256,address,address,address)

- **Kind**: internal
- **Source**: 135801:1654:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__prepareDepositHookData(uint256,address,address,address)`

```solidity
function __prepareDepositHookData(uint256 depositAmount, address assetToDeposit, address vault1, address vault2) private view returns (address[] memory fulfillHooksAddresses, bytes[] memory fulfillHooksData, uint256[] memory expectedAssetsOrSharesOut) {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    fulfillHooksAddresses = new address[](2);
    fulfillHooksAddresses[0] = depositHookAddress;
    fulfillHooksAddresses[1] = depositHookAddress;
    fulfillHooksData = new bytes[](2);
    uint256 halfAmount = depositAmount / 2;
    fulfillHooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, assetToDeposit, halfAmount, false, address(0), 0);
    fulfillHooksData[1] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, assetToDeposit, depositAmount - halfAmount, false, address(0), 0);
    expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = IERC4626(address(vault1)).convertToShares(halfAmount);
    expectedAssetsOrSharesOut[1] = IERC4626(address(vault2)).convertToShares(depositAmount - halfAmount);
}
```

### __executeDepositHooks(uint256,address,address[],bytes[],uint256[])

- **Kind**: internal
- **Source**: 137461:1295:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__executeDepositHooks(uint256,address,address[],bytes[],uint256[])`

```solidity
function __executeDepositHooks(uint256 depositAmount, address strat, address[] memory fulfillHooksAddresses, bytes[] memory fulfillHooksData, uint256[] memory expectedAssetsOrSharesOut) private {
    bytes[] memory argsForProofs = new bytes[](2);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    argsForProofs[1] = ISuperHookInspector(fulfillHooksAddresses[1]).inspect(fulfillHooksData[1]);
    vm.startPrank(MANAGER);
    SuperVaultStrategy(payable(strat)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    vm.stopPrank();
    uint256 pricePerShare = _getSuperVaultPricePerShare();
    uint256 shares = depositAmount.mulDiv(SuperVaultStrategy(payable(strat)).PRECISION(), pricePerShare);
    _trackDeposit(accountEth, shares, depositAmount);
}
```

### _getMerkleProofsForHooks(address[],bytes[])

- **Kind**: internal
- **Source**: 6398:1705:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleProofsForHooks(address[],bytes[])`

```solidity
///  @notice Get Merkle proofs for multiple hooks with specific arguments (OPTIMIZED)
///  @dev Uses efficient JS-based lookup to avoid gas-expensive Solidity operations
///  @param hookAddresses Array of hook contract addresses
///  @param encodedHookArgs Array of packed-encoded hook arguments corresponding to each hook
///  @return proofs Array of Merkle proofs for each hook/args combination
function _getMerkleProofsForHooks(address[] memory hookAddresses, bytes[] memory encodedHookArgs) internal returns (bytes32[][] memory proofs) {
    if (hookAddresses.length != encodedHookArgs.length) revert InvalidArrayLengths();
    if (hookAddresses.length == 0) revert EmptyInput();
    string memory addressesArg = "";
    string memory argsArg = "";
    for (uint256 i = 0; i < hookAddresses.length; i++) {
        if (i > 0) {
            addressesArg = string.concat(addressesArg, ",");
            argsArg = string.concat(argsArg, ",");
        }
        addressesArg = string.concat(addressesArg, vm.toString(hookAddresses[i]));
        argsArg = string.concat(argsArg, vm.toString(encodedHookArgs[i]));
    }
    string[] memory cmd = new string[](6);
    cmd[0] = "node";
    cmd[1] = string.concat(vm.projectRoot(), "/test/utils/merkle/merkle-js/efficient-proof-lookup.js");
    cmd[2] = "batch";
    cmd[3] = addressesArg;
    cmd[4] = argsArg;
    cmd[5] = vm.toString(currentChainId);
    bytes memory result = vm.ffi(cmd);
    string memory resultStr = string(result);
    proofs = abi.decode(vm.parseJson(resultStr), (bytes32[][]));
    return proofs;
}
```

### _getSuperVaultPricePerShare()

- **Kind**: internal
- **Source**: 112127:597:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_getSuperVaultPricePerShare()`

```solidity
function _getSuperVaultPricePerShare() internal view returns (uint256 pricePerShare) {
    uint256 totalSupplyAmount = vault.totalSupply();
    if (totalSupplyAmount == 0) {
        pricePerShare = vault.PRECISION();
    } else {
        (uint256 totalAssetsVault, ) = totalAssetHelper.totalAssets(address(strategy));
        pricePerShare = totalAssetsVault.mulDiv(vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor);
    }
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:61
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:55
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### _trackDeposit(address,uint256,uint256)

- **Kind**: internal
- **Source**: 110828:238:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_trackDeposit(address,uint256,uint256)`

```solidity
function _trackDeposit(address user, uint256 shares, uint256 assets) internal {
    SuperVaultState storage state = superVaultStates[user];
    state.accumulatorShares += shares;
    state.accumulatorCostBasis += assets;
}
```

### _executeActiveTradingPeriod(struct SuperVaultTest.UserPersona)

- **Kind**: internal
- **Source**: 427192:2314:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_executeActiveTradingPeriod(struct SuperVaultTest.UserPersona)`

```solidity
/// @notice Execute active trading period
function _executeActiveTradingPeriod(UserPersona memory trader) internal {
    console2.log("\n=== PHASE 2: ACTIVE TRADING PERIOD ===");
    vm.warp(block.timestamp + 1 days);
    _updateSuperVaultPPS(address(strategy), address(vault));
    for (uint256 i = 0; i < 3; i++) {
        TradingCycle memory cycle;
        cycle.cycleNumber = i + 1;
        cycle.depositAmount = trader.depositAmount / 2;
        console2.log("--- Trader Cycle", cycle.cycleNumber, "---");
        _depositForAccount(accInstances[1], cycle.depositAmount);
        cycle.sharesAfterDeposit = vault.balanceOf(trader.account);
        console2.log("Trader shares after deposit:", cycle.sharesAfterDeposit);
        _depositFreeAssetsFromSingleAmount(cycle.depositAmount, address(fluidVault), address(aaveVault));
        console2.log("--pps before---", aggregator.getPPS(address(strategy)));
        _updateSuperVaultPPS(address(strategy), address(vault));
        console2.log("--pps after---", aggregator.getPPS(address(strategy)));
        vm.warp(block.timestamp + 6 hours);
        cycle.redeemAmount = cycle.sharesAfterDeposit / 4;
        if (cycle.redeemAmount > 1) {
            _requestRedeemForAccount(accInstances[1], cycle.redeemAmount);
            uint256 pendingRedeem = strategy.pendingRedeemRequest(trader.account);
            console2.log("Trader pending redeem:", pendingRedeem);
            console2.log("Trader requested redeem shares:", cycle.redeemAmount);
        }
        console2.log("--pps before---", aggregator.getPPS(address(strategy)));
        _updateSuperVaultPPS(address(strategy), address(vault));
        console2.log("--pps after---", aggregator.getPPS(address(strategy)));
        vm.warp(block.timestamp + 6 hours);
    }
}
```

### _updateSuperVaultPPS(address,address)

- **Kind**: internal
- **Source**: 113586:2774:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_updateSuperVaultPPS(address,address)`

```solidity
///  @notice Updates the PPS (Price Per Share) using TotalAssetHelper
///  @return pps The calculated and updated price per share value
///  @dev This function uses TotalAssetHelper to get totalAssets, calculates PPS,
///       creates a signature, and updates the PPS through the ECDSAPPSOracle contract
function _updateSuperVaultPPS(address strategyAddr, address vault_) internal returns (uint256 pps) {
    UpdatePPSVars memory vars;
    vars.totalSupplyAmount = SuperVault(vault_).totalSupply();
    (vars.currentTotalAssets, ) = totalAssetHelper.totalAssets(strategyAddr);
    vars.precision = SuperVault(vault_).PRECISION();
    if (vars.totalSupplyAmount == 0) {
        vars.pps = vars.precision;
    } else {
        vars.pps = vars.currentTotalAssets.mulDiv(vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor);
    }
    vars.timestamp = block.timestamp;
    bytes32 structHash = keccak256(abi.encodePacked(ecdsappsOracle.UPDATE_PPS_TYPEHASH(), strategyAddr, vars.pps, vars.timestamp, ecdsappsOracle.noncePerStrategy(strategyAddr)));
    vars.ethSignedMessageHash = MessageHashUtils.toTypedDataHash(ecdsappsOracle.domainSeparator(), structHash);
    (vars.v, vars.r, vars.s) = vm.sign(VALIDATOR_KEY, vars.ethSignedMessageHash);
    vars.signature = abi.encodePacked(vars.r, vars.s, vars.v);
    vars.proofs = new bytes[](1);
    vars.proofs[0] = vars.signature;
    address[] memory strategies = new address[](1);
    strategies[0] = strategyAddr;
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = vars.proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = vars.pps;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = vars.timestamp;
    ecdsappsOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
    console2.log("Updated PPS for strategy", strategyAddr, vars.pps);
    pps = vars.pps;
    return pps;
}
```

### toTypedDataHash(bytes32,bytes32)

- **Kind**: internal
- **Source**: 3874:374:58
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toTypedDataHash(bytes32,bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an EIP-712 typed data (ERC-191 version `0x01`).
///  The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
///  `\x19\x01` and hashing the result. It corresponds to the hash signed by the
///  https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
///  See {ECDSA-recover}.
function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        let ptr := mload(0x40)
        mstore(ptr, "\u0019\u0001")
        mstore(add(ptr, 0x02), domainSeparator)
        mstore(add(ptr, 0x22), structHash)
        digest := keccak256(ptr, 0x42)
    }
}
```

### log(string,address,uint256)

- **Kind**: internal
- **Source**: 13838:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address,uint256)`

```solidity
function log(string memory p0, address p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2));
}
```

### log(string,uint256,string)

- **Kind**: internal
- **Source**: 11920:174:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,string)`

```solidity
function log(string memory p0, uint256 p1, string memory p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2));
}
```

### _requestRedeemForAccount(struct AccountInstance,uint256)

- **Kind**: internal
- **Source**: 34717:159:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_requestRedeemForAccount(struct AccountInstance,uint256)`

```solidity
function _requestRedeemForAccount(AccountInstance memory accInst, uint256 redeemShares) internal {
    __requestRedeem(accInst, redeemShares, false);
}
```

### __requestRedeem(struct AccountInstance,uint256,bool)

- **Kind**: internal
- **Source**: 29201:1051:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__requestRedeem(struct AccountInstance,uint256,bool)`

```solidity
function __requestRedeem(AccountInstance memory accInst, uint256 redeemShares, bool shouldRevert) internal {
    address[] memory redeemHooksAddresses = new address[](1);
    redeemHooksAddresses[0] = _getHookAddress(ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY);
    bytes[] memory redeemHooksData = new bytes[](1);
    redeemHooksData[0] = _createRequestRedeem7540VaultHookData(_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), redeemShares, false);
    console2.log("__requestRedeem ------ redeemShares", redeemShares);
    ISuperExecutor.ExecutorEntry memory redeemEntry = ISuperExecutor.ExecutorEntry({hooksAddresses: redeemHooksAddresses, hooksData: redeemHooksData});
    UserOpData memory redeemUserOpData = _getExecOps(accInst, superExecutorOnEth, abi.encode(redeemEntry));
    if (shouldRevert) {
        accInst.expect4337Revert();
    }
    executeOp(redeemUserOpData);
}
```

### _createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool)

- **Kind**: internal
- **Source**: 14859:341:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool)`

```solidity
function _createRequestRedeem7540VaultHookData(bytes32 yieldSourceOracleId, address yieldSource, uint256 amount, bool usePrevHookAmount) internal pure returns (bytes memory) {
    return abi.encodePacked(yieldSourceOracleId, yieldSource, amount, usePrevHookAmount);
}
```

### expect4337Revert(struct AccountInstance)

- **Kind**: internal
- **Source**: 21316:97:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:expect4337Revert(struct AccountInstance)`

```solidity
/// @notice Sets the expect revert flag to true
function expect4337Revert(AccountInstance memory) internal {
    writeExpectRevert("");
}
```

### writeExpectRevert(bytes)

- **Kind**: free-function
- **Source**: 235:351:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeExpectRevert(bytes)`

```solidity
function writeExpectRevert(bytes memory message) {
    uint256 value = 1;
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    if (message.length > 0) {
        value = 2;
        assembly {
            sstore(slot, message)
        }
    }
    slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, value)
    }
}
```

### _executeLongTermHolding(struct SuperVaultTest.UserPersona)

- **Kind**: internal
- **Source**: 429563:751:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_executeLongTermHolding(struct SuperVaultTest.UserPersona)`

```solidity
/// @notice Execute long-term holding behavior
function _executeLongTermHolding(UserPersona memory holder) internal {
    console2.log("\n=== PHASE 3: LONG-TERM HOLDER HOLDS POSITION ===");
    uint256 holderSharesAfterTrading = vault.balanceOf(holder.account);
    console2.log("Holder shares remained constant:", holderSharesAfterTrading);
    assertEq(holderSharesAfterTrading, holder.shares, "Holder shares should remain unchanged");
    vm.warp(block.timestamp + 30 days);
    _updateSuperVaultPPS(address(strategy), address(vault));
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

### _executeFinalRedemptions(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)

- **Kind**: internal
- **Source**: 430368:1562:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_executeFinalRedemptions(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)`

```solidity
/// @notice Execute final redemptions phase
function _executeFinalRedemptions(UserPersona memory holder, UserPersona memory trader) internal {
    console2.log("\n=== PHASE 4: FINAL REDEMPTIONS ===");
    uint256 holderFinalShares = vault.balanceOf(holder.account);
    uint256 traderFinalShares = vault.balanceOf(trader.account);
    console2.log("Final holder shares:", holderFinalShares);
    console2.log("Final trader shares:", traderFinalShares);
    if (holderFinalShares > 1) {
        _requestRedeemForAccount(accInstances[0], holderFinalShares - 1);
    }
    if (traderFinalShares > 1) {
        _requestRedeemForAccount(accInstances[1], traderFinalShares - 1);
    }
    uint256 holderPendingRedeem = strategy.pendingRedeemRequest(holder.account);
    uint256 traderPendingRedeem = strategy.pendingRedeemRequest(trader.account);
    console2.log("Holder pending redeem:", holderPendingRedeem);
    console2.log("Trader pending redeem:", traderPendingRedeem);
    uint256 holderRemainingShares = vault.balanceOf(holder.account);
    uint256 traderRemainingShares = vault.balanceOf(trader.account);
    console2.log("Holder remaining shares:", holderRemainingShares);
    console2.log("Trader remaining shares:", traderRemainingShares);
    _verifyFinalState(holder, trader);
}
```

### _verifyFinalState(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)

- **Kind**: internal
- **Source**: 431986:1683:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_verifyFinalState(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona)`

```solidity
/// @notice Verify final state and assertions
function _verifyFinalState(UserPersona memory holder, UserPersona memory trader) internal view {
    console2.log("\n=== FINAL VERIFICATION ===");
    holder.finalBalance = asset.balanceOf(holder.account);
    trader.finalBalance = asset.balanceOf(trader.account);
    console2.log("Holder final balance:", holder.finalBalance);
    console2.log("Trader final balance:", trader.finalBalance);
    uint256 holderPendingRedeem = strategy.pendingRedeemRequest(holder.account);
    uint256 traderPendingRedeem = strategy.pendingRedeemRequest(trader.account);
    console2.log("Holder pending redeem requests:", holderPendingRedeem);
    console2.log("Trader pending redeem requests:", traderPendingRedeem);
    assertGt(holderPendingRedeem, 0, "Holder should have pending redeem requests");
    assertGt(traderPendingRedeem, 0, "Trader should have pending redeem requests");
    uint256 holderRemainingShares = vault.balanceOf(holder.account);
    uint256 traderRemainingShares = vault.balanceOf(trader.account);
    console2.log("Holder remaining shares:", holderRemainingShares);
    console2.log("Trader remaining shares:", traderRemainingShares);
    assertEq(holderRemainingShares, 1, "Holder should have 1 remaining share");
    assertEq(traderRemainingShares, 1, "Trader should have 1 remaining share");
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **IERC20Metadata::balanceOf(address)**

## State Variable Reads

- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **accountEth** (`address`)
- **currentChainId** (`uint256`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **superVaultStates** (`mapping(address => struct BaseSuperVaultTest.SuperVaultState)`)
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_LongTermHolder_vs_ActiveTrader() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["=== SETTING UP USER PERSONAS ==="]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 4)
  │   💬 Args: ["Long-term holder:", holder.account]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 7)
  │   💬 Args: ["Active trader:", trader.account]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 10)
  │   💬 Args: [address(asset), holder.account, holder.depositAmount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 11)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 12)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 13)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 14)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 15)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 16)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 17)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 18)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 19)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 20)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 21)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 22)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 23)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 24)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 25)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 26)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 27)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 28)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 29)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 30)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 31)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 32)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 33)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 34)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 35)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 36)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 37)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 38)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 39)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 40)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 41)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 42)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 43)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 44)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 45)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 46)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 47)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 48)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 49)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 50)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 51)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 52)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 53)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 54)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 55)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 56)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 57)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 58)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 59)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 60)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 61)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 62)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 63)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 64)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 65)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 66)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 67)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 68)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 69)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 70)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 71)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 72)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 73)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 74)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 75)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 76)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 77)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 78)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 79)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 80)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 81)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 82)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 83)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 84)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 85)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 86)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 87)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 88)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 89)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 90)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 91)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 92)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 93)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 94)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 95)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 96)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 97)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 98)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 99)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 100)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 101)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 102)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 103)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 104)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 105)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 106)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 107)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 108)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 109)
  │   💬 Args: [address(asset), trader.account, trader.depositAmount * 5]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 110)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 111)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 112)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 113)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 114)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 115)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 116)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 117)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 118)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 119)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 120)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 121)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 122)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 123)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 124)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 125)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 126)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 127)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 128)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 129)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 130)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 131)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 132)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 133)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 134)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 135)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 136)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 137)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 138)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 139)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 140)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 141)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 142)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 143)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 144)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 145)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 146)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 147)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 148)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 149)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 150)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 151)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 152)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 153)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 154)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 155)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 156)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 157)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 158)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 159)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 160)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 161)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 162)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 163)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 164)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 165)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 166)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 167)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 168)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 169)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 170)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 171)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 172)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 173)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 174)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 175)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 176)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 177)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 178)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 179)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 180)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 181)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 182)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 183)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 184)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 185)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 186)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 187)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 188)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 189)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 190)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 191)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 192)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 193)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 194)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 195)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 196)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 197)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 198)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 199)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 200)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 201)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 202)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 203)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 204)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 205)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 206)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 207)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 208)
  │   💬 Args: ["Holder initial balance:", holder.initialBalance]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 209)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 210)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 211)
  │   💬 Args: ["Trader initial balance:", trader.initialBalance]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 212)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 213)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._executeInitialDeposits(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona) (NodeID: 214)
  │   💬 Args: [holder, trader]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 215)
  │ │   💬 Args: ["\n=== PHASE 1: INITIAL DEPOSITS ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 216)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 217)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositForAccount(struct AccountInstance,uint256) (NodeID: 218)
  │ │   💬 Args: [accInstances[0], holder.depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256) (NodeID: 219)
  │ │     💬 Args: [accInst, depositAmount]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 220)
  │ │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 221)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 222)
  │ │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 223)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 224)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 225)
  │ │       💬 Args: [userOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 226)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 227)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 228)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 229)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 230)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 231)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 232)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 233)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 234)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 235)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 236)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 237)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 238)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 239)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 240)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 241)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 242)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 243)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 244)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 245)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 246)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 247)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 248)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 249)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 250)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 251)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 252)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 253)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 254)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 255)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 256)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 257)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 258)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 259)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 260)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 261)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 262)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 263)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 264)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 265)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 266)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 267)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 268)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 269)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 270)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 271)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 272)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 273)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 274)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 275)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 276)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 277)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 278)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 279)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 280)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 281)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 282)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 283)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 284)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 285)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 286)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 287)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 288)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 289)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 290)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 291)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 292)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 293)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 294)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 295)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 296)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 297)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 298)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 299)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 300)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 301)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 302)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 303)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 304)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 305)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 306)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 307)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 308)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 309)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 310)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 311)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 312)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 313)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 314)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 317)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 315)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 316)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 318)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 319)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 320)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 321)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 322)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 323)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 324)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 325)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 326)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 327)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 328)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 329)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 330)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 331)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 332)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 333)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 334)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 335)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 336)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 337)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 338)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 339)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 340)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 341)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 342)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 343)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 344)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 345)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 346)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 347)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 348)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 349)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 350)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 351)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 352)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 353)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 354)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 355)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 356)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 357)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 358)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 359)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 360)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 361)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 362)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 363)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 364)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 365)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 366)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 367)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 368)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 369)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 370)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 371)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 372)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 373)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 374)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 375)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 376)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 377)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 378)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 379)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 380)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 381)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 382)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 383)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 384)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 385)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 386)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 387)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 388)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 389)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 390)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 391)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 392)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 393)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 394)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 395)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 396)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 397)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 398)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 399)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 400)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 401)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 402)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 403)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 404)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 405)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 406)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 407)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 408)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 409)
  │ │   💬 Args: ["Holder deposited and received shares:", holder.shares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 410)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 411)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositForAccount(struct AccountInstance,uint256) (NodeID: 412)
  │ │   💬 Args: [accInstances[1], trader.depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256) (NodeID: 413)
  │ │     💬 Args: [accInst, depositAmount]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 414)
  │ │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 415)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 416)
  │ │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 417)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 418)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 419)
  │ │       💬 Args: [userOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 420)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 421)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 422)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 423)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 424)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 425)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 426)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 427)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 428)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 429)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 430)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 431)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 432)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 433)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 434)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 435)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 436)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 437)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 438)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 439)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 440)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 441)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 442)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 443)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 444)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 445)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 446)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 447)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 448)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 449)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 450)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 451)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 452)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 453)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 454)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 455)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 456)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 457)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 458)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 459)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 460)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 461)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 462)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 463)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 464)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 465)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 466)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 467)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 468)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 469)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 470)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 471)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 472)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 473)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 474)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 475)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 476)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 477)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 478)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 479)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 480)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 481)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 482)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 483)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 484)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 485)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 486)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 487)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 488)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 489)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 490)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 491)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 492)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 493)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 494)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 495)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 496)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 497)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 498)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 499)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 500)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 501)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 502)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 503)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 504)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 505)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 506)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 507)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 508)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 511)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 509)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 510)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 512)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 513)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 514)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 515)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 516)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 517)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 518)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 519)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 520)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 521)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 522)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 523)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 524)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 525)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 526)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 527)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 528)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 529)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 530)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 531)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 532)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 533)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 534)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 535)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 536)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 537)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 538)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 539)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 540)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 541)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 542)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 543)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 544)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 545)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 546)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 547)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 548)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 549)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 550)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 551)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 552)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 553)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 554)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 555)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 556)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 557)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 558)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 559)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 560)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 561)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 562)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 563)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 564)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 565)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 566)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 567)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 568)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 569)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 570)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 571)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 572)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 573)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 574)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 575)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 576)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 577)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 578)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 579)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 580)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 581)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 582)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 583)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 584)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 585)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 586)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 587)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 588)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 589)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 590)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 591)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 592)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 593)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 594)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 595)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 596)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 597)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 598)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 599)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 600)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 601)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 602)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 603)
  │ │   💬 Args: ["Trader deposited and received shares:", trader.shares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 604)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 605)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount(uint256,address,address) (NodeID: 606)
  │     💬 Args: [totalDeposited, address(fluidVault), address(aaveVault)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount(uint256,address,address,address,address) (NodeID: 607)
  │       💬 Args: [depositAmount, address(strategy), address(asset), vault1, vault2]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseSuperVaultTest.__prepareDepositHookData(uint256,address,address,address) (NodeID: 608)
  │     │   💬 Args: [depositAmount, assetToDeposit, vault1, vault2]
  │     │   👁️  Def: private
  │     │ ├─ [5] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 609)
  │     │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │     │ │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 610)
  │     │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, assetToDeposit, halfAmount, false, address(0), 0]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 611)
  │     │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 612)
  │     │     💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, assetToDeposit, depositAmount - halfAmount, false, address(0), 0]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 613)
  │     │       💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │     │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: BaseSuperVaultTest.__executeDepositHooks(uint256,address,address[],bytes[],uint256[]) (NodeID: 614)
  │         💬 Args: [depositAmount, strat, fulfillHooksAddresses, fulfillHooksData, expectedAssetsOrSharesOut]
  │         👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 615)
  │       │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 616)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 617)
  │       │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 618)
  │       │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 619)
  │       │   │     💬 Args: [rounding]
  │       │   │     👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 620)
  │       │       💬 Args: [x, y, denominator]
  │       │       👁️  Def: internal
  │       │     ├─ [8] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 621)
  │       │     │   💬 Args: [x, y]
  │       │     │   👁️  Def: internal
  │       │     └─ [8] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 622)
  │       │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       │         👁️  Def: internal
  │       │       └─ [9] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 623)
  │       │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       │           👁️  Def: internal
  │       │         └─ [10] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 624)
  │       │             💬 Args: [condition]
  │       │             👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 625)
  │       │   💬 Args: [depositAmount, SuperVaultStrategy(payable(strat)).PRECISION(), pricePerShare]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 626)
  │       │ │   💬 Args: [x, y]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 627)
  │       │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       │     👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 628)
  │       │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       │       👁️  Def: internal
  │       │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 629)
  │       │         💬 Args: [condition]
  │       │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 630)
  │           💬 Args: [accountEth, shares, depositAmount]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._executeActiveTradingPeriod(struct SuperVaultTest.UserPersona) (NodeID: 631)
  │   💬 Args: [trader]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 632)
  │ │   💬 Args: ["\n=== PHASE 2: ACTIVE TRADING PERIOD ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 633)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 634)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 635)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 636)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 637)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 638)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 639)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 640)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 641)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 642)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 643)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 644)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 645)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 646)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 647)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256,string) (NodeID: 648)
  │ │   💬 Args: ["--- Trader Cycle", cycle.cycleNumber, "---"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 649)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 650)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositForAccount(struct AccountInstance,uint256) (NodeID: 651)
  │ │   💬 Args: [accInstances[1], cycle.depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256) (NodeID: 652)
  │ │     💬 Args: [accInst, depositAmount]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 653)
  │ │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 654)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 655)
  │ │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 656)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 657)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 658)
  │ │       💬 Args: [userOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 659)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 660)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 661)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 662)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 663)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 664)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 665)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 666)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 667)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 668)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 669)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 670)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 671)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 672)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 673)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 674)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 675)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 676)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 677)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 678)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 679)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 680)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 681)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 682)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 683)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 684)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 685)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 686)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 687)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 688)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 689)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 690)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 691)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 692)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 693)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 694)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 695)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 696)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 697)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 698)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 699)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 700)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 701)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 702)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 703)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 704)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 705)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 706)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 707)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 708)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 709)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 710)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 711)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 712)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 713)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 714)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 715)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 716)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 717)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 718)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 719)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 720)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 721)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 722)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 723)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 724)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 725)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 726)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 727)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 728)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 729)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 730)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 731)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 732)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 733)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 734)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 735)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 736)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 737)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 738)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 739)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 740)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 741)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 742)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 743)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 744)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 745)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 746)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 747)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 750)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 748)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 749)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 751)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 752)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 753)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 754)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 755)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 756)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 757)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 758)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 759)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 760)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 761)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 762)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 763)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 764)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 765)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 766)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 767)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 768)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 769)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 770)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 771)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 772)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 773)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 774)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 775)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 776)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 777)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 778)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 779)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 780)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 781)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 782)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 783)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 784)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 785)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 786)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 787)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 788)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 789)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 790)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 791)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 792)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 793)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 794)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 795)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 796)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 797)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 798)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 799)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 800)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 801)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 802)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 803)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 804)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 805)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 806)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 807)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 808)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 809)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 810)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 811)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 812)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 813)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 814)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 815)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 816)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 817)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 818)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 819)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 820)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 821)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 822)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 823)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 824)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 825)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 826)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 827)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 828)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 829)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 830)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 831)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 832)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 833)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 834)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 835)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 836)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 837)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 838)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 839)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 840)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 841)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 842)
  │ │   💬 Args: ["Trader shares after deposit:", cycle.sharesAfterDeposit]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 843)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 844)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount(uint256,address,address) (NodeID: 845)
  │ │   💬 Args: [cycle.depositAmount, address(fluidVault), address(aaveVault)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount(uint256,address,address,address,address) (NodeID: 846)
  │ │     💬 Args: [depositAmount, address(strategy), address(asset), vault1, vault2]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseSuperVaultTest.__prepareDepositHookData(uint256,address,address,address) (NodeID: 847)
  │ │   │   💬 Args: [depositAmount, assetToDeposit, vault1, vault2]
  │ │   │   👁️  Def: private
  │ │   │ ├─ [5] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 848)
  │ │   │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   │ │   👁️  Def: internal
  │ │   │ ├─ [5] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 849)
  │ │   │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, assetToDeposit, halfAmount, false, address(0), 0]
  │ │   │ │   👁️  Def: internal
  │ │   │ │ └─ [6] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 850)
  │ │   │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │ │     👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 851)
  │ │   │     💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, assetToDeposit, depositAmount - halfAmount, false, address(0), 0]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 852)
  │ │   │       💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: BaseSuperVaultTest.__executeDepositHooks(uint256,address,address[],bytes[],uint256[]) (NodeID: 853)
  │ │       💬 Args: [depositAmount, strat, fulfillHooksAddresses, fulfillHooksData, expectedAssetsOrSharesOut]
  │ │       👁️  Def: private
  │ │     ├─ [5] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 854)
  │ │     │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │     │   👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 855)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 856)
  │ │     │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 857)
  │ │     │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 858)
  │ │     │   │     💬 Args: [rounding]
  │ │     │   │     👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 859)
  │ │     │       💬 Args: [x, y, denominator]
  │ │     │       👁️  Def: internal
  │ │     │     ├─ [8] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 860)
  │ │     │     │   💬 Args: [x, y]
  │ │     │     │   👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 861)
  │ │     │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     │         👁️  Def: internal
  │ │     │       └─ [9] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 862)
  │ │     │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │     │           👁️  Def: internal
  │ │     │         └─ [10] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 863)
  │ │     │             💬 Args: [condition]
  │ │     │             👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 864)
  │ │     │   💬 Args: [depositAmount, SuperVaultStrategy(payable(strat)).PRECISION(), pricePerShare]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 865)
  │ │     │ │   💬 Args: [x, y]
  │ │     │ │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 866)
  │ │     │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     │     👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 867)
  │ │     │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 868)
  │ │     │         💬 Args: [condition]
  │ │     │         👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 869)
  │ │         💬 Args: [accountEth, shares, depositAmount]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 870)
  │ │   💬 Args: ["--pps before---", aggregator.getPPS(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 871)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 872)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 873)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 874)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 875)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 876)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 877)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 878)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 879)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 880)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 881)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 882)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 883)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 884)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 885)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 886)
  │ │   💬 Args: ["--pps after---", aggregator.getPPS(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 887)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 888)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._requestRedeemForAccount(struct AccountInstance,uint256) (NodeID: 889)
  │ │   💬 Args: [accInstances[1], cycle.redeemAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__requestRedeem(struct AccountInstance,uint256,bool) (NodeID: 890)
  │ │     💬 Args: [accInst, redeemShares, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 891)
  │ │   │   💬 Args: [ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool) (NodeID: 892)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), redeemShares, false]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 893)
  │ │   │     💬 Args: [bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 894)
  │ │   │   💬 Args: ["__requestRedeem ------ redeemShares", redeemShares]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 895)
  │ │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 896)
  │ │   │       💬 Args: [_sendLogPayloadView]
  │ │   │       👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 897)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(redeemEntry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 898)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.expect4337Revert(struct AccountInstance) (NodeID: 899)
  │ │   │   💬 Args: [accInst]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown.writeExpectRevert(bytes) (NodeID: 900)
  │ │   │     💬 Args: [""]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 901)
  │ │       💬 Args: [redeemUserOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 902)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 903)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 904)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 905)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 906)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 907)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 908)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 909)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 910)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 911)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 912)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 913)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 914)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 915)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 916)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 917)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 918)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 919)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 920)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 921)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 922)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 923)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 924)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 925)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 926)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 927)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 928)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 929)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 930)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 931)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 932)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 933)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 934)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 935)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 936)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 937)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 938)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 939)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 940)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 941)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 942)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 943)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 944)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 945)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 946)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 947)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 948)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 949)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 950)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 951)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 952)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 953)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 954)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 955)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 956)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 957)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 958)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 959)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 960)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 961)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 962)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 963)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 964)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 965)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 966)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 967)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 968)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 969)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 970)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 971)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 972)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 973)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 974)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 975)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 976)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 977)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 978)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 979)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 980)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 981)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 982)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 983)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 984)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 985)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 986)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 987)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 988)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 989)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 990)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 993)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 991)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 992)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 994)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 995)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 996)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 997)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 998)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 999)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1000)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 1001)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 1002)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 1003)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 1004)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1005)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 1006)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 1007)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 1008)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 1009)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1010)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 1011)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 1012)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 1013)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1014)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1015)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 1016)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 1017)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 1018)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1019)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1020)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1021)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1022)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1023)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1024)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1025)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1026)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1027)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1028)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1029)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1030)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 1031)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1032)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1033)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1034)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1035)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1036)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1037)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1038)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1039)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1040)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1041)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1042)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1043)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1044)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1045)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1046)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1047)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1048)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1049)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1050)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1051)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1052)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1053)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1054)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1055)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1056)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1057)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1058)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1059)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1060)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1061)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1062)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1063)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1064)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1065)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1066)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1067)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1068)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1069)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1070)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1071)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1072)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1073)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1074)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1075)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1076)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1077)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1078)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1079)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1080)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1081)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 1082)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 1083)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 1084)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1085)
  │ │   💬 Args: ["Trader pending redeem:", pendingRedeem]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1086)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1087)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1088)
  │ │   💬 Args: ["Trader requested redeem shares:", cycle.redeemAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1089)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1090)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1091)
  │ │   💬 Args: ["--pps before---", aggregator.getPPS(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1092)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1093)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 1094)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 1095)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 1096)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 1097)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 1098)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 1099)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 1100)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 1101)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 1102)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1103)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 1104)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1105)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1106)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1107)
  │     💬 Args: ["--pps after---", aggregator.getPPS(address(strategy))]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1108)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1109)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._executeLongTermHolding(struct SuperVaultTest.UserPersona) (NodeID: 1110)
  │   💬 Args: [holder]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 1111)
  │ │   💬 Args: ["\n=== PHASE 3: LONG-TERM HOLDER HOLDS POSITION ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1112)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1113)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1114)
  │ │   💬 Args: ["Holder shares remained constant:", holderSharesAfterTrading]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1115)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1116)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1117)
  │ │   💬 Args: [holderSharesAfterTrading, holder.shares, "Holder shares should remain unchanged"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 1118)
  │     💬 Args: [address(strategy), address(vault)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 1119)
  │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 1120)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 1121)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 1122)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 1123)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 1124)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 1125)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 1126)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 1127)
  │   │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 1128)
  │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1129)
  │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1130)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._executeFinalRedemptions(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona) (NodeID: 1131)
  │   💬 Args: [holder, trader]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 1132)
  │ │   💬 Args: ["\n=== PHASE 4: FINAL REDEMPTIONS ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1133)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1134)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1135)
  │ │   💬 Args: ["Final holder shares:", holderFinalShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1136)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1137)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1138)
  │ │   💬 Args: ["Final trader shares:", traderFinalShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1139)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1140)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._requestRedeemForAccount(struct AccountInstance,uint256) (NodeID: 1141)
  │ │   💬 Args: [accInstances[0], holderFinalShares - 1]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__requestRedeem(struct AccountInstance,uint256,bool) (NodeID: 1142)
  │ │     💬 Args: [accInst, redeemShares, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 1143)
  │ │   │   💬 Args: [ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool) (NodeID: 1144)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), redeemShares, false]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 1145)
  │ │   │     💬 Args: [bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1146)
  │ │   │   💬 Args: ["__requestRedeem ------ redeemShares", redeemShares]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1147)
  │ │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1148)
  │ │   │       💬 Args: [_sendLogPayloadView]
  │ │   │       👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 1149)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(redeemEntry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 1150)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.expect4337Revert(struct AccountInstance) (NodeID: 1151)
  │ │   │   💬 Args: [accInst]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown.writeExpectRevert(bytes) (NodeID: 1152)
  │ │   │     💬 Args: [""]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 1153)
  │ │       💬 Args: [redeemUserOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 1154)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 1155)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 1156)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 1157)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 1158)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1159)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 1160)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 1161)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 1162)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 1163)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 1164)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 1165)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 1166)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 1167)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 1168)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1169)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1170)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1171)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1172)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1173)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 1174)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 1175)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1176)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 1177)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 1178)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 1179)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 1180)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1181)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 1182)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1183)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1184)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1185)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1186)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1187)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1188)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1189)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1190)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1191)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1192)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1193)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1194)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1195)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1196)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1197)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1198)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1199)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1200)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1201)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1202)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 1203)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1204)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1205)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1206)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1207)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1208)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1209)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1210)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1211)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1212)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1213)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1214)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1215)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1216)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1217)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1218)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1219)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1220)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1221)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1222)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1223)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1224)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1225)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1226)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1227)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1228)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1229)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1230)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1231)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1232)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 1233)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 1234)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 1235)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1236)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1237)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1238)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 1239)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1240)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1241)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1242)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1245)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1243)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1244)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 1246)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 1247)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 1248)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 1249)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 1250)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 1251)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1252)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 1253)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 1254)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 1255)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 1256)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1257)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 1258)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 1259)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 1260)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 1261)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1262)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 1263)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 1264)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 1265)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1266)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1267)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 1268)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 1269)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 1270)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1271)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1272)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1273)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1274)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1275)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1276)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1277)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1278)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1279)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1280)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1281)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1282)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 1283)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1284)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1285)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1286)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1287)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1288)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1289)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1290)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1291)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1292)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1293)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1294)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1295)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1296)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1297)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1298)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1299)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1300)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1301)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1302)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1303)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1304)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1305)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1306)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1307)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1308)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1309)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1310)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1311)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1312)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1313)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1314)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1315)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1316)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1317)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1318)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1319)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1320)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1321)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1322)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1323)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1324)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1325)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1326)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1327)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1328)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1329)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1330)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1331)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1332)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1333)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 1334)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 1335)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 1336)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._requestRedeemForAccount(struct AccountInstance,uint256) (NodeID: 1337)
  │ │   💬 Args: [accInstances[1], traderFinalShares - 1]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__requestRedeem(struct AccountInstance,uint256,bool) (NodeID: 1338)
  │ │     💬 Args: [accInst, redeemShares, false]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 1339)
  │ │   │   💬 Args: [ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool) (NodeID: 1340)
  │ │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), redeemShares, false]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 1341)
  │ │   │     💬 Args: [bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1342)
  │ │   │   💬 Args: ["__requestRedeem ------ redeemShares", redeemShares]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1343)
  │ │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1344)
  │ │   │       💬 Args: [_sendLogPayloadView]
  │ │   │       👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 1345)
  │ │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(redeemEntry)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 1346)
  │ │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.expect4337Revert(struct AccountInstance) (NodeID: 1347)
  │ │   │   💬 Args: [accInst]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown.writeExpectRevert(bytes) (NodeID: 1348)
  │ │   │     💬 Args: [""]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 1349)
  │ │       💬 Args: [redeemUserOpData]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 1350)
  │ │         💬 Args: [userOpData]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 1351)
  │ │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 1352)
  │ │             💬 Args: [userOps, onEntryPoint]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 1353)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 1354)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1355)
  │ │           │   💬 Args: ["SIMULATE", false]
  │ │           │   👁️  Def: public
  │ │           ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 1356)
  │ │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 1357)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 1358)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 1359)
  │ │           │ │ │   💬 Args: [no args]
  │ │           │ │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 1360)
  │ │           │ │     💬 Args: [no args]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 1361)
  │ │           │     💬 Args: [userOpDetails]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 1362)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 1363)
  │ │           │   │   💬 Args: [userOpDetails, debugTrace]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 1364)
  │ │           │   │ │   💬 Args: [userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1365)
  │ │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1366)
  │ │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 1367)
  │ │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1368)
  │ │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: private
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1369)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 1370)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 1371)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1372)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 1373)
  │ │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │           │   │ │ │   👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 1374)
  │ │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 1375)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 1376)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1377)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 1378)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1379)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1380)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1381)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1382)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1383)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1384)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1385)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1386)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1387)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1388)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1389)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1390)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1391)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1392)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1393)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1394)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1395)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1396)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1397)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1398)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 1399)
  │ │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1400)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1401)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1402)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1403)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1404)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1405)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1406)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1407)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1408)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1409)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1410)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1411)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 1412)
  │ │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1413)
  │ │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 1414)
  │ │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1415)
  │ │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │           │   │ │ │ │ │   👁️  Def: internal
  │ │           │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 1416)
  │ │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │           │   │ │ │ │     👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 1417)
  │ │           │   │ │ │     💬 Args: [key, entity]
  │ │           │   │ │ │     👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1418)
  │ │           │   │ │     💬 Args: [currentAccessAccount]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1419)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1420)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 1421)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1422)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1423)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1424)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 1425)
  │ │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 1426)
  │ │           │   │ │     💬 Args: [targetAddr]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1427)
  │ │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 1428)
  │ │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │           │   │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 1429)
  │ │           │   │   💬 Args: [no args]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 1430)
  │ │           │       💬 Args: [snapShotId]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 1431)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1432)
  │ │           │   💬 Args: [ctx.returnData]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1433)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1434)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 1435)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1436)
  │ │           │   💬 Args: [logs, userOpHash]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1437)
  │ │           │   💬 Args: [account]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1438)
  │ │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1441)
  │ │           │ │   💬 Args: [logs, userOpHash]
  │ │           │ │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1439)
  │ │           │ │   💬 Args: [no args]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1440)
  │ │           │     💬 Args: [actualReason, revertMessage]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 1442)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 1443)
  │ │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 1444)
  │ │           │   💬 Args: [logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 1445)
  │ │           │   💬 Args: [j, logs[i].emitter]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 1446)
  │ │           │   💬 Args: [no args]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 1447)
  │ │           │     💬 Args: [slot]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1448)
  │ │           │   💬 Args: ["GAS", false]
  │ │           │   👁️  Def: public
  │ │           └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 1449)
  │ │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 1450)
  │ │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │                 👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 1451)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 1452)
  │ │               │ │   💬 Args: [data]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1453)
  │ │               │     💬 Args: [compressed]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 1454)
  │ │               │   💬 Args: [userOpCalldata]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 1455)
  │ │               │ │   💬 Args: [0.684e18]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 1456)
  │ │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │               │     👁️  Def: internal
  │ │               │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 1457)
  │ │               │   │   💬 Args: [getCallDataGas(data)]
  │ │               │   │   👁️  Def: internal
  │ │               │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1458)
  │ │               │   │     💬 Args: [data]
  │ │               │   │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 1459)
  │ │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │               │       👁️  Def: internal
  │ │               │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 1460)
  │ │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │               │         👁️  Def: internal
  │ │               │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 1461)
  │ │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │               │           👁️  Def: internal
  │ │               │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1462)
  │ │               │         │   💬 Args: [x]
  │ │               │         │   👁️  Def: internal
  │ │               │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1463)
  │ │               │             💬 Args: [y]
  │ │               │             👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 1464)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 1465)
  │ │               │   💬 Args: [fileName]
  │ │               │   👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 1466)
  │ │               │   💬 Args: [fileContent]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1467)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1468)
  │ │               │ │     💬 Args: [fileContent, ".Total"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1469)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1470)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1471)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1472)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1473)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1474)
  │ │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │               │ │     👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1475)
  │ │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1476)
  │ │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │               │ │     👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1477)
  │ │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │               │     👁️  Def: internal
  │ │               │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1478)
  │ │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │               │       👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 1479)
  │ │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │               │   👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1480)
  │ │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1481)
  │ │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1482)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1483)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1484)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1485)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1486)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1487)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1488)
  │ │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1489)
  │ │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1490)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1491)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1492)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1493)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1494)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1495)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1496)
  │ │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1497)
  │ │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1498)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1499)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1500)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1501)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1502)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1503)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1504)
  │ │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1505)
  │ │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1506)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1507)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1508)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1509)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1510)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1511)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1512)
  │ │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1513)
  │ │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1514)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1515)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1516)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1517)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1518)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1519)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1520)
  │ │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │               │ │   👁️  Def: internal
  │ │               │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1521)
  │ │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │               │ │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1522)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1523)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1524)
  │ │               │ │   │   💬 Args: [int256(newValue)]
  │ │               │ │   │   👁️  Def: internal
  │ │               │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1525)
  │ │               │ │   │     💬 Args: [value]
  │ │               │ │   │     👁️  Def: internal
  │ │               │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1526)
  │ │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │               │ │       👁️  Def: internal
  │ │               │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1527)
  │ │               │ │         💬 Args: [value]
  │ │               │ │         👁️  Def: internal
  │ │               │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1528)
  │ │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │               │ │   👁️  Def: internal
  │ │               │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1529)
  │ │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │               │     👁️  Def: internal
  │ │               ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 1530)
  │ │               │   💬 Args: [finalJson, fileName]
  │ │               │   👁️  Def: internal
  │ │               └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 1531)
  │ │                   💬 Args: [""]
  │ │                   👁️  Def: internal
  │ │                 └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 1532)
  │ │                     💬 Args: [slot, id]
  │ │                     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1533)
  │ │   💬 Args: ["Holder pending redeem:", holderPendingRedeem]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1534)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1535)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1536)
  │ │   💬 Args: ["Trader pending redeem:", traderPendingRedeem]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1537)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1538)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1539)
  │ │   💬 Args: ["Holder remaining shares:", holderRemainingShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1540)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1541)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1542)
  │ │   💬 Args: ["Trader remaining shares:", traderRemainingShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1543)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1544)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultTest._verifyFinalState(struct SuperVaultTest.UserPersona,struct SuperVaultTest.UserPersona) (NodeID: 1545)
  │     💬 Args: [holder, trader]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 1546)
  │   │   💬 Args: ["\n=== FINAL VERIFICATION ==="]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1547)
  │   │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1548)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1549)
  │   │   💬 Args: ["Holder final balance:", holder.finalBalance]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1550)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1551)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1552)
  │   │   💬 Args: ["Trader final balance:", trader.finalBalance]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1553)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1554)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1555)
  │   │   💬 Args: ["Holder pending redeem requests:", holderPendingRedeem]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1556)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1557)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1558)
  │   │   💬 Args: ["Trader pending redeem requests:", traderPendingRedeem]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1559)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1560)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1561)
  │   │   💬 Args: [holderPendingRedeem, 0, "Holder should have pending redeem requests"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1562)
  │   │   💬 Args: [traderPendingRedeem, 0, "Trader should have pending redeem requests"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1563)
  │   │   💬 Args: ["Holder remaining shares:", holderRemainingShares]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1564)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1565)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1566)
  │   │   💬 Args: ["Trader remaining shares:", traderRemainingShares]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1567)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1568)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1569)
  │   │   💬 Args: [holderRemainingShares, 1, "Holder should have 1 remaining share"]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1570)
  │       💬 Args: [traderRemainingShares, 1, "Trader should have 1 remaining share"]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1571)
      💬 Args: ["=== TEST COMPLETED SUCCESSFULLY ==="]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1572)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1573)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Test simulating different user personas: Long-term holder vs Active trader
 @dev This test demonstrates how different user behaviors interact with the SuperVault system
