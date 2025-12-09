# Function: test_MultipleUsers_Redeem_From_Liquidity()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_MultipleUsers_Redeem_From_Liquidity()`
- **Visibility**: public
- **Source Range**: 241402:2278:580

## Implementation

```solidity
function test_MultipleUsers_Redeem_From_Liquidity() public {
    uint256 depositAmount = 1000e6;
    _depositForAllUsers(depositAmount);
    uint256 strategyAssetBalance = asset.balanceOf(address(strategy));
    _depositFreeAssets(strategyAssetBalance / 2, strategyAssetBalance / 2, address(fluidVault), address(aaveVault));
    uint256[] memory initialShareBalances = new uint256[](ACCOUNT_COUNT);
    for (uint256 i; i < ACCOUNT_COUNT; i++) {
        initialShareBalances[i] = vault.balanceOf(accInstances[i].account);
    }
    uint256 redeemShares;
    uint256 totalRedeemShares;
    address[] memory requestingUsers = new address[](ACCOUNT_COUNT);
    for (uint256 i; i < ACCOUNT_COUNT; i++) {
        redeemShares = vault.balanceOf(accInstances[i].account);
        _requestRedeemForAccount(accInstances[i], redeemShares);
        totalRedeemShares += redeemShares;
        requestingUsers[i] = accInstances[i].account;
    }
    _executeRedeemHooks4626(totalRedeemShares, address(fluidVault), address(aaveVault), requestingUsers);
    for (uint256 i; i < ACCOUNT_COUNT; i++) {
        address user = accInstances[i].account;
        ISuperVaultStrategy.SuperVaultState memory finalState = strategy.getSuperVaultState(user);
        assertEq(finalState.pendingRedeemRequest, 0, "Pending redeem request not cleared for user");
        assertEq(finalState.averageRequestPPS, 0, "Average request PPS not cleared for user");
        assertEq(strategy.pendingRedeemRequest(user), 0, "Pending redeem request still exists for user");
        assertEq(vault.pendingRedeemRequest(0, user), 0, "ERC7540 pending redeem not cleared for user");
        assertGt(finalState.maxWithdraw, 0, "User should have claimable assets after fulfillment");
    }
}
```

## Related Implementations

### _depositForAllUsers(uint256)

- **Kind**: internal
- **Source**: 33599:272:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositForAllUsers(uint256)`

```solidity
function _depositForAllUsers(uint256 depositAmount) internal {
    for (uint256 i; i < ACCOUNT_COUNT; ++i) {
        _getTokens(address(asset), accInstances[i].account, depositAmount);
        _depositForAccount(accInstances[i], depositAmount);
    }
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

### _depositFreeAssets(uint256,uint256,address,address)

- **Kind**: internal
- **Source**: 55893:2240:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssets(uint256,uint256,address,address)`

```solidity
function _depositFreeAssets(uint256 allocationAmountVault1, uint256 allocationAmountVault2, address vault1, address vault2) internal {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](2);
    fulfillHooksAddresses[0] = depositHookAddress;
    fulfillHooksAddresses[1] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](2);
    fulfillHooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0);
    fulfillHooksData[1] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = IERC4626(address(vault1)).convertToShares(allocationAmountVault1);
    expectedAssetsOrSharesOut[1] = IERC4626(address(vault2)).convertToShares(allocationAmountVault2);
    vm.startPrank(MANAGER);
    bytes[] memory argsForProofs = new bytes[](2);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    argsForProofs[1] = ISuperHookInspector(fulfillHooksAddresses[1]).inspect(fulfillHooksData[1]);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    vm.stopPrank();
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
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

### _executeRedeemHooks4626(uint256,address,address,address[])

- **Kind**: internal
- **Source**: 66555:2949:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_executeRedeemHooks4626(uint256,address,address,address[])`

```solidity
function _executeRedeemHooks4626(uint256 redeemShares, address vault1, address vault2, address[] memory requestingUsers) internal {
    if (requestingUsers.length == 0) {
        requestingUsers = new address[](1);
        requestingUsers[0] = accountEth;
    }
    address[] memory hooksAddresses = new address[](2);
    hooksAddresses[0] = _getHookAddress(ETH, REDEEM_4626_VAULT_HOOK_KEY);
    hooksAddresses[1] = _getHookAddress(ETH, REDEEM_4626_VAULT_HOOK_KEY);
    (uint256 vault1SharesOut, uint256 vault2SharesOut) = _convertSVStoUnderlyingShares(redeemShares, vault1, vault2);
    vault1SharesOut = _truncateToActualBalance(vault1SharesOut, vault1, 100);
    vault2SharesOut = _truncateToActualBalance(vault2SharesOut, vault2, 100);
    console2.log("Vault 1 Shares Out", vault1SharesOut);
    console2.log("Vault 2 Shares Out", vault2SharesOut);
    bytes[] memory hooksData = new bytes[](2);
    hooksData[0] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(strategy), vault1SharesOut, false);
    hooksData[1] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(strategy), vault2SharesOut, false);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = IERC4626(address(vault1)).convertToAssets(vault1SharesOut);
    expectedAssetsOrSharesOut[1] = IERC4626(address(vault2)).convertToAssets(vault2SharesOut);
    bytes[] memory argsForProofs = new bytes[](2);
    argsForProofs[0] = ISuperHookInspector(hooksAddresses[0]).inspect(hooksData[0]);
    argsForProofs[1] = ISuperHookInspector(hooksAddresses[1]).inspect(hooksData[1]);
    vm.startPrank(MANAGER);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(hooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    requestingUsers = _sortAndUniqueControllers(requestingUsers);
    uint256[] memory totalAssetsOut = calculateAdjustedFulfillment(strategy, requestingUsers, expectedAssetsOrSharesOut);
    strategy.fulfillRedeemRequests(requestingUsers, totalAssetsOut);
    vm.stopPrank();
}
```

### _convertSVStoUnderlyingShares(uint256,address,address)

- **Kind**: internal
- **Source**: 122265:805:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_convertSVStoUnderlyingShares(uint256,address,address)`

```solidity
function _convertSVStoUnderlyingShares(uint256 redeemShares, address vault1, address vault2) internal view returns (uint256 vault1SharesOut, uint256 vault2SharesOut) {
    console2.log("Redeem Shares", redeemShares);
    uint256 sharesAsAssetsFromSV = vault.convertToAssets(redeemShares);
    console2.log("Assets From SV", sharesAsAssetsFromSV);
    uint256 vault1Assets = sharesAsAssetsFromSV / 2;
    uint256 vault2Assets = sharesAsAssetsFromSV - vault1Assets;
    console2.log("Vault 1 assets", vault1Assets);
    console2.log("Vault 2 assets", vault2Assets);
    vault1SharesOut = IERC4626(vault1).previewWithdraw(vault1Assets);
    vault2SharesOut = IERC4626(vault2).previewWithdraw(vault2Assets);
}
```

### _truncateToActualBalance(uint256,address,uint256)

- **Kind**: internal
- **Source**: 124206:1588:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_truncateToActualBalance(uint256,address,uint256)`

```solidity
///  @notice Truncates expected underlying shares to actual balance if needed
///  @dev Reverts if actual balance is below the tolerance threshold
///  @param expectedShares The expected underlying vault shares
///  @param underlyingVault The underlying ERC4626 vault address
///  @param toleranceBps The tolerance in basis points (10000 = 100%)
///  @return adjustedShares The adjusted shares (truncated to balance if necessary)
function _truncateToActualBalance(uint256 expectedShares, address underlyingVault, uint256 toleranceBps) internal view returns (uint256 adjustedShares) {
    uint256 actualBalance = IERC20(underlyingVault).balanceOf(address(strategy));
    if (actualBalance >= expectedShares) {
        console2.log("no truncation of balance of shares");
        console2.log("---");
        return expectedShares;
    }
    uint256 minAcceptableBalance = (expectedShares * (10_000 - toleranceBps)) / 10_000;
    console2.log("vault", underlyingVault);
    console2.log("minAcceptableBalance", minAcceptableBalance);
    console2.log("actualBalance", actualBalance);
    if (actualBalance < minAcceptableBalance) {
        revert(string(abi.encodePacked("Vault balance too low: more than ", Strings.toString(toleranceBps), " bps below expected")));
    }
    uint256 truncatedValue = expectedShares - actualBalance;
    console2.log("truncated value", truncatedValue);
    console2.log("---");
    return actualBalance;
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

### toString(uint256)

- **Kind**: internal
- **Source**: 1308:634:56
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        assembly ("memory-safe") {
            ptr := add(add(buffer, 0x20), length)
        }
        while (true) {
            ptr--;
            assembly ("memory-safe") {
                mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 29154:916:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10 of a positive value rounded towards zero.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

### _createRedeem4626HookData(bytes32,address,address,uint256,bool)

- **Kind**: internal
- **Source**: 13305:360:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createRedeem4626HookData(bytes32,address,address,uint256,bool)`

```solidity
function _createRedeem4626HookData(bytes32 yieldSourceOracleId, address vault, address owner, uint256 shares, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, owner, shares, usePrevHookAmount);
}
```

### _sortAndUniqueControllers(address[])

- **Kind**: internal
- **Source**: 139422:377:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_sortAndUniqueControllers(address[])`

```solidity
/// @notice Helper function to sort controllers and ensure uniqueness for fulfillRedeemRequests
///  @param controllers Array of controller addresses to sort and deduplicate
///  @return sortedControllers Sorted and deduplicated array
function _sortAndUniqueControllers(address[] memory controllers) internal pure returns (address[] memory sortedControllers) {
    if (controllers.length == 0) return controllers;
    controllers.insertionSort();
    controllers.uniquifySorted();
    return controllers;
}
```

### insertionSort(address[])

- **Kind**: internal
- **Source**: 2133:100:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(address[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(address[] memory a) internal pure {
    insertionSort(_toUints(a));
}
```

### insertionSort(uint256[])

- **Kind**: internal
- **Source**: 840:1020:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(uint256[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(a)
        mstore(a, 0)
        let h := add(a, shl(5, n))
        let w := not(0x1f)
        for {
            let i := add(a, 0x20)
        } 1 {} {
            i := add(i, 0x20)
            if gt(i, h) {
                break
            }
            let k := mload(i)
            let j := add(i, w)
            let v := mload(j)
            if iszero(gt(v, k)) {
                continue
            }
            for {} 1 {} {
                mstore(add(j, 0x20), v)
                j := add(j, w)
                v := mload(j)
                if iszero(gt(v, k)) {
                    break
                }
            }
            mstore(add(j, 0x20), k)
        }
        mstore(a, n)
    }
}
```

### _toUints(address[])

- **Kind**: internal
- **Source**: 28279:415:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:_toUints(address[])`

```solidity
/// @dev Reinterpret cast to an uint256 array.
function _toUints(address[] memory a) private pure returns (uint256[] memory casted) {
    /// @solidity memory-safe-assembly
    assembly {
        casted := a
    }
}
```

### uniquifySorted(address[])

- **Kind**: internal
- **Source**: 9420:102:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(address[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(address[] memory a) internal pure {
    uniquifySorted(_toUints(a));
}
```

### uniquifySorted(uint256[])

- **Kind**: internal
- **Source**: 8425:722:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(uint256[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        if iszero(lt(mload(a), 2)) {
            let x := add(a, 0x20)
            let y := add(a, 0x40)
            let end := add(a, shl(5, add(mload(a), 1)))
            for {} 1 {} {
                if iszero(eq(mload(x), mload(y))) {
                    x := add(x, 0x20)
                    mstore(x, mload(y))
                }
                y := add(y, 0x20)
                if eq(y, end) {
                    break
                }
            }
            mstore(a, shr(5, sub(x, a)))
        }
    }
}
```

### calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])

- **Kind**: internal
- **Source**: 6811:1305:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])`

```solidity
///  @notice Complete workflow to calculate adjusted totalAssetsOut for fulfillRedeemRequests
///  @dev This function combines theoretical preview calculations with actual executeHooks
///       output to produce adjusted fulfillment amounts. This is the main function to use
///       when you need to fulfill redemption requests while accounting for execution losses.
///       Workflow:
///       1. Get theoretical net assets for all controllers via batch preview
///       2. Calculate total available assets from executeHooks output
///       3. Adjust theoretical amounts pro-rata to match available assets
///       4. Return adjusted array ready for fulfillRedeemRequests as totalAssetsOut
///       NOTE: The returned amounts represent totalAssetsOut (pre-fee) for fulfillRedeemRequests.
///       Fees are calculated and deducted internally based on full theoretical amounts,
///       ensuring fees are never reduced due to execution losses.
///  @param strategy The SuperVault strategy contract
///  @param controllers Sorted/unique controller addresses with pending redemptions
///  @param expectedAssetsFromHooks Array of assets expected from executeHooks (from expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Final totalAssetsOut array for fulfillRedeemRequests call (pre-fee amounts)
function calculateAdjustedFulfillment(ISuperVaultStrategy strategy, address[] memory controllers, uint256[] memory expectedAssetsFromHooks) internal view returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (expectedAssetsFromHooks.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    (uint256 totalTheoreticalAssets, uint256[] memory theoreticalAssets) = strategy.previewExactRedeemBatch(controllers);
    uint256 totalAvailableAssets = 0;
    for (uint256 i = 0; i < expectedAssetsFromHooks.length; i++) {
        console2.log("Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]);
        totalAvailableAssets += expectedAssetsFromHooks[i];
    }
    fulfillRedeemTotalAssetsOut = calculateFulfillRedeemTotalAssetsOut(controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets);
    return fulfillRedeemTotalAssetsOut;
}
```

### log(string,uint256,uint256)

- **Kind**: internal
- **Source**: 11745:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
}
```

### calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)

- **Kind**: internal
- **Source**: 2792:2430:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)`

```solidity
///  @notice Adjusts netAssetsOut arrays to match actual available assets from executeHooks
///  @dev This function handles the precision mismatch between theoretical fulfillment amounts
///       (calculated at current PPS) and actual assets obtained from executeHooks (which may
///       have rounding losses). The shortfall is distributed pro-rata based on each controller's
///       theoretical redemption amount.
///       Example scenario:
///       - Controller A: 800 theoretical assets (80% of total)
///       - Controller B: 200 theoretical assets (20% of total)
///       - Total theoretical: 1000 assets
///       - Available from hooks: 998 assets (2 wei loss)
///       - Adjusted A: 798.4 → 798 assets (1.6 wei loss)
///       - Adjusted B: 199.6 → 199 assets (0.4 wei loss)
///  @param controllers Array of controller addresses (must be sorted/unique)
///  @param theoreticalAssets Array of theoretical assets per controller from previewExactRedeem
///  @param totalTheoreticalAssets Total theoretical assets (sum of theoreticalAssets, from
///  previewExactRedeemBatch)
///  @param totalAvailableAssets Actual assets available from executeHooks (sum of expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Array adjusted to match available liquidity, sum <= totalAvailableAssets
function calculateFulfillRedeemTotalAssetsOut(address[] memory controllers, uint256[] memory theoreticalAssets, uint256 totalTheoreticalAssets, uint256 totalAvailableAssets) internal pure returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (theoreticalAssets.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    if (controllers.length != theoreticalAssets.length) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    fulfillRedeemTotalAssetsOut = new uint256[](controllers.length);
    if (totalTheoreticalAssets == 0) {
        revert ZERO_TOTAL_THEORETICAL();
    }
    if (totalAvailableAssets >= totalTheoreticalAssets) {
        return theoreticalAssets;
    }
    if (totalAvailableAssets > totalTheoreticalAssets) {
        revert INSUFFICIENT_AVAILABLE_ASSETS();
    }
    console2.log("Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets);
    uint256 totalAdjusted = 0;
    for (uint256 i = 0; i < theoreticalAssets.length; i++) {
        fulfillRedeemTotalAssetsOut[i] = theoreticalAssets[i].mulDiv(totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor);
        totalAdjusted += fulfillRedeemTotalAssetsOut[i];
    }
    uint256 remainder = totalAvailableAssets - totalAdjusted;
    if (remainder > 0) {
        console2.log("Remainder kept in vault as free assets:", remainder);
    }
    return fulfillRedeemTotalAssetsOut;
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

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
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

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
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

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
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

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
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

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
- **SuperVault::balanceOf(address)**
- **SuperVaultStrategy::getSuperVaultState(address)**
- **SuperVaultStrategy::pendingRedeemRequest(address)**
- **SuperVault::pendingRedeemRequest(uint256,address)**

## State Variable Reads

- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **accInstances** (`struct AccountInstance[]`)
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **currentChainId** (`uint256`)
- **accountEth** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_MultipleUsers_Redeem_From_Liquidity() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositForAllUsers(uint256) (NodeID: 1)
  │   💬 Args: [depositAmount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 2)
  │ │   💬 Args: [address(asset), accInstances[i].account, depositAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 3)
  │ │     💬 Args: [token_, to_, amount_]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 4)
  │ │       💬 Args: [token, to, give, false]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 5)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 6)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 7)
  │ │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 8)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 9)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 10)
  │ │     │     💬 Args: [self, who]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 11)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 12)
  │ │     │     💬 Args: [self, bytes32(amt)]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 13)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 14)
  │ │     │   │     💬 Args: [self._keys]
  │ │     │   │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 15)
  │ │     │   │   💬 Args: [self, false]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 16)
  │ │     │   │     💬 Args: [self, _clear]
  │ │     │   │     👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 17)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 18)
  │ │     │   │   │     💬 Args: [self._keys]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 19)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 20)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 21)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 22)
  │ │     │   │   │ │     💬 Args: [self._keys]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 23)
  │ │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 24)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 25)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 26)
  │ │     │   │   │ │ │   💬 Args: [self]
  │ │     │   │   │ │ │   👁️  Def: internal
  │ │     │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 27)
  │ │     │   │   │ │ │     💬 Args: [self._keys]
  │ │     │   │   │ │ │     👁️  Def: private
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 28)
  │ │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 29)
  │ │     │   │   │     💬 Args: [self]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 30)
  │ │     │   │   │   │   💬 Args: [self]
  │ │     │   │   │   │   👁️  Def: internal
  │ │     │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 31)
  │ │     │   │   │   │     💬 Args: [self._keys]
  │ │     │   │   │   │     👁️  Def: private
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 32)
  │ │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │       👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 33)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 34)
  │ │     │   │   │ │   💬 Args: [self, slot, true]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 35)
  │ │     │   │   │ │     💬 Args: [self]
  │ │     │   │   │ │     👁️  Def: internal
  │ │     │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 36)
  │ │     │   │   │ │   │   💬 Args: [self]
  │ │     │   │   │ │   │   👁️  Def: internal
  │ │     │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 37)
  │ │     │   │   │ │   │     💬 Args: [self._keys]
  │ │     │   │   │ │   │     👁️  Def: private
  │ │     │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 38)
  │ │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │       👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 39)
  │ │     │   │   │     💬 Args: [self, slot, false]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 40)
  │ │     │   │   │       💬 Args: [self]
  │ │     │   │   │       👁️  Def: internal
  │ │     │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 41)
  │ │     │   │   │     │   💬 Args: [self]
  │ │     │   │   │     │   👁️  Def: internal
  │ │     │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 42)
  │ │     │   │   │     │     💬 Args: [self._keys]
  │ │     │   │   │     │     👁️  Def: private
  │ │     │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 43)
  │ │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │         👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 44)
  │ │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 45)
  │ │     │   │       💬 Args: [self]
  │ │     │   │       👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 46)
  │ │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 47)
  │ │     │   │     💬 Args: [offsetLeft, offsetRight]
  │ │     │   │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 48)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 49)
  │ │     │   │ │   💬 Args: [self]
  │ │     │   │ │   👁️  Def: internal
  │ │     │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 50)
  │ │     │   │ │     💬 Args: [self._keys]
  │ │     │   │ │     👁️  Def: private
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 51)
  │ │     │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │     👁️  Def: private
  │ │     │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 52)
  │ │     │       💬 Args: [self]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 53)
  │ │     │         💬 Args: [self]
  │ │     │         👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 54)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 55)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 56)
  │ │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 57)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 58)
  │ │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 59)
  │ │           💬 Args: [self, bytes32(amt)]
  │ │           👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 60)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 61)
  │ │         │     💬 Args: [self._keys]
  │ │         │     👁️  Def: private
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 62)
  │ │         │   💬 Args: [self, false]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 63)
  │ │         │     💬 Args: [self, _clear]
  │ │         │     👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 64)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 65)
  │ │         │   │     💬 Args: [self._keys]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 66)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 67)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 68)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 69)
  │ │         │   │ │     💬 Args: [self._keys]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 70)
  │ │         │   │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 71)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 72)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 73)
  │ │         │   │ │ │   💬 Args: [self]
  │ │         │   │ │ │   👁️  Def: internal
  │ │         │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 74)
  │ │         │   │ │ │     💬 Args: [self._keys]
  │ │         │   │ │ │     👁️  Def: private
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 75)
  │ │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 76)
  │ │         │   │     💬 Args: [self]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 77)
  │ │         │   │   │   💬 Args: [self]
  │ │         │   │   │   👁️  Def: internal
  │ │         │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 78)
  │ │         │   │   │     💬 Args: [self._keys]
  │ │         │   │   │     👁️  Def: private
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 79)
  │ │         │   │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │       👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 80)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 81)
  │ │         │   │ │   💬 Args: [self, slot, true]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 82)
  │ │         │   │ │     💬 Args: [self]
  │ │         │   │ │     👁️  Def: internal
  │ │         │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 83)
  │ │         │   │ │   │   💬 Args: [self]
  │ │         │   │ │   │   👁️  Def: internal
  │ │         │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 84)
  │ │         │   │ │   │     💬 Args: [self._keys]
  │ │         │   │ │   │     👁️  Def: private
  │ │         │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 85)
  │ │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │       👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 86)
  │ │         │   │     💬 Args: [self, slot, false]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 87)
  │ │         │   │       💬 Args: [self]
  │ │         │   │       👁️  Def: internal
  │ │         │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 88)
  │ │         │   │     │   💬 Args: [self]
  │ │         │   │     │   👁️  Def: internal
  │ │         │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 89)
  │ │         │   │     │     💬 Args: [self._keys]
  │ │         │   │     │     👁️  Def: private
  │ │         │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 90)
  │ │         │   │         💬 Args: [rdat, 32 * self._depth]
  │ │         │   │         👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 91)
  │ │         │   │   💬 Args: [offsetLeft, offsetRight]
  │ │         │   │   👁️  Def: internal
  │ │         │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 92)
  │ │         │       💬 Args: [self]
  │ │         │       👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 93)
  │ │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 94)
  │ │         │     💬 Args: [offsetLeft, offsetRight]
  │ │         │     👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 95)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 96)
  │ │         │ │   💬 Args: [self]
  │ │         │ │   👁️  Def: internal
  │ │         │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 97)
  │ │         │ │     💬 Args: [self._keys]
  │ │         │ │     👁️  Def: private
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 98)
  │ │         │     💬 Args: [rdat, 32 * self._depth]
  │ │         │     👁️  Def: private
  │ │         └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 99)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ │           └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 100)
  │ │               💬 Args: [self]
  │ │               👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositForAccount(struct AccountInstance,uint256) (NodeID: 101)
  │     💬 Args: [accInstances[i], depositAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256) (NodeID: 102)
  │       💬 Args: [accInst, depositAmount]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 103)
  │     │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 104)
  │     │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 105)
  │     │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 106)
  │     │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 107)
  │     │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 108)
  │         💬 Args: [userOpData]
  │         👁️  Def: public
  │       └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 109)
  │           💬 Args: [userOpData]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 110)
  │             💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 111)
  │               💬 Args: [userOps, onEntryPoint]
  │               👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 112)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 113)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 114)
  │             │   💬 Args: ["SIMULATE", false]
  │             │   👁️  Def: public
  │             ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 115)
  │             │   💬 Args: [userOps[0], address(onEntryPoint)]
  │             │   👁️  Def: internal
  │             │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 116)
  │             │ │   💬 Args: [no args]
  │             │ │   👁️  Def: internal
  │             │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 117)
  │             │ │ │   💬 Args: [no args]
  │             │ │ │   👁️  Def: internal
  │             │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 118)
  │             │ │ │   💬 Args: [no args]
  │             │ │ │   👁️  Def: internal
  │             │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 119)
  │             │ │     💬 Args: [no args]
  │             │ │     👁️  Def: internal
  │             │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 120)
  │             │     💬 Args: [userOpDetails]
  │             │     👁️  Def: internal
  │             │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 121)
  │             │   │   💬 Args: [no args]
  │             │   │   👁️  Def: internal
  │             │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 122)
  │             │   │   💬 Args: [userOpDetails, debugTrace]
  │             │   │   👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 123)
  │             │   │ │   💬 Args: [userOpDetails]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 124)
  │             │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 125)
  │             │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 126)
  │             │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 127)
  │             │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │             │   │ │   👁️  Def: private
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 128)
  │             │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 129)
  │             │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │             │   │ │ │   👁️  Def: private
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 130)
  │             │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 131)
  │             │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 132)
  │             │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │             │   │ │ │   👁️  Def: private
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 133)
  │             │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 134)
  │             │   │ │   💬 Args: [filteredUserOpSteps]
  │             │   │ │   👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 135)
  │             │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │             │   │ │   👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 136)
  │             │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 137)
  │             │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 138)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 139)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 140)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 141)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 142)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 143)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 144)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 145)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 146)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 147)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 148)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 149)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 150)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 151)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 152)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 153)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 154)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 155)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 156)
  │             │   │ │     💬 Args: [currentAccessAccount]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 157)
  │             │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 158)
  │             │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 159)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 160)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 161)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 162)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 163)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 164)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 165)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 166)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 167)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 168)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 169)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 170)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 171)
  │             │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │             │   │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 172)
  │             │   │ │ │ │   💬 Args: [currentSlot, entity]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 173)
  │             │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 174)
  │             │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │             │   │ │ │ │ │   👁️  Def: internal
  │             │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 175)
  │             │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │             │   │ │ │ │     👁️  Def: internal
  │             │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 176)
  │             │   │ │ │     💬 Args: [key, entity]
  │             │   │ │ │     👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 177)
  │             │   │ │     💬 Args: [currentAccessAccount]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 178)
  │             │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 179)
  │             │   │ │     💬 Args: [targetAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 180)
  │             │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 181)
  │             │   │ │     💬 Args: [targetAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 182)
  │             │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 183)
  │             │   │ │     💬 Args: [targetAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 184)
  │             │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │             │   │ │   👁️  Def: internal
  │             │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 185)
  │             │   │ │     💬 Args: [targetAddr]
  │             │   │ │     👁️  Def: internal
  │             │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 186)
  │             │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │             │   │ │   👁️  Def: internal
  │             │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 187)
  │             │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │             │   │     👁️  Def: internal
  │             │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 188)
  │             │   │   💬 Args: [no args]
  │             │   │   👁️  Def: internal
  │             │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 189)
  │             │       💬 Args: [snapShotId]
  │             │       👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 190)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 191)
  │             │   💬 Args: [ctx.returnData]
  │             │   👁️  Def: internal
  │             │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 192)
  │             │ │   💬 Args: [no args]
  │             │ │   👁️  Def: internal
  │             │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 193)
  │             │     💬 Args: [actualReason, revertMessage]
  │             │     👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 194)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 195)
  │             │   💬 Args: [logs, userOpHash]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 196)
  │             │   💬 Args: [account]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 197)
  │             │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │             │   👁️  Def: internal
  │             │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 200)
  │             │ │   💬 Args: [logs, userOpHash]
  │             │ │   👁️  Def: internal
  │             │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 198)
  │             │ │   💬 Args: [no args]
  │             │ │   👁️  Def: internal
  │             │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 199)
  │             │     💬 Args: [actualReason, revertMessage]
  │             │     👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 201)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 202)
  │             │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 203)
  │             │   💬 Args: [logs[i].emitter]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 204)
  │             │   💬 Args: [j, logs[i].emitter]
  │             │   👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 205)
  │             │   💬 Args: [no args]
  │             │   👁️  Def: internal
  │             │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 206)
  │             │     💬 Args: [slot]
  │             │     👁️  Def: internal
  │             ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 207)
  │             │   💬 Args: ["GAS", false]
  │             │   👁️  Def: public
  │             └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 208)
  │                 💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │                 👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 209)
  │                   💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                   👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 210)
  │                 │   💬 Args: [userOpCalldata]
  │                 │   👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 211)
  │                 │ │   💬 Args: [data]
  │                 │ │   👁️  Def: internal
  │                 │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 212)
  │                 │     💬 Args: [compressed]
  │                 │     👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 213)
  │                 │   💬 Args: [userOpCalldata]
  │                 │   👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 214)
  │                 │ │   💬 Args: [0.684e18]
  │                 │ │   👁️  Def: internal
  │                 │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 215)
  │                 │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │                 │     👁️  Def: internal
  │                 │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 216)
  │                 │   │   💬 Args: [getCallDataGas(data)]
  │                 │   │   👁️  Def: internal
  │                 │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 217)
  │                 │   │     💬 Args: [data]
  │                 │   │     👁️  Def: internal
  │                 │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 218)
  │                 │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │                 │       👁️  Def: internal
  │                 │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 219)
  │                 │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │                 │         👁️  Def: internal
  │                 │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 220)
  │                 │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │                 │           👁️  Def: internal
  │                 │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 221)
  │                 │         │   💬 Args: [x]
  │                 │         │   👁️  Def: internal
  │                 │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 222)
  │                 │             💬 Args: [y]
  │                 │             👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 223)
  │                 │   💬 Args: [fileName]
  │                 │   👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 224)
  │                 │   💬 Args: [fileName]
  │                 │   👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 225)
  │                 │   💬 Args: [fileContent]
  │                 │   👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 226)
  │                 │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 227)
  │                 │ │     💬 Args: [fileContent, ".Total"]
  │                 │ │     👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 228)
  │                 │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 229)
  │                 │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │                 │ │     👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 230)
  │                 │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 231)
  │                 │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │                 │ │     👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 232)
  │                 │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 233)
  │                 │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │                 │ │     👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 234)
  │                 │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 235)
  │                 │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │                 │ │     👁️  Def: internal
  │                 │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 236)
  │                 │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │                 │     👁️  Def: internal
  │                 │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 237)
  │                 │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │                 │       👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 238)
  │                 │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │                 │   👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 239)
  │                 │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 240)
  │                 │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 241)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 242)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 243)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 244)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 245)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 246)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 247)
  │                 │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 248)
  │                 │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 249)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 250)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 251)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 252)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 253)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 254)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 255)
  │                 │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 256)
  │                 │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 257)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 258)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 259)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 260)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 261)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 262)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 263)
  │                 │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 264)
  │                 │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 265)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 266)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 267)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 268)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 269)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 270)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 271)
  │                 │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 272)
  │                 │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 273)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 274)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 275)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 276)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 277)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 278)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 279)
  │                 │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │                 │ │   👁️  Def: internal
  │                 │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 280)
  │                 │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │                 │ │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 281)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 282)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 283)
  │                 │ │   │   💬 Args: [int256(newValue)]
  │                 │ │   │   👁️  Def: internal
  │                 │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 284)
  │                 │ │   │     💬 Args: [value]
  │                 │ │   │     👁️  Def: internal
  │                 │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 285)
  │                 │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │                 │ │       👁️  Def: internal
  │                 │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 286)
  │                 │ │         💬 Args: [value]
  │                 │ │         👁️  Def: internal
  │                 │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 287)
  │                 │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │                 │ │   👁️  Def: internal
  │                 │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 288)
  │                 │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │                 │     👁️  Def: internal
  │                 ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 289)
  │                 │   💬 Args: [finalJson, fileName]
  │                 │   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 290)
  │                     💬 Args: [""]
  │                     👁️  Def: internal
  │                   └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 291)
  │                       💬 Args: [slot, id]
  │                       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssets(uint256,uint256,address,address) (NodeID: 292)
  │   💬 Args: [strategyAssetBalance / 2, strategyAssetBalance / 2, address(fluidVault), address(aaveVault)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 293)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 294)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 295)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 296)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 297)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 298)
  │     💬 Args: [fulfillHooksAddresses, argsForProofs]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._requestRedeemForAccount(struct AccountInstance,uint256) (NodeID: 299)
  │   💬 Args: [accInstances[i], redeemShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__requestRedeem(struct AccountInstance,uint256,bool) (NodeID: 300)
  │     💬 Args: [accInst, redeemShares, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 301)
  │   │   💬 Args: [ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool) (NodeID: 302)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), redeemShares, false]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 303)
  │   │     💬 Args: [bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 304)
  │   │   💬 Args: ["__requestRedeem ------ redeemShares", redeemShares]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 305)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 306)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 307)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(redeemEntry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 308)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.expect4337Revert(struct AccountInstance) (NodeID: 309)
  │   │   💬 Args: [accInst]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.writeExpectRevert(bytes) (NodeID: 310)
  │   │     💬 Args: [""]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 311)
  │       💬 Args: [redeemUserOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 312)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 313)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 314)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 315)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 316)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 317)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 318)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 319)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 320)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 321)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 322)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 323)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 324)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 325)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 326)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 327)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 328)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 329)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 330)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 331)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 332)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 333)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 334)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 335)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 336)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 337)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 338)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 339)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 340)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 341)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 342)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 343)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 344)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 345)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 346)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 347)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 348)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 349)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 350)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 351)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 352)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 353)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 354)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 355)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 356)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 357)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 358)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 359)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 360)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 361)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 362)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 363)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 364)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 365)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 366)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 367)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 368)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 369)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 370)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 371)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 372)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 373)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 374)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 375)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 376)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 377)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 378)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 379)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 380)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 381)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 382)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 383)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 384)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 385)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 386)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 387)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 388)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 389)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 390)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 391)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 392)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 393)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 394)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 395)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 396)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 397)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 398)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 399)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 400)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 403)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 401)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 402)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 404)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 405)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 406)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 407)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 408)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 409)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 410)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 411)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 412)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 413)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 414)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 415)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 416)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 417)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 418)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 419)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 420)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 421)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 422)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 423)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 424)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 425)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 426)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 427)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 428)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 429)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 430)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 431)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 432)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 433)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 434)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 435)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 436)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 437)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 438)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 439)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 440)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 441)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 442)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 443)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 444)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 445)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 446)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 447)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 448)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 449)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 450)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 451)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 452)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 453)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 454)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 455)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 456)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 457)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 458)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 459)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 460)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 461)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 462)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 463)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 464)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 465)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 466)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 467)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 468)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 469)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 470)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 471)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 472)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 473)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 474)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 475)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 476)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 477)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 478)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 479)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 480)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 481)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 482)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 483)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 484)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 485)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 486)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 487)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 488)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 489)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 490)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 491)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 492)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 493)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 494)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._executeRedeemHooks4626(uint256,address,address,address[]) (NodeID: 495)
  │   💬 Args: [totalRedeemShares, address(fluidVault), address(aaveVault), requestingUsers]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 496)
  │ │   💬 Args: [ETH, REDEEM_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 497)
  │ │   💬 Args: [ETH, REDEEM_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._convertSVStoUnderlyingShares(uint256,address,address) (NodeID: 498)
  │ │   💬 Args: [redeemShares, vault1, vault2]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 499)
  │ │ │   💬 Args: ["Redeem Shares", redeemShares]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 500)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 501)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 502)
  │ │ │   💬 Args: ["Assets From SV", sharesAsAssetsFromSV]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 503)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 504)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 505)
  │ │ │   💬 Args: ["Vault 1 assets", vault1Assets]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 506)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 507)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 508)
  │ │     💬 Args: ["Vault 2 assets", vault2Assets]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 509)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 510)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 511)
  │ │   💬 Args: [vault1SharesOut, vault1, 100]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 512)
  │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 513)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 514)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 515)
  │ │ │   💬 Args: ["---"]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 516)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 517)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,address) (NodeID: 518)
  │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 519)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 520)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 521)
  │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 522)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 523)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 524)
  │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 525)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 526)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 527)
  │ │ │   💬 Args: [toleranceBps]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 528)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 529)
  │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 530)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 531)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 532)
  │ │     💬 Args: ["---"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 533)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 534)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 535)
  │ │   💬 Args: [vault2SharesOut, vault2, 100]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 536)
  │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 537)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 538)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 539)
  │ │ │   💬 Args: ["---"]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 540)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 541)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,address) (NodeID: 542)
  │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 543)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 544)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 545)
  │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 546)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 547)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 548)
  │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 549)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 550)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 551)
  │ │ │   💬 Args: [toleranceBps]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 552)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 553)
  │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 554)
  │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 555)
  │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 556)
  │ │     💬 Args: ["---"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 557)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 558)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 559)
  │ │   💬 Args: ["Vault 1 Shares Out", vault1SharesOut]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 560)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 561)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 562)
  │ │   💬 Args: ["Vault 2 Shares Out", vault2SharesOut]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 563)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 564)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 565)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(strategy), vault1SharesOut, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 566)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 567)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(strategy), vault2SharesOut, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 568)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 569)
  │ │   💬 Args: [hooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._sortAndUniqueControllers(address[]) (NodeID: 570)
  │ │   💬 Args: [requestingUsers]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 571)
  │ │ │   💬 Args: [controllers]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 572)
  │ │ │     💬 Args: [_toUints(a)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 573)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 574)
  │ │     💬 Args: [controllers]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 575)
  │ │       💬 Args: [_toUints(a)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 576)
  │ │         💬 Args: [a]
  │ │         👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[]) (NodeID: 577)
  │     💬 Args: [strategy, requestingUsers, expectedAssetsOrSharesOut]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 578)
  │   │   💬 Args: ["Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 579)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 580)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 581)
  │       💬 Args: [controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 582)
  │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 583)
  │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 584)
  │     │       💬 Args: [_sendLogPayloadView]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 585)
  │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 586)
  │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 587)
  │     │ │     💬 Args: [rounding]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 588)
  │     │     💬 Args: [x, y, denominator]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 589)
  │     │   │   💬 Args: [x, y]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 590)
  │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 591)
  │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │     │         👁️  Def: internal
  │     │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 592)
  │     │           💬 Args: [condition]
  │     │           👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 593)
  │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 594)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 595)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 596)
  │   💬 Args: [finalState.pendingRedeemRequest, 0, "Pending redeem request not cleared for user"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 597)
  │   💬 Args: [finalState.averageRequestPPS, 0, "Average request PPS not cleared for user"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 598)
  │   💬 Args: [strategy.pendingRedeemRequest(user), 0, "Pending redeem request still exists for user"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 599)
  │   💬 Args: [vault.pendingRedeemRequest(0, user), 0, "ERC7540 pending redeem not cleared for user"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 600)
      💬 Args: [finalState.maxWithdraw, 0, "User should have claimable assets after fulfillment"]
      👁️  Def: internal
```
