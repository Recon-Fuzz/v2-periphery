# Function: test_Bridge_MintSP()

**Contract**: [test/draft/test/integration/VaultBank/VaultBankCrosschainTests.sol/contract_VaultBankCrosschainTests.md]

## Metadata

- **Contract**: VaultBankCrosschainTests
- **Signature**: `test_Bridge_MintSP()`
- **Visibility**: public
- **Source Range**: 10397:5694:566

## Implementation

```solidity
function test_Bridge_MintSP() public {
    uint256 safeTimestamp = 1_740_570_000;
    SELECT_FORK_AND_WARP(ETH, safeTimestamp);
    uint256 amount = 1e3;
    uint256 previewRedeemAmount = vaultInstanceMorphoEth.previewRedeem(vaultInstanceMorphoEth.previewDeposit(amount));
    SELECT_FORK_AND_WARP(BASE, safeTimestamp);
    superGovernor = SuperGovernor(payable(VmContractHelper530(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(address(this), address(this), address(this), address(this), address(this), address(this), address(this), false))})));
    superRegistry = new SuperRegistry(address(superGovernor), address(this), address(this));
    vaultBank = new VaultBank(address(superGovernor), address(superRegistry));
    superRegistry.addVaultBank(ETH, address(vaultBank));
    superGovernor.registerHook(_getHookAddress(BASE, MINT_SUPERPOSITIONS_HOOK_KEY));
    bytes memory targetExecutorMessage;
    TargetExecutorMessage memory messageData;
    address accountToUse;
    {
        address[] memory dstHooksAddresses = new address[](1);
        dstHooksAddresses[0] = _getHookAddress(BASE, MINT_SUPERPOSITIONS_HOOK_KEY);
        bytes[] memory dstHooksData = new bytes[](1);
        dstHooksData[0] = _createApproveAndLockVaultBankHookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), CHAIN_8453_USDC, previewRedeemAmount, false, address(vaultBank), ETH);
        messageData = TargetExecutorMessage({hooksAddresses: dstHooksAddresses, hooksData: dstHooksData, validator: address(validatorOnBase), signer: validatorSigners[BASE], signerPrivateKey: validatorSignerPrivateKeys[BASE], targetAdapter: address(acrossV3AdapterOnBase), targetExecutor: address(superTargetExecutorOnBase), nexusFactory: CHAIN_8453_NEXUS_FACTORY, nexusBootstrap: CHAIN_8453_NEXUS_BOOTSTRAP, chainId: uint64(BASE), amount: amount, account: accountBase, tokenSent: underlyingBase_USDC});
        (targetExecutorMessage, accountToUse) = _createTargetExecutorMessage(messageData, false);
    }
    _getTokens(CHAIN_8453_USDC, accountToUse, amount);
    SELECT_FORK_AND_WARP(ETH, safeTimestamp);
    address[] memory srcHooksAddresses = new address[](4);
    srcHooksAddresses[0] = _getHookAddress(ETH, APPROVE_ERC20_HOOK_KEY);
    srcHooksAddresses[1] = _getHookAddress(ETH, DEPOSIT_4626_VAULT_HOOK_KEY);
    srcHooksAddresses[2] = _getHookAddress(ETH, APPROVE_ERC20_HOOK_KEY);
    srcHooksAddresses[3] = _getHookAddress(ETH, ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY);
    bytes[] memory srcHooksData = new bytes[](4);
    srcHooksData[0] = _createApproveHookData(underlyingETH_USDC, yieldSourceMorphoUsdcAddressEth, amount, false);
    srcHooksData[1] = _createDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), yieldSourceMorphoUsdcAddressEth, amount, false, address(0), 0);
    srcHooksData[2] = _createApproveHookData(underlyingETH_USDC, SPOKE_POOL_V3_ADDRESSES[ETH], 0, true);
    srcHooksData[3] = _createAcrossV3ReceiveFundsAndExecuteHookData(existingUnderlyingTokens[ETH][USDC_KEY], existingUnderlyingTokens[BASE][USDC_KEY], previewRedeemAmount, previewRedeemAmount, BASE, true, targetExecutorMessage);
    ISuperExecutor.ExecutorEntry memory entry = ISuperExecutor.ExecutorEntry({hooksAddresses: srcHooksAddresses, hooksData: srcHooksData});
    UserOpData memory srcUserOpData = _getExecOpsWithValidator(instanceOnETH, superExecutorOnETH, abi.encode(entry), address(sourceValidatorOnETH));
    bytes memory signatureData = _createMerkleRootAndSignature(messageData, srcUserOpData.userOpHash, accountToUse, BASE, address(sourceValidatorOnETH));
    srcUserOpData.userOp.signature = signatureData;
    _processAcrossV3Message(ProcessAcrossV3MessageParams({srcChainId: ETH, dstChainId: BASE, warpTimestamp: safeTimestamp, executionData: executeOp(srcUserOpData), relayerType: RELAYER_TYPE.ENOUGH_BALANCE, errorMessage: bytes4(0), errorReason: "", root: bytes32(0), account: accountBase, relayerGas: 0}));
    SELECT_FORK_AND_WARP(BASE, safeTimestamp + 10 days);
    uint256 accSharesAfter = IERC4626(CHAIN_8453_USDC).balanceOf(address(vaultBank));
    assertEq(accSharesAfter, previewRedeemAmount);
}
```

## Related Implementations

### SELECT_FORK_AND_WARP(uint64,uint256)

- **Kind**: internal
- **Source**: 18692:148:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:SELECT_FORK_AND_WARP(uint64,uint256)`

```solidity
/// @notice Helper function to select a fork and warp to a specific timestamp
///  @param chainId The chain ID to select
///  @param timestamp The timestamp to warp to
function SELECT_FORK_AND_WARP(uint64 chainId, uint256 timestamp) internal {
    vm.selectFork(FORKS[chainId]);
    vm.warp(timestamp);
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

### _createApproveAndLockVaultBankHookData(bytes32,address,uint256,bool,address,uint256)

- **Kind**: internal
- **Source**: 11489:425:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveAndLockVaultBankHookData(bytes32,address,uint256,bool,address,uint256)`

```solidity
function _createApproveAndLockVaultBankHookData(bytes32 yieldSourceOracleId, address spToken, uint256 amount, bool usePrevHookAmount, address vaultBank, uint256 dstChainId) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, spToken, amount, usePrevHookAmount, vaultBank, dstChainId);
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

### _createTargetExecutorMessage(struct BaseTest.TargetExecutorMessage,bool)

- **Kind**: internal
- **Source**: 90483:2080:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createTargetExecutorMessage(struct BaseTest.TargetExecutorMessage,bool)`

```solidity
function _createTargetExecutorMessage(TargetExecutorMessage memory messageData, bool is7702) internal view returns (bytes memory, address) {
    bytes memory executionData = _createCrosschainExecutionData_DestinationExecutor(messageData.hooksAddresses, messageData.hooksData);
    console2.log("-------------- is7702", is7702);
    address accountToUse;
    bytes memory accountCreationData;
    if (messageData.account == address(0)) {
        (accountCreationData, accountToUse) = _createAccountCreationData_DestinationExecutor(AccountCreationParams({senderCreatorOnDestinationChain: is7702 ? _getContract(messageData.chainId, SUPER_7702_SENDER_CREATOR_KEY) : _getContract(messageData.chainId, SUPER_SENDER_CREATOR_KEY), validatorOnDestinationChain: messageData.validator, superMerkleValidator: _getContract(messageData.chainId, SUPER_MERKLE_VALIDATOR_KEY), theSigner: messageData.signer, executorOnDestinationChain: _getContract(messageData.chainId, SUPER_DESTINATION_EXECUTOR_KEY), superExecutor: _getContract(messageData.chainId, SUPER_EXECUTOR_KEY), nexusFactory: messageData.nexusFactory, nexusBootstrap: messageData.nexusBootstrap, is7702: is7702}));
        messageData.account = accountToUse;
    } else {
        accountToUse = messageData.account;
        accountCreationData = bytes("");
    }
    address[] memory dstTokens = new address[](1);
    dstTokens[0] = messageData.tokenSent;
    uint256[] memory intentAmounts = new uint256[](1);
    intentAmounts[0] = messageData.amount;
    return (abi.encode(accountCreationData, executionData, messageData.account, dstTokens, intentAmounts), accountToUse);
}
```

### _createCrosschainExecutionData_DestinationExecutor(address[],bytes[])

- **Kind**: internal
- **Source**: 101965:474:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createCrosschainExecutionData_DestinationExecutor(address[],bytes[])`

```solidity
function _createCrosschainExecutionData_DestinationExecutor(address[] memory hooksAddresses, bytes[] memory hooksData) internal pure returns (bytes memory) {
    ISuperExecutor.ExecutorEntry memory entryToExecute = ISuperExecutor.ExecutorEntry({hooksAddresses: hooksAddresses, hooksData: hooksData});
    return abi.encodeWithSelector(ISuperExecutor.execute.selector, abi.encode(entryToExecute));
}
```

### log(string,bool)

- **Kind**: internal
- **Source**: 7595:139:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,bool)`

```solidity
function log(string memory p0, bool p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
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

### _createAccountCreationData_DestinationExecutor(struct BaseTest.AccountCreationParams)

- **Kind**: internal
- **Source**: 102804:233:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createAccountCreationData_DestinationExecutor(struct BaseTest.AccountCreationParams)`

```solidity
function _createAccountCreationData_DestinationExecutor(AccountCreationParams memory p) virtual internal view returns (bytes memory, address) {
    return __createNon7702NexusInitData(p);
}
```

### _getContract(uint64,string)

- **Kind**: internal
- **Source**: 20955:162:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getContract(uint64,string)`

```solidity
function _getContract(uint64 chainId, string memory contractName) internal view returns (address) {
    return contractAddresses[chainId][contractName];
}
```

### __createNon7702NexusInitData(struct BaseTest.AccountCreationParams)

- **Kind**: internal
- **Source**: 103043:1765:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:__createNon7702NexusInitData(struct BaseTest.AccountCreationParams)`

```solidity
function __createNon7702NexusInitData(AccountCreationParams memory p) internal view returns (bytes memory, address) {
    BootstrapConfig[] memory validators = new BootstrapConfig[](2);
    validators[0] = BootstrapConfig({module: p.validatorOnDestinationChain, data: abi.encode(p.theSigner)});
    validators[1] = BootstrapConfig({module: p.superMerkleValidator, data: abi.encode(p.theSigner)});
    BootstrapConfig[] memory executors = new BootstrapConfig[](2);
    executors[0] = BootstrapConfig({module: p.executorOnDestinationChain, data: ""});
    executors[1] = BootstrapConfig({module: p.superExecutor, data: ""});
    BootstrapConfig memory hook = BootstrapConfig({module: address(0), data: ""});
    BootstrapConfig[] memory fallbacks = new BootstrapConfig[](0);
    address[] memory attesters = new address[](1);
    attesters[0] = address(MANAGER);
    uint8 threshold = 1;
    bytes memory initData = INexusBootstrap(p.nexusBootstrap).getInitNexusCalldata(validators, executors, hook, fallbacks, IERC7484(mockRegistry), attesters, threshold);
    bytes32 initSalt = bytes32(keccak256("SIGNER_SALT"));
    address precomputedAddress = INexusFactory(p.nexusFactory).computeAccountAddress(initData, initSalt);
    bytes memory initFactoryCalldata = abi.encodeWithSelector(INexusFactory.createAccount.selector, initData, initSalt);
    return (abi.encodePacked(p.senderCreatorOnDestinationChain, address(p.nexusFactory), initFactoryCalldata), precomputedAddress);
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

### _createApproveHookData(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 11180:303:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveHookData(address,address,uint256,bool)`

```solidity
function _createApproveHookData(address token, address spender, uint256 amount, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(token, spender, amount, usePrevHookAmount);
}
```

### _createDeposit4626HookData(bytes32,address,uint256,bool,address,uint256)

- **Kind**: internal
- **Source**: 11920:409:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createDeposit4626HookData(bytes32,address,uint256,bool,address,uint256)`

```solidity
function _createDeposit4626HookData(bytes32 yieldSourceOracleId, address vault, uint256 amount, bool usePrevHookAmount, address vaultBank, uint256 dstChainId) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, amount, usePrevHookAmount, vaultBank, dstChainId);
}
```

### _createAcrossV3ReceiveFundsAndExecuteHookData(address,address,uint256,uint256,uint64,bool,bytes)

- **Kind**: internal
- **Source**: 106376:797:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createAcrossV3ReceiveFundsAndExecuteHookData(address,address,uint256,uint256,uint64,bool,bytes)`

```solidity
function _createAcrossV3ReceiveFundsAndExecuteHookData(address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint64 destinationChainId, bool usePrevHookAmount, bytes memory data) internal view returns (bytes memory hookData) {
    hookData = abi.encodePacked(uint256(0), _getContract(destinationChainId, ACROSS_V3_ADAPTER_KEY), inputToken, outputToken, inputAmount, outputAmount, uint256(destinationChainId), address(0), uint32(10 minutes), uint32(0), usePrevHookAmount, data);
}
```

### _getExecOpsWithValidator(struct AccountInstance,contract ISuperExecutor,bytes,address)

- **Kind**: internal
- **Source**: 3049:369:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getExecOpsWithValidator(struct AccountInstance,contract ISuperExecutor,bytes,address)`

```solidity
function _getExecOpsWithValidator(AccountInstance memory instance, ISuperExecutor superExecutor, bytes memory data, address validator) internal returns (UserOpData memory userOpData) {
    return instance.getExecOps(address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), validator);
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

### _createMerkleRootAndSignature(struct BaseTest.TargetExecutorMessage,bytes32,address,uint64,address)

- **Kind**: internal
- **Source**: 94737:2515:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createMerkleRootAndSignature(struct BaseTest.TargetExecutorMessage,bytes32,address,uint64,address)`

```solidity
function _createMerkleRootAndSignature(TargetExecutorMessage memory messageData, bytes32 userOpHash, address accountToUse, uint64 dstChainId, address srcValidator) internal view returns (bytes memory sig) {
    MerkleContext memory ctx;
    ctx.validUntil = uint48(block.timestamp + 100 days);
    ctx.executionData = _createCrosschainExecutionData_DestinationExecutor(messageData.hooksAddresses, messageData.hooksData);
    ctx.leaves = new bytes32[](2);
    ctx.dstTokens = new address[](1);
    ctx.dstTokens[0] = messageData.tokenSent;
    ctx.intentAmounts = new uint256[](1);
    ctx.intentAmounts[0] = messageData.amount;
    ctx.leaves[0] = _createDestinationValidatorLeaf(ctx.executionData, messageData.chainId, accountToUse, messageData.targetExecutor, ctx.dstTokens, ctx.intentAmounts, ctx.validUntil, messageData.validator);
    uint64[] memory chainsForLeaf = new uint64[](1);
    chainsForLeaf[0] = dstChainId;
    ctx.leaves[1] = _createSourceValidatorLeaf(userOpHash, ctx.validUntil, 0, chainsForLeaf, srcValidator);
    (ctx.merkleProof, ctx.merkleRoot) = _createValidatorMerkleTree(ctx.leaves);
    ctx.signature = _createSignature(SuperValidatorBase(address(messageData.validator)).namespace(), ctx.merkleRoot, messageData.signer, messageData.signerPrivateKey);
    ISuperValidator.DstProof[] memory proofDst = new ISuperValidator.DstProof[](1);
    ISuperValidator.DstInfo memory dstInfo = ISuperValidator.DstInfo({data: ctx.executionData, executor: messageData.targetExecutor, dstTokens: ctx.dstTokens, intentAmounts: ctx.intentAmounts, account: accountToUse, validator: messageData.validator});
    proofDst[0] = ISuperValidator.DstProof({proof: ctx.merkleProof[0], dstChainId: dstChainId, info: dstInfo});
    console2.logBytes32(ctx.merkleRoot);
    uint64[] memory chainsWithDestinationExecution = new uint64[](1);
    chainsWithDestinationExecution[0] = dstChainId;
    sig = _createSignatureData_DestinationExecutorWithChains(chainsWithDestinationExecution, ctx.validUntil, ctx.merkleRoot, ctx.merkleProof[1], proofDst, ctx.signature);
}
```

### _createDestinationValidatorLeaf(bytes,uint64,address,address,address[],uint256[],uint48,address)

- **Kind**: internal
- **Source**: 2118:654:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_createDestinationValidatorLeaf(bytes,uint64,address,address,address[],uint256[],uint48,address)`

```solidity
function _createDestinationValidatorLeaf(bytes memory executionData, uint64 dstChainId, address account, address executor, address[] memory dstTokens, uint256[] memory intentAmounts, uint48 validUntil, address _validator) internal pure returns (bytes32) {
    return keccak256(bytes.concat(keccak256(abi.encode(executionData, dstChainId, account, executor, dstTokens, intentAmounts, validUntil, _validator))));
}
```

### _createSourceValidatorLeaf(bytes32,uint48,uint48,uint64[],address)

- **Kind**: internal
- **Source**: 1447:468:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_createSourceValidatorLeaf(bytes32,uint48,uint48,uint64[],address)`

```solidity
function _createSourceValidatorLeaf(bytes32 userOpHash, uint48 validUntil, uint48 validAfter, uint64[] memory chainsWithDestinationExecution, address validator) internal pure returns (bytes32) {
    return keccak256(bytes.concat(keccak256(abi.encode(userOpHash, validUntil, validAfter, chainsWithDestinationExecution, validator))));
}
```

### _createValidatorMerkleTree(bytes32[])

- **Kind**: internal
- **Source**: 3159:1538:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_createValidatorMerkleTree(bytes32[])`

```solidity
function _createValidatorMerkleTree(bytes32[] memory leaves) internal pure returns (bytes32[][] memory proof, bytes32 root) {
    require(leaves.length > 0, "At least one leaf required");
    uint256 n = leaves.length;
    while ((n & (n - 1)) != 0) {
        n++;
    }
    bytes32[] memory nodes = new bytes32[](n);
    for (uint256 i = 0; i < leaves.length; i++) {
        nodes[i] = leaves[i];
    }
    for (uint256 i = leaves.length; i < n; i++) {
        nodes[i] = leaves[leaves.length - 1];
    }
    uint256 totalLevels = 1;
    while (n > 1) {
        n = n / 2;
        totalLevels++;
    }
    bytes32[][] memory tree = new bytes32[][](totalLevels);
    tree[0] = nodes;
    uint256 levelSize = nodes.length;
    uint256 level = 0;
    while (levelSize > 1) {
        levelSize /= 2;
        tree[level + 1] = new bytes32[](levelSize);
        for (uint256 i = 0; i < levelSize; i++) {
            tree[level + 1][i] = _sortAndHashPair(tree[level][2 * i], tree[level][(2 * i) + 1]);
        }
        level++;
    }
    root = tree[level][0];
    proof = new bytes32[][](leaves.length);
    for (uint256 i = 0; i < leaves.length; i++) {
        proof[i] = _generateProof(i, tree);
    }
    return (proof, root);
}
```

### _sortAndHashPair(bytes32,bytes32)

- **Kind**: internal
- **Source**: 2972:181:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_sortAndHashPair(bytes32,bytes32)`

```solidity
function _sortAndHashPair(bytes32 a, bytes32 b) internal pure returns (bytes32) {
    return (a < b) ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
}
```

### _generateProof(uint256,bytes32[][])

- **Kind**: internal
- **Source**: 4890:453:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_generateProof(uint256,bytes32[][])`

```solidity
function _generateProof(uint256 index, bytes32[][] memory tree) private pure returns (bytes32[] memory) {
    uint256 levels = tree.length;
    bytes32[] memory proof = new bytes32[](levels - 1);
    for (uint256 level = 0; level < (levels - 1); level++) {
        uint256 siblingIndex = index ^ 1;
        proof[level] = tree[level][siblingIndex];
        index /= 2;
    }
    return proof;
}
```

### _createSignature(string,bytes32,address,uint256)

- **Kind**: internal
- **Source**: 374:837:503
- **Link**: `lib/v2-core/test/utils/SignatureHelper.sol:SignatureHelper:_createSignature(string,bytes32,address,uint256)`

```solidity
function _createSignature(string memory hashNamespace, bytes32 merkleRoot, address signer, uint256 signerPrivateKey) internal pure returns (bytes memory signature) {
    if ((signer == address(0)) || (signerPrivateKey == 0)) revert("signer not set");
    bytes32 messageHash = keccak256(abi.encode(hashNamespace, merkleRoot));
    bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, ethSignedMessageHash);
    signature = abi.encodePacked(r, s, v);
    address _expectedSigner = ECDSA.recover(ethSignedMessageHash, signature);
    assertEq(_expectedSigner, signer, "Signature should be valid");
}
```

### toEthSignedMessageHash(bytes32)

- **Kind**: internal
- **Source**: 1247:433:291
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toEthSignedMessageHash(bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an ERC-191 signed data with version
///  `0x45` (`personal_sign` messages).
///  The digest is calculated by prefixing a bytes32 `messageHash` with
///  `"\x19Ethereum Signed Message:\n32"` and hashing the result. It corresponds with the
///  hash signed when using the https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign[`eth_sign`] JSON-RPC method.
///  NOTE: The `messageHash` parameter is intended to be the result of hashing a raw message with
///  keccak256, although any bytes32 value can be safely used because the final digest will
///  be re-hashed.
///  See {ECDSA-recover}.
function toEthSignedMessageHash(bytes32 messageHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        mstore(0x00, "\u0019Ethereum Signed Message:\n32")
        mstore(0x1c, messageHash)
        digest := keccak256(0x00, 0x3c)
    }
}
```

### recover(bytes32,bytes)

- **Kind**: internal
- **Source**: 3714:255:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:recover(bytes32,bytes)`

```solidity
///  @dev Returns the address that signed a hashed message (`hash`) with
///  `signature`. This address can then be used for verification purposes.
///  The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
///  this function rejects them by requiring the `s` value to be in the lower
///  half order, and the `v` value to be either 27 or 28.
///  IMPORTANT: `hash` _must_ be the result of a hash operation for the
///  verification to be secure: it is possible to craft signatures that
///  recover to arbitrary addresses for non-hashed data. A safe way to ensure
///  this is by receiving a hash of the original message (which may otherwise
///  be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
    (address recovered, RecoverError error, bytes32 errorArg) = tryRecover(hash, signature);
    _throwError(error, errorArg);
    return recovered;
}
```

### tryRecover(bytes32,bytes)

- **Kind**: internal
- **Source**: 2129:778:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:tryRecover(bytes32,bytes)`

```solidity
///  @dev Returns the address that signed a hashed message (`hash`) with `signature` or an error. This will not
///  return address(0) without also returning an error description. Errors are documented using an enum (error type)
///  and a bytes32 providing additional information about the error.
///  If no error is returned, then the address can be used for verification purposes.
///  The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
///  this function rejects them by requiring the `s` value to be in the lower
///  half order, and the `v` value to be either 27 or 28.
///  IMPORTANT: `hash` _must_ be the result of a hash operation for the
///  verification to be secure: it is possible to craft signatures that
///  recover to arbitrary addresses for non-hashed data. A safe way to ensure
///  this is by receiving a hash of the original message (which may otherwise
///  be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
///  Documentation for signature generation:
///  - with https://web3js.readthedocs.io/en/v1.3.4/web3-eth-accounts.html#sign[Web3.js]
///  - with https://docs.ethers.io/v5/api/signer/#Signer-signMessage[ethers]
function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address recovered, RecoverError err, bytes32 errArg) {
    if (signature.length == 65) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly ("memory-safe") {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }
        return tryRecover(hash, v, r, s);
    } else {
        return (address(0), RecoverError.InvalidSignatureLength, bytes32(signature.length));
    }
}
```

### tryRecover(bytes32,uint8,bytes32,bytes32)

- **Kind**: internal
- **Source**: 5203:1551:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:tryRecover(bytes32,uint8,bytes32,bytes32)`

```solidity
///  @dev Overload of {ECDSA-tryRecover} that receives the `v`,
///  `r` and `s` signature fields separately.
function tryRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address recovered, RecoverError err, bytes32 errArg) {
    if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
        return (address(0), RecoverError.InvalidSignatureS, s);
    }
    address signer = ecrecover(hash, v, r, s);
    if (signer == address(0)) {
        return (address(0), RecoverError.InvalidSignature, bytes32(0));
    }
    return (signer, RecoverError.NoError, bytes32(0));
}
```

### _throwError(enum ECDSA.RecoverError,bytes32)

- **Kind**: internal
- **Source**: 7280:532:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:_throwError(enum ECDSA.RecoverError,bytes32)`

```solidity
///  @dev Optionally reverts with the corresponding custom error according to the `error` argument provided.
function _throwError(RecoverError error, bytes32 errorArg) private pure {
    if (error == RecoverError.NoError) {
        return;
    } else if (error == RecoverError.InvalidSignature) {
        revert ECDSAInvalidSignature();
    } else if (error == RecoverError.InvalidSignatureLength) {
        revert ECDSAInvalidSignatureLength(uint256(errorArg));
    } else if (error == RecoverError.InvalidSignatureS) {
        revert ECDSAInvalidSignatureS(errorArg);
    }
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### logBytes32(bytes32)

- **Kind**: internal
- **Source**: 5820:123:26
- **Link**: `lib/forge-std/src/console.sol:console:logBytes32(bytes32)`

```solidity
function logBytes32(bytes32 p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
}
```

### _createSignatureData_DestinationExecutorWithChains(uint64[],uint48,bytes32,bytes32[],struct ISuperValidator.DstProof[],bytes)

- **Kind**: internal
- **Source**: 101428:531:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_createSignatureData_DestinationExecutorWithChains(uint64[],uint48,bytes32,bytes32[],struct ISuperValidator.DstProof[],bytes)`

```solidity
function _createSignatureData_DestinationExecutorWithChains(uint64[] memory chainsWithDestinationExecution, uint48 validUntil, bytes32 merkleRoot, bytes32[] memory merkleProofSrc, ISuperValidator.DstProof[] memory merkleProofDst, bytes memory signature) internal pure returns (bytes memory) {
    return abi.encode(chainsWithDestinationExecution, validUntil, 0, merkleRoot, merkleProofSrc, merkleProofDst, signature);
}
```

### _processAcrossV3Message(struct BaseTest.ProcessAcrossV3MessageParams)

- **Kind**: internal
- **Source**: 85049:2353:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_processAcrossV3Message(struct BaseTest.ProcessAcrossV3MessageParams)`

```solidity
function _processAcrossV3Message(ProcessAcrossV3MessageParams memory params) internal {
    if (params.relayerType == RELAYER_TYPE.NOT_ENOUGH_BALANCE) {
        vm.expectEmit(true, false, false, false);
        emit ISuperDestinationExecutor.SuperDestinationExecutorReceivedButNotEnoughBalance(params.account, address(0), 0, 0);
    } else if (params.relayerType == RELAYER_TYPE.ENOUGH_BALANCE) {
        vm.expectEmit(true, true, true, true);
        emit ISuperDestinationExecutor.SuperDestinationExecutorExecuted(params.account);
    } else if (params.relayerType == RELAYER_TYPE.NO_HOOKS) {
        vm.expectEmit(true, true, true, true);
        emit ISuperDestinationExecutor.SuperDestinationExecutorReceivedButNoHooks(params.account);
    } else if (params.relayerType == RELAYER_TYPE.USED_ROOT) {
        vm.expectEmit(true, true, true, true);
        emit ISuperDestinationExecutor.SuperDestinationExecutorReceivedButRootUsedAlready(params.account, params.root);
    } else if (params.relayerType == RELAYER_TYPE.REVERT) {
        if (params.errorMessage != bytes4(0)) {
            vm.expectRevert(params.errorMessage);
        } else {
            vm.expectRevert(bytes(params.errorReason));
        }
    }
    if (params.relayerGas == 0) {
        AcrossV3Helper(_getContract(params.srcChainId, ACROSS_V3_HELPER_KEY)).help(SPOKE_POOL_V3_ADDRESSES[params.srcChainId], SPOKE_POOL_V3_ADDRESSES[params.dstChainId], ACROSS_RELAYER, params.warpTimestamp, FORKS[params.dstChainId], params.dstChainId, params.srcChainId, params.executionData.logs);
    } else {
        AcrossV3Helper(_getContract(params.srcChainId, ACROSS_V3_HELPER_KEY)).help(SPOKE_POOL_V3_ADDRESSES[params.srcChainId], SPOKE_POOL_V3_ADDRESSES[params.dstChainId], ACROSS_RELAYER, params.warpTimestamp, FORKS[params.dstChainId], params.dstChainId, params.srcChainId, params.executionData.logs, params.relayerGas);
    }
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

## External Calls

- **IERC4626::previewRedeem(uint256)**
- **IERC4626::previewDeposit(uint256)**
- **VmContractHelper530::deployCode(string,bytes)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **SuperGovernor::registerHook(address)**
- **IERC4626::balanceOf(address)**

## State Variable Reads

- **vaultInstanceMorphoEth** (`contract IERC4626`) [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract VaultBank`) [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]
- **validatorOnBase** (`contract IValidator`) [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IValidator.md]
- **acrossV3AdapterOnBase** (`contract AcrossV3Adapter`) [lib/v2-core/src/adapters/AcrossV3Adapter.sol/contract_AcrossV3Adapter.md]
- **superTargetExecutorOnBase** (`contract ISuperDestinationExecutor`) [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]
- **accountBase** (`address`)
- **underlyingBase_USDC** (`address`)
- **underlyingETH_USDC** (`address`)
- **yieldSourceMorphoUsdcAddressEth** (`address`)
- **instanceOnETH** (`struct AccountInstance`)
- **superExecutorOnETH** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **sourceValidatorOnETH** (`contract IValidator`) [lib/v2-core/lib/modulekit/src/accounts/common/interfaces/IERC7579Module.sol/interface_IValidator.md]
- **FORKS** (`mapping(uint64 => uint256)`)
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **mockRegistry** (`contract MockRegistry`) [lib/v2-core/test/mocks/MockRegistry.sol/contract_MockRegistry.md]
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)
- **SPOKE_POOL_V3_ADDRESSES** (`mapping(uint64 => address)`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)

## State Variable Writes

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract VaultBank`) [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankCrosschainTests.test_Bridge_MintSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.SELECT_FORK_AND_WARP(uint64,uint256) (NodeID: 1)
  │   💬 Args: [ETH, safeTimestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.SELECT_FORK_AND_WARP(uint64,uint256) (NodeID: 2)
  │   💬 Args: [BASE, safeTimestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 3)
  │   💬 Args: [BASE, MINT_SUPERPOSITIONS_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 4)
  │   💬 Args: [BASE, MINT_SUPERPOSITIONS_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._createApproveAndLockVaultBankHookData(bytes32,address,uint256,bool,address,uint256) (NodeID: 5)
  │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), CHAIN_8453_USDC, previewRedeemAmount, false, address(vaultBank), ETH]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 6)
  │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._createTargetExecutorMessage(struct BaseTest.TargetExecutorMessage,bool) (NodeID: 7)
  │   💬 Args: [messageData, false]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._createCrosschainExecutionData_DestinationExecutor(address[],bytes[]) (NodeID: 8)
  │ │   💬 Args: [messageData.hooksAddresses, messageData.hooksData]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 9)
  │ │   💬 Args: ["-------------- is7702", is7702]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 10)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 11)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._createAccountCreationData_DestinationExecutor(struct BaseTest.AccountCreationParams) (NodeID: 12)
  │     💬 Args: [AccountCreationParams({senderCreatorOnDestinationChain: is7702 ? _getContract(messageData.chainId, SUPER_7702_SENDER_CREATOR_KEY) : _getContract(messageData.chainId, SUPER_SENDER_CREATOR_KEY), validatorOnDestinationChain: messageData.validator, superMerkleValidator: _getContract(messageData.chainId, SUPER_MERKLE_VALIDATOR_KEY), theSigner: messageData.signer, executorOnDestinationChain: _getContract(messageData.chainId, SUPER_DESTINATION_EXECUTOR_KEY), superExecutor: _getContract(messageData.chainId, SUPER_EXECUTOR_KEY), nexusFactory: messageData.nexusFactory, nexusBootstrap: messageData.nexusBootstrap, is7702: is7702})]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 14)
  │   │   💬 Args: [messageData.chainId, SUPER_7702_SENDER_CREATOR_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 15)
  │   │   💬 Args: [messageData.chainId, SUPER_SENDER_CREATOR_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 16)
  │   │   💬 Args: [messageData.chainId, SUPER_MERKLE_VALIDATOR_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 17)
  │   │   💬 Args: [messageData.chainId, SUPER_DESTINATION_EXECUTOR_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 18)
  │   │   💬 Args: [messageData.chainId, SUPER_EXECUTOR_KEY]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.__createNon7702NexusInitData(struct BaseTest.AccountCreationParams) (NodeID: 13)
  │       💬 Args: [p]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 19)
  │   💬 Args: [CHAIN_8453_USDC, accountToUse, amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 20)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 21)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 22)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 23)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 24)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 25)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 26)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 27)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 28)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 29)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 30)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 31)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 32)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 33)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 34)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 35)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 36)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 37)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 38)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 39)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 40)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 41)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 42)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 43)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 44)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 45)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 46)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 47)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 48)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 49)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 50)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 51)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 52)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 53)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 54)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 55)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 56)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 57)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 58)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 59)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 60)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 61)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 62)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 63)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 64)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 65)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 66)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 67)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 68)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 69)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 70)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 71)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 72)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 73)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 74)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 75)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 76)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 77)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 78)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 79)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 80)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 81)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 82)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 83)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 84)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 85)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 86)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 87)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 88)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 89)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 90)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 91)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 92)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 93)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 94)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 95)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 96)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 97)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 98)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 99)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 100)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 101)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 102)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 103)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 104)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 105)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 106)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 107)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 108)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 109)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 110)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 111)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 112)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 113)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 114)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 115)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 116)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 117)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.SELECT_FORK_AND_WARP(uint64,uint256) (NodeID: 118)
  │   💬 Args: [ETH, safeTimestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 119)
  │   💬 Args: [ETH, APPROVE_ERC20_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 120)
  │   💬 Args: [ETH, DEPOSIT_4626_VAULT_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 121)
  │   💬 Args: [ETH, APPROVE_ERC20_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 122)
  │   💬 Args: [ETH, ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._createApproveHookData(address,address,uint256,bool) (NodeID: 123)
  │   💬 Args: [underlyingETH_USDC, yieldSourceMorphoUsdcAddressEth, amount, false]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._createDeposit4626HookData(bytes32,address,uint256,bool,address,uint256) (NodeID: 124)
  │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), yieldSourceMorphoUsdcAddressEth, amount, false, address(0), 0]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 125)
  │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._createApproveHookData(address,address,uint256,bool) (NodeID: 126)
  │   💬 Args: [underlyingETH_USDC, SPOKE_POOL_V3_ADDRESSES[ETH], 0, true]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._createAcrossV3ReceiveFundsAndExecuteHookData(address,address,uint256,uint256,uint64,bool,bytes) (NodeID: 127)
  │   💬 Args: [existingUnderlyingTokens[ETH][USDC_KEY], existingUnderlyingTokens[BASE][USDC_KEY], previewRedeemAmount, previewRedeemAmount, BASE, true, targetExecutorMessage]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 128)
  │     💬 Args: [destinationChainId, ACROSS_V3_ADAPTER_KEY]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._getExecOpsWithValidator(struct AccountInstance,contract ISuperExecutor,bytes,address) (NodeID: 129)
  │   💬 Args: [instanceOnETH, superExecutorOnETH, abi.encode(entry), address(sourceValidatorOnETH)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 130)
  │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), validator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._createMerkleRootAndSignature(struct BaseTest.TargetExecutorMessage,bytes32,address,uint64,address) (NodeID: 131)
  │   💬 Args: [messageData, srcUserOpData.userOpHash, accountToUse, BASE, address(sourceValidatorOnETH)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._createCrosschainExecutionData_DestinationExecutor(address[],bytes[]) (NodeID: 132)
  │ │   💬 Args: [messageData.hooksAddresses, messageData.hooksData]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeHelper._createDestinationValidatorLeaf(bytes,uint64,address,address,address[],uint256[],uint48,address) (NodeID: 133)
  │ │   💬 Args: [ctx.executionData, messageData.chainId, accountToUse, messageData.targetExecutor, ctx.dstTokens, ctx.intentAmounts, ctx.validUntil, messageData.validator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeHelper._createSourceValidatorLeaf(bytes32,uint48,uint48,uint64[],address) (NodeID: 134)
  │ │   💬 Args: [userOpHash, ctx.validUntil, 0, chainsForLeaf, srcValidator]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeHelper._createValidatorMerkleTree(bytes32[]) (NodeID: 135)
  │ │   💬 Args: [ctx.leaves]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MerkleTreeHelper._sortAndHashPair(bytes32,bytes32) (NodeID: 136)
  │ │ │   💬 Args: [tree[level][2 * i], tree[level][(2 * i) + 1]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MerkleTreeHelper._generateProof(uint256,bytes32[][]) (NodeID: 137)
  │ │     💬 Args: [i, tree]
  │ │     👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: SignatureHelper._createSignature(string,bytes32,address,uint256) (NodeID: 138)
  │ │   💬 Args: [SuperValidatorBase(address(messageData.validator)).namespace(), ctx.merkleRoot, messageData.signer, messageData.signerPrivateKey]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toEthSignedMessageHash(bytes32) (NodeID: 139)
  │ │ │   💬 Args: [messageHash]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 140)
  │ │ │   💬 Args: [ethSignedMessageHash, signature]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 141)
  │ │ │ │   💬 Args: [hash, signature]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 142)
  │ │ │ │     💬 Args: [hash, v, r, s]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 143)
  │ │ │     💬 Args: [error, errorArg]
  │ │ │     👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 144)
  │ │     💬 Args: [_expectedSigner, signer, "Signature should be valid"]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.logBytes32(bytes32) (NodeID: 145)
  │ │   💬 Args: [ctx.merkleRoot]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 146)
  │ │     💬 Args: [abi.encodeWithSignature("log(bytes32)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 147)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._createSignatureData_DestinationExecutorWithChains(uint64[],uint48,bytes32,bytes32[],struct ISuperValidator.DstProof[],bytes) (NodeID: 148)
  │     💬 Args: [chainsWithDestinationExecution, ctx.validUntil, ctx.merkleRoot, ctx.merkleProof[1], proofDst, ctx.signature]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._processAcrossV3Message(struct BaseTest.ProcessAcrossV3MessageParams) (NodeID: 149)
  │   💬 Args: [ProcessAcrossV3MessageParams({srcChainId: ETH, dstChainId: BASE, warpTimestamp: safeTimestamp, executionData: executeOp(srcUserOpData), relayerType: RELAYER_TYPE.ENOUGH_BALANCE, errorMessage: bytes4(0), errorReason: "", root: bytes32(0), account: accountBase, relayerGas: 0})]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 152)
  │ │   💬 Args: [srcUserOpData]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 153)
  │ │     💬 Args: [userOpData]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 154)
  │ │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 155)
  │ │         💬 Args: [userOps, onEntryPoint]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 156)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 157)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 158)
  │ │       │   💬 Args: ["SIMULATE", false]
  │ │       │   👁️  Def: public
  │ │       ├─ [6] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 159)
  │ │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 160)
  │ │       │ │   💬 Args: [no args]
  │ │       │ │   👁️  Def: internal
  │ │       │ │ ├─ [8] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 161)
  │ │       │ │ │   💬 Args: [no args]
  │ │       │ │ │   👁️  Def: internal
  │ │       │ │ ├─ [8] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 162)
  │ │       │ │ │   💬 Args: [no args]
  │ │       │ │ │   👁️  Def: internal
  │ │       │ │ └─ [8] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 163)
  │ │       │ │     💬 Args: [no args]
  │ │       │ │     👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 164)
  │ │       │     💬 Args: [userOpDetails]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 165)
  │ │       │   │   💬 Args: [no args]
  │ │       │   │   👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 166)
  │ │       │   │   💬 Args: [userOpDetails, debugTrace]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 167)
  │ │       │   │ │   💬 Args: [userOpDetails]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 168)
  │ │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 169)
  │ │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 170)
  │ │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 171)
  │ │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │       │   │ │   👁️  Def: private
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 172)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 173)
  │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │       │   │ │ │   👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 174)
  │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 175)
  │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 176)
  │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │       │   │ │ │   👁️  Def: private
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 177)
  │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 178)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 179)
  │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 180)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 181)
  │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 182)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 183)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 184)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 185)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 186)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 187)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 188)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 189)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 190)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 191)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 192)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 193)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 194)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 195)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 196)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 197)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 198)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 199)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 200)
  │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 201)
  │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 202)
  │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 203)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 204)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 205)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 206)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 207)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 208)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 209)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 210)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 211)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 212)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 213)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 214)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 215)
  │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │       │   │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 216)
  │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 217)
  │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ ├─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 218)
  │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │       │   │ │ │ │ └─ [12] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 219)
  │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │       │   │ │ │ │     👁️  Def: internal
  │ │       │   │ │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 220)
  │ │       │   │ │ │     💬 Args: [key, entity]
  │ │       │   │ │ │     👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 221)
  │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 222)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 223)
  │ │       │   │ │     💬 Args: [targetAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 224)
  │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 225)
  │ │       │   │ │     💬 Args: [targetAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 226)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 227)
  │ │       │   │ │     💬 Args: [targetAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 228)
  │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 229)
  │ │       │   │ │     💬 Args: [targetAddr]
  │ │       │   │ │     👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 230)
  │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 231)
  │ │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │       │   │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 232)
  │ │       │   │   💬 Args: [no args]
  │ │       │   │   👁️  Def: internal
  │ │       │   └─ [8] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 233)
  │ │       │       💬 Args: [snapShotId]
  │ │       │       👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 234)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 235)
  │ │       │   💬 Args: [ctx.returnData]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 236)
  │ │       │ │   💬 Args: [no args]
  │ │       │ │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 237)
  │ │       │     💬 Args: [actualReason, revertMessage]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 238)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 239)
  │ │       │   💬 Args: [logs, userOpHash]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 240)
  │ │       │   💬 Args: [account]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 241)
  │ │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │       │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 244)
  │ │       │ │   💬 Args: [logs, userOpHash]
  │ │       │ │   👁️  Def: internal
  │ │       │ ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 242)
  │ │       │ │   💬 Args: [no args]
  │ │       │ │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 243)
  │ │       │     💬 Args: [actualReason, revertMessage]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 245)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 246)
  │ │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 247)
  │ │       │   💬 Args: [logs[i].emitter]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 248)
  │ │       │   💬 Args: [j, logs[i].emitter]
  │ │       │   👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 249)
  │ │       │   💬 Args: [no args]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 250)
  │ │       │     💬 Args: [slot]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 251)
  │ │       │   💬 Args: ["GAS", false]
  │ │       │   👁️  Def: public
  │ │       └─ [6] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 252)
  │ │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 253)
  │ │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 254)
  │ │           │   💬 Args: [userOpCalldata]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 255)
  │ │           │ │   💬 Args: [data]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 256)
  │ │           │     💬 Args: [compressed]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 257)
  │ │           │   💬 Args: [userOpCalldata]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 258)
  │ │           │ │   💬 Args: [0.684e18]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 259)
  │ │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 260)
  │ │           │   │   💬 Args: [getCallDataGas(data)]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 261)
  │ │           │   │     💬 Args: [data]
  │ │           │   │     👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 262)
  │ │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │           │       👁️  Def: internal
  │ │           │     └─ [11] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 263)
  │ │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │           │         👁️  Def: internal
  │ │           │       └─ [12] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 264)
  │ │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │           │           👁️  Def: internal
  │ │           │         ├─ [13] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 265)
  │ │           │         │   💬 Args: [x]
  │ │           │         │   👁️  Def: internal
  │ │           │         └─ [13] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 266)
  │ │           │             💬 Args: [y]
  │ │           │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 267)
  │ │           │   💬 Args: [fileName]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 268)
  │ │           │   💬 Args: [fileName]
  │ │           │   👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 269)
  │ │           │   💬 Args: [fileContent]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 270)
  │ │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 271)
  │ │           │ │     💬 Args: [fileContent, ".Total"]
  │ │           │ │     👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 272)
  │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 273)
  │ │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │           │ │     👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 274)
  │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 275)
  │ │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │           │ │     👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 276)
  │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 277)
  │ │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │           │ │     👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 278)
  │ │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 279)
  │ │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │           │ │     👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 280)
  │ │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │           │     👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 281)
  │ │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 282)
  │ │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 283)
  │ │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 284)
  │ │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 285)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 286)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 287)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 288)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 289)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 290)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 291)
  │ │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 292)
  │ │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 293)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 294)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 295)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 296)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 297)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 298)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 299)
  │ │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 300)
  │ │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 301)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 302)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 303)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 304)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 305)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 306)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 307)
  │ │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 308)
  │ │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 309)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 310)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 311)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 312)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 313)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 314)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 315)
  │ │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 316)
  │ │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 317)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 318)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 319)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 320)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 321)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 322)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 323)
  │ │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 324)
  │ │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │           │ │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 325)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 326)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   ├─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 327)
  │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │           │ │   │   👁️  Def: internal
  │ │           │ │   │ └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 328)
  │ │           │ │   │     💬 Args: [value]
  │ │           │ │   │     👁️  Def: internal
  │ │           │ │   └─ [11] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 329)
  │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │           │ │       👁️  Def: internal
  │ │           │ │     └─ [12] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 330)
  │ │           │ │         💬 Args: [value]
  │ │           │ │         👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 331)
  │ │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │           │ │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 332)
  │ │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 333)
  │ │           │   💬 Args: [finalJson, fileName]
  │ │           │   👁️  Def: internal
  │ │           └─ [8] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 334)
  │ │               💬 Args: [""]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 335)
  │ │                 💬 Args: [slot, id]
  │ │                 👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 150)
  │ │   💬 Args: [params.srcChainId, ACROSS_V3_HELPER_KEY]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 151)
  │     💬 Args: [params.srcChainId, ACROSS_V3_HELPER_KEY]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.SELECT_FORK_AND_WARP(uint64,uint256) (NodeID: 336)
  │   💬 Args: [BASE, safeTimestamp + 10 days]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 337)
      💬 Args: [accSharesAfter, previewRedeemAmount]
      👁️  Def: internal
```
