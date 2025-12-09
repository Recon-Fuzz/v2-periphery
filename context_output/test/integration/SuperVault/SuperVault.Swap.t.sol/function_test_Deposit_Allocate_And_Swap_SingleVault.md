# Function: test_Deposit_Allocate_And_Swap_SingleVault()

**Contract**: [test/integration/SuperVault/SuperVault.Swap.t.sol/contract_SuperVaultSwapTest.md]

## Metadata

- **Contract**: SuperVaultSwapTest
- **Signature**: `test_Deposit_Allocate_And_Swap_SingleVault()`
- **Visibility**: public
- **Source Range**: 7233:1431:579

## Implementation

```solidity
function test_Deposit_Allocate_And_Swap_SingleVault() public {
    uint256 depositAmount = 1000e6;
    _deposit(depositAmount);
    uint256 userShares = vault.balanceOf(accountEth);
    assertGt(userShares, 0, "No shares minted to user");
    assertEq(asset.balanceOf(address(strategy)), depositAmount, "Wrong strategy balance");
    _depositAndSwapWithCustomRatios(depositAmount, address(asset), address(strategy), address(fluidVault), address(aaveVault), 1, 1);
    assertGt(fluidVault.balanceOf(address(strategy)), 0, "No fluid shares allocated");
    assertGt(aaveVault.balanceOf(address(strategy)), 0, "No aave shares allocated");
    uint256 balanceOfUsdt = IERC20(CHAIN_1_USDT).balanceOf(address(strategy));
    assertGt(balanceOfUsdt, 0, "No USDT allocated");
    uint256 expectedSwapAmount = (depositAmount * 30) / 100;
    assertApproxEqRel(balanceOfUsdt, expectedSwapAmount, 0.05e18, "USDT amount should be ~300 USDC equivalent");
}
```

## Related Implementations

### _deposit(uint256)

- **Kind**: internal
- **Source**: 32981:106:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deposit(uint256)`

```solidity
function _deposit(uint256 depositAmount) internal {
    __deposit(instanceOnEth, depositAmount);
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

### _depositAndSwapWithCustomRatios(uint256,address,address,address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 22402:4272:579
- **Link**: `test/integration/SuperVault/SuperVault.Swap.t.sol:SuperVaultSwapTest:_depositAndSwapWithCustomRatios(uint256,address,address,address,address,uint256,uint256)`

```solidity
function _depositAndSwapWithCustomRatios(uint256 fullAmount, address assetToDeposit, address strat, address vault1, address vault2, uint256 ratio1, uint256 ratio2) private {
    RatioCalculationVars memory ratioVars;
    ratioVars.totalRatio = ratio1 + ratio2;
    ratioVars.vaultAllocation = (fullAmount * 70) / 100;
    ratioVars.vault1Amount = (ratioVars.vaultAllocation * ratio1) / ratioVars.totalRatio;
    ratioVars.vault2Amount = (ratioVars.vaultAllocation * ratio2) / ratioVars.totalRatio;
    ratioVars.yieldSourceOracleId = _getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER);
    assert(fullAmount >= ratioVars.vaultAllocation);
    DepositAndSwapParams memory params = DepositAndSwapParams({fullAmount: fullAmount, assetToDeposit: assetToDeposit, strat: strat, vault1: vault1, vault2: vault2, depositHookAddress: _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY), approveAndSwapOdos: approveAndSwapOdosHookAddressETH, fullDepositAmount: ratioVars.vault1Amount, halfAmount: ratioVars.vault2Amount, swapAmount: fullAmount - ratioVars.vaultAllocation});
    ExecutionArrays memory arrays = ExecutionArrays({executeHookAddresses: new address[](3), executeHooksData: new bytes[](3), expectedAssetsOrSharesOut: new uint256[](3), argsForProofs: new bytes[](3)});
    arrays.executeHookAddresses[0] = params.depositHookAddress;
    arrays.executeHookAddresses[1] = params.depositHookAddress;
    arrays.executeHookAddresses[2] = params.approveAndSwapOdos;
    arrays.executeHooksData[0] = _createApproveAndDeposit4626HookData(ratioVars.yieldSourceOracleId, params.vault1, params.assetToDeposit, ratioVars.vault1Amount, false, address(0), 0);
    arrays.executeHooksData[1] = _createApproveAndDeposit4626HookData(ratioVars.yieldSourceOracleId, params.vault2, params.assetToDeposit, ratioVars.vault2Amount, false, address(0), 0);
    _processSwapData(params, arrays);
    arrays.expectedAssetsOrSharesOut[0] = IERC4626(address(params.vault1)).convertToShares(ratioVars.vault1Amount);
    arrays.expectedAssetsOrSharesOut[1] = IERC4626(address(params.vault2)).convertToShares(ratioVars.vault2Amount);
    assert(arrays.expectedAssetsOrSharesOut[0] > 0);
    assert(arrays.expectedAssetsOrSharesOut[1] > 0);
    for (uint256 i; i < arrays.expectedAssetsOrSharesOut.length; i++) {
        arrays.expectedAssetsOrSharesOut[i] = (arrays.expectedAssetsOrSharesOut[i] * (1e5 - 1e3)) / 1e5;
    }
    arrays.argsForProofs[0] = ISuperHookInspector(arrays.executeHookAddresses[0]).inspect(arrays.executeHooksData[0]);
    arrays.argsForProofs[1] = ISuperHookInspector(arrays.executeHookAddresses[1]).inspect(arrays.executeHooksData[1]);
    arrays.argsForProofs[2] = ISuperHookInspector(arrays.executeHookAddresses[2]).inspect(arrays.executeHooksData[2]);
    vm.mockCall(address(aggregator), abi.encodeWithSelector(ISuperVaultAggregator.validateHook.selector), abi.encode(true));
    vm.startPrank(MANAGER);
    ISuperVaultStrategy(payable(params.strat)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: arrays.executeHookAddresses, hookCalldata: arrays.executeHooksData, expectedAssetsOrSharesOut: arrays.expectedAssetsOrSharesOut, globalProofs: new bytes32[][](3), strategyProofs: new bytes32[][](3)}));
    vm.stopPrank();
}
```

### _processSwapData(struct SuperVaultSwapTest.DepositAndSwapParams,struct SuperVaultSwapTest.ExecutionArrays)

- **Kind**: internal
- **Source**: 30897:2665:579
- **Link**: `test/integration/SuperVault/SuperVault.Swap.t.sol:SuperVaultSwapTest:_processSwapData(struct SuperVaultSwapTest.DepositAndSwapParams,struct SuperVaultSwapTest.ExecutionArrays)`

```solidity
function _processSwapData(DepositAndSwapParams memory params, ExecutionArrays memory arrays) private {
    SwapProcessingVars memory swapVars;
    swapVars.quoteInputTokens = new QuoteInputToken[](1);
    swapVars.quoteInputTokens[0] = QuoteInputToken({tokenAddress: params.assetToDeposit, amount: params.swapAmount});
    swapVars.quoteOutputTokens = new QuoteOutputToken[](1);
    swapVars.quoteOutputTokens[0] = QuoteOutputToken({tokenAddress: CHAIN_1_USDT, proportion: 1});
    if (useRealOdosRouter) {
        swapVars.path = surlCallQuoteV2(swapVars.quoteInputTokens, swapVars.quoteOutputTokens, params.strat, ETH, true);
        swapVars.requestBody = surlCallAssemble(swapVars.path, params.strat);
        swapVars.odosDecodedSwap = decodeOdosSwapCalldata(fromHex(swapVars.requestBody));
        swapVars.odosCalldata = _createOdosSwapHookData(swapVars.odosDecodedSwap.tokenInfo.inputToken, swapVars.odosDecodedSwap.tokenInfo.inputAmount, swapVars.odosDecodedSwap.tokenInfo.inputReceiver, swapVars.odosDecodedSwap.tokenInfo.outputToken, swapVars.odosDecodedSwap.tokenInfo.outputQuote, (swapVars.odosDecodedSwap.tokenInfo.outputMin * (1e5 - 1e4)) / 1e5, swapVars.odosDecodedSwap.pathDefinition, swapVars.odosDecodedSwap.executor, swapVars.odosDecodedSwap.referralCode, false);
        arrays.executeHooksData[2] = swapVars.odosCalldata;
        arrays.expectedAssetsOrSharesOut[2] = swapVars.odosDecodedSwap.tokenInfo.outputQuote;
    } else {
        deal(CHAIN_1_USDT, address(odosRouter), params.swapAmount);
        uint256 slippageFactor = (params.swapAmount * 1e4) / 1e5;
        assert(params.swapAmount >= slippageFactor);
        uint256 outputMin = params.swapAmount - slippageFactor;
        swapVars.odosCalldata = _createOdosSwapHookData(params.assetToDeposit, params.swapAmount, odosRouterAddress, CHAIN_1_USDT, params.swapAmount, outputMin, bytes(""), address(0), 0, false);
        arrays.executeHooksData[2] = swapVars.odosCalldata;
        arrays.expectedAssetsOrSharesOut[2] = params.swapAmount;
    }
}
```

### surlCallQuoteV2(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool)

- **Kind**: internal
- **Source**: 3578:1024:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:surlCallQuoteV2(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool)`

```solidity
function surlCallQuoteV2(QuoteInputToken[] memory _inputTokens, QuoteOutputToken[] memory _outputTokens, address _account, uint256 _chainId, bool _compact) internal returns (string memory) {
    string[] memory headers = new string[](1);
    headers[0] = "Content-Type: application/json";
    string memory body = buildQuoteV2RequestBody(_inputTokens, _outputTokens, _account, _chainId, _compact);
    (uint256 status, bytes memory data) = API_QUOTE_URL.post(headers, body);
    if (status != 200) {
        revert("OdosAPIParser: surlCallQuoteV2 failed");
    }
    string memory json = string(data);
    strings.slice memory jsonSlice = json.toSlice();
    strings.slice memory key = "\"pathId\":\"".toSlice();
    strings.slice memory afterKey = jsonSlice.find(key).beyond(key);
    strings.slice memory pathId = afterKey.split("\"".toSlice());
    return pathId.toString();
}
```

### buildQuoteV2RequestBody(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool)

- **Kind**: internal
- **Source**: 1657:1915:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:buildQuoteV2RequestBody(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool)`

```solidity
function buildQuoteV2RequestBody(QuoteInputToken[] memory _inputTokens, QuoteOutputToken[] memory _outputTokens, address _account, uint256 _chainId, bool _compact) internal pure returns (string memory) {
    string memory inputTokensStr = "[";
    for (uint256 i = 0; i < _inputTokens.length; i++) {
        inputTokensStr = string.concat(inputTokensStr, (i > 0) ? "," : "", "{\"tokenAddress\":\"", toChecksumString(_inputTokens[i].tokenAddress), "\",", "\"amount\":\"", _inputTokens[i].amount.toString(), "\"}");
    }
    inputTokensStr = string.concat(inputTokensStr, "]");
    string memory outputTokensStr = "[";
    for (uint256 i = 0; i < _outputTokens.length; i++) {
        outputTokensStr = string.concat(outputTokensStr, (i > 0) ? "," : "", "{\"tokenAddress\":\"", toChecksumString(_outputTokens[i].tokenAddress), "\",", "\"proportion\":", _outputTokens[i].proportion.toString(), "}");
    }
    outputTokensStr = string.concat(outputTokensStr, "]");
    return string.concat("{", "\"chainId\":", _chainId.toString(), ",", "\"inputTokens\":", inputTokensStr, ",", "\"outputTokens\":", outputTokensStr, ",", "\"slippageLimitPercent\":0.3,", "\"userAddr\":\"", toChecksumString(_account), "\",", "\"referralCode\":0,", "\"disableRFQs\":true,", "\"compact\":", _compact ? "true" : "false", "}");
}
```

### toChecksumString(address)

- **Kind**: internal
- **Source**: 218:149:504
- **Link**: `lib/v2-core/test/utils/parsers/BaseAPIParser.sol:BaseAPIParser:toChecksumString(address)`

```solidity
function toChecksumString(address addr) internal pure returns (string memory) {
    return Strings.toHexString(uint256(uint160(addr)), 20);
}
```

### toHexString(uint256,uint256)

- **Kind**: internal
- **Source**: 2612:525:286
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(uint256,uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    uint256 localValue = value;
    bytes memory buffer = new bytes((2 * length) + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = (2 * length) + 1; i > 1; --i) {
        buffer[i] = HEX_DIGITS[localValue & 0xf];
        localValue >>= 4;
    }
    if (localValue != 0) {
        revert StringsInsufficientHexLength(value, length);
    }
    return string(buffer);
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 1308:634:286
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

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
- **Source**: 29154:916:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

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

### post(string,string[],string)

- **Kind**: internal
- **Source**: 2234:209:324
- **Link**: `lib/v2-core/lib/surl/src/Surl.sol:Surl:post(string,string[],string)`

```solidity
function post(string memory self, string[] memory headers, string memory body) internal returns (uint256 status, bytes memory data) {
    return curl(self, headers, body, "POST");
}
```

### curl(string,string[],string,string)

- **Kind**: internal
- **Source**: 3070:1208:324
- **Link**: `lib/v2-core/lib/surl/src/Surl.sol:Surl:curl(string,string[],string,string)`

```solidity
function curl(string memory self, string[] memory headers, string memory body, string memory method) internal returns (uint256 status, bytes memory data) {
    string memory scriptStart = "response=$(curl -s -w \"\\n%{http_code}\" ";
    string memory scriptEnd = "); status=$(tail -n1 <<< \"$response\"); data=$(sed \"$ d\" <<< \"$response\");data=$(echo \"$data\" | tr -d \"\\n\"); cast abi-encode \"response(uint256,string)\" \"$status\" \"$data\";";
    string memory curlParams = "";
    for (uint256 i = 0; i < headers.length; i++) {
        curlParams = string.concat(curlParams, "-H \"", headers[i], "\" ");
    }
    curlParams = string.concat(curlParams, " -X ", method, " ");
    if (bytes(body).length > 0) {
        curlParams = string.concat(curlParams, " -d '", body, "' ");
    }
    string memory quotedURL = string.concat("\"", self, "\"");
    string[] memory inputs = new string[](3);
    inputs[0] = "bash";
    inputs[1] = "-c";
    inputs[2] = string.concat(scriptStart, curlParams, quotedURL, scriptEnd, "");
    bytes memory res = vm.ffi(inputs);
    (status, data) = abi.decode(res, (uint256, bytes));
}
```

### toSlice(string)

- **Kind**: internal
- **Source**: 2919:210:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:toSlice(string)`

```solidity
function toSlice(string memory self) internal pure returns (slice memory) {
    uint ptr;
    assembly {
        ptr := add(self, 0x20)
    }
    return slice(bytes(self).length, ptr);
}
```

### find(struct strings.slice,struct strings.slice)

- **Kind**: internal
- **Source**: 18891:258:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:find(struct strings.slice,struct strings.slice)`

```solidity
function find(slice memory self, slice memory needle) internal pure returns (slice memory) {
    uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr);
    self._len -= ptr - self._ptr;
    self._ptr = ptr;
    return self;
}
```

### findPtr(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 15492:1453:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:findPtr(uint256,uint256,uint256,uint256)`

```solidity
function findPtr(uint selflen, uint selfptr, uint needlelen, uint needleptr) private pure returns (uint) {
    uint ptr = selfptr;
    uint idx;
    if (needlelen <= selflen) {
        if (needlelen <= 32) {
            bytes32 mask;
            if (needlelen > 0) {
                mask = bytes32(~((2 ** (8 * (32 - needlelen))) - 1));
            }
            bytes32 needledata;
            assembly {
                needledata := and(mload(needleptr), mask)
            }
            uint end = (selfptr + selflen) - needlelen;
            bytes32 ptrdata;
            assembly {
                ptrdata := and(mload(ptr), mask)
            }
            while (ptrdata != needledata) {
                if (ptr >= end) return selfptr + selflen;
                ptr++;
                assembly {
                    ptrdata := and(mload(ptr), mask)
                }
            }
            return ptr;
        } else {
            bytes32 hash;
            assembly {
                hash := keccak256(needleptr, needlelen)
            }
            for (idx = 0; idx <= (selflen - needlelen); idx++) {
                bytes32 testHash;
                assembly {
                    testHash := keccak256(ptr, needlelen)
                }
                if (hash == testHash) return ptr;
                ptr += 1;
            }
        }
    }
    return selfptr + selflen;
}
```

### beyond(struct strings.slice,struct strings.slice)

- **Kind**: internal
- **Source**: 12981:661:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:beyond(struct strings.slice,struct strings.slice)`

```solidity
function beyond(slice memory self, slice memory needle) internal pure returns (slice memory) {
    if (self._len < needle._len) {
        return self;
    }
    bool equal = true;
    if (self._ptr != needle._ptr) {
        assembly {
            let length := mload(needle)
            let selfptr := mload(add(self, 0x20))
            let needleptr := mload(add(needle, 0x20))
            equal := eq(keccak256(selfptr, length), keccak256(needleptr, length))
        }
    }
    if (equal) {
        self._len -= needle._len;
        self._ptr += needle._len;
    }
    return self;
}
```

### split(struct strings.slice,struct strings.slice)

- **Kind**: internal
- **Source**: 21223:141:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:split(struct strings.slice,struct strings.slice)`

```solidity
function split(slice memory self, slice memory needle) internal pure returns (slice memory token) {
    split(self, needle, token);
}
```

### split(struct strings.slice,struct strings.slice,struct strings.slice)

- **Kind**: internal
- **Source**: 20248:504:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:split(struct strings.slice,struct strings.slice,struct strings.slice)`

```solidity
function split(slice memory self, slice memory needle, slice memory token) internal pure returns (slice memory) {
    uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr);
    token._ptr = self._ptr;
    token._len = ptr - self._ptr;
    if (ptr == (self._ptr + self._len)) {
        self._len = 0;
    } else {
        self._len -= token._len + needle._len;
        self._ptr = ptr + needle._len;
    }
    return token;
}
```

### toString(struct strings.slice)

- **Kind**: internal
- **Source**: 5301:265:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:toString(struct strings.slice)`

```solidity
function toString(slice memory self) internal pure returns (string memory) {
    string memory ret = new string(self._len);
    uint retptr;
    assembly {
        retptr := add(ret, 32)
    }
    memcpy(retptr, self._ptr, self._len);
    return ret;
}
```

### memcpy(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2088:631:323
- **Link**: `lib/v2-core/lib/solidity-stringutils/src/strings.sol:strings:memcpy(uint256,uint256,uint256)`

```solidity
function memcpy(uint dest, uint src, uint length) private pure {
    for (; length >= 32; length -= 32) {
        assembly {
            mstore(dest, mload(src))
        }
        dest += 32;
        src += 32;
    }
    uint mask = type(uint).max;
    if (length > 0) {
        mask = (256 ** (32 - length)) - 1;
    }
    assembly {
        let srcpart := and(mload(src), not(mask))
        let destpart := and(mload(dest), mask)
        mstore(dest, or(destpart, srcpart))
    }
}
```

### surlCallAssemble(string,address)

- **Kind**: internal
- **Source**: 5079:813:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:surlCallAssemble(string,address)`

```solidity
function surlCallAssemble(string memory _pathId, address _userAddr) internal returns (string memory) {
    string[] memory headers = new string[](1);
    headers[0] = "Content-Type: application/json";
    string memory body = buildAssembleRequestBody(_pathId, _userAddr);
    (uint256 status, bytes memory data) = API_ASSEMBLE_URL.post(headers, body);
    if (status != 200) {
        revert("OdosAPIParser: surlCallAssemble failed");
    }
    string memory json = string(data);
    strings.slice memory jsonSlice = json.toSlice();
    strings.slice memory key = "\"data\":\"".toSlice();
    strings.slice memory afterKey = jsonSlice.find(key).beyond(key);
    strings.slice memory swapData = afterKey.split("\"".toSlice());
    return swapData.toString();
}
```

### buildAssembleRequestBody(string,address)

- **Kind**: internal
- **Source**: 4791:282:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:buildAssembleRequestBody(string,address)`

```solidity
function buildAssembleRequestBody(string memory _pathId, address _userAddr) internal pure returns (string memory) {
    return string.concat("{", "\"pathId\":\"", _pathId, "\",", "\"userAddr\":\"", toChecksumString(_userAddr), "\",", "\"simulate\":false}");
}
```

### decodeOdosSwapCalldata(bytes)

- **Kind**: internal
- **Source**: 6076:797:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:decodeOdosSwapCalldata(bytes)`

```solidity
function decodeOdosSwapCalldata(bytes memory txData) internal view returns (OdosDecodedSwap memory decoded) {
    if (txData.length < 4) {
        revert("OdosAPIParser: invalid tx data length");
    }
    bytes4 selector = bytes4(txData.slice(0, 4));
    bytes memory data = txData.slice(4, txData.length - 4);
    if (selector == IOdosRouterV2.swap.selector) {
        (decoded.tokenInfo, decoded.pathDefinition, decoded.executor, decoded.referralCode) = abi.decode(data, (IOdosRouterV2.swapTokenInfo, bytes, address, uint32));
    } else if (selector == IOdosRouterV2.swapCompact.selector) {
        (decoded.executor, decoded.referralCode, decoded.pathDefinition, decoded.tokenInfo) = _decode(data);
    }
    return decoded;
}
```

### fromHex(string)

- **Kind**: internal
- **Source**: 373:517:504
- **Link**: `lib/v2-core/test/utils/parsers/BaseAPIParser.sol:BaseAPIParser:fromHex(string)`

```solidity
function fromHex(string memory s) public pure returns (bytes memory) {
    bytes memory ss = bytes(s);
    require(((ss.length >= 2) && (ss[0] == "0")) && ((ss[1] == "x") || (ss[1] == "X")), "BaseAPIParser: hex string must start with 0x");
    bytes memory r = new bytes((ss.length - 2) / 2);
    for (uint256 i = 0; i < r.length; ++i) {
        r[i] = bytes1((_fromHexChar(uint8(ss[(2 * i) + 2])) * 16) + _fromHexChar(uint8(ss[(2 * i) + 3])));
    }
    return r;
}
```

### _fromHexChar(uint8)

- **Kind**: internal
- **Source**: 896:485:504
- **Link**: `lib/v2-core/test/utils/parsers/BaseAPIParser.sol:BaseAPIParser:_fromHexChar(uint8)`

```solidity
function _fromHexChar(uint8 c) private pure returns (uint8) {
    if ((c >= uint8(bytes1("0"))) && (c <= uint8(bytes1("9")))) {
        return c - uint8(bytes1("0"));
    }
    if ((c >= uint8(bytes1("a"))) && (c <= uint8(bytes1("f")))) {
        return (10 + c) - uint8(bytes1("a"));
    }
    if ((c >= uint8(bytes1("A"))) && (c <= uint8(bytes1("F")))) {
        return (10 + c) - uint8(bytes1("A"));
    }
    revert("BaseAPIParser: invalid hex char");
}
```

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 9250:2874:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:slice(bytes,uint256,uint256)`

```solidity
function slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
    unchecked {
        require((_length + 31) >= _length, "slice_overflow");
    }
    require(_bytes.length >= (_start + _length), "slice_outOfBounds");
    bytes memory tempBytes;
    assembly {
        switch iszero(_length)
        case 0 {
            tempBytes := mload(0x40)
            let lengthmod := and(_length, 31)
            let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
            let end := add(mc, _length)
            for {
                let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }
            mstore(tempBytes, _length)
            mstore(0x40, and(add(mc, 31), not(31)))
        }
        default {
            tempBytes := mload(0x40)
            mstore(tempBytes, 0)
            mstore(0x40, add(tempBytes, 0x20))
        }
    }
    return tempBytes;
}
```

### _decode(bytes)

- **Kind**: internal
- **Source**: 7061:3620:505
- **Link**: `lib/v2-core/test/utils/parsers/OdosAPIParser.sol:OdosAPIParser:_decode(bytes)`

```solidity
function _decode(bytes memory rawData) private view returns (address executor, uint32 referralCode, bytes memory pathDefinition, IOdosRouterV2.swapTokenInfo memory tokenInfo) {
    bytes memory data = rawData;
    tokenInfo = IOdosRouterV2.swapTokenInfo({inputToken: address(0), inputAmount: 0, inputReceiver: address(0), outputToken: address(0), outputQuote: 0, outputMin: 0, outputReceiver: address(0)});
    pathDefinition = new bytes(0);
    address msgSender = msg.sender;
    assembly {
        let dataPtr := add(data, 0x20)
        tokenInfo := mload(0x40)
        mstore(0x40, add(tokenInfo, 0xE0))
        let tokenInfoPtr := tokenInfo
        let pos := 0
        function getAddress (currPos, ptr) -> result, newPos {
            let inputPos := shr(240, mload(add(ptr, currPos)))
            switch inputPos
            case 0x0000 {
                result := 0
                newPos := add(currPos, 2)
            }
            case 0x0001 {
                result := and(shr(80, mload(add(ptr, currPos))), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                newPos := add(currPos, 22)
            }
            default {
                result := sload(add(ADDRESS_LIST_START, sub(inputPos, 2)))
                newPos := add(currPos, 2)
            }
        }
        let tmp := 0
        tmp, pos := getAddress(pos, dataPtr)
        mstore(tokenInfo, tmp)
        tmp, pos := getAddress(pos, dataPtr)
        mstore(add(tokenInfo, 0x60), tmp)
        let inputLen := shr(248, mload(add(dataPtr, pos)))
        pos := add(pos, 1)
        if inputLen {
            mstore(add(tokenInfoPtr, 0x20), shr(mul(sub(32, inputLen), 8), mload(add(dataPtr, pos))))
            pos := add(pos, inputLen)
        }
        let quoteLen := shr(248, mload(add(dataPtr, pos)))
        pos := add(pos, 1)
        let quote := shr(mul(sub(32, quoteLen), 8), mload(add(dataPtr, pos)))
        mstore(add(tokenInfoPtr, 0x80), quote)
        pos := add(pos, quoteLen)
        {
            let slip := shr(232, mload(add(dataPtr, pos)))
            mstore(add(tokenInfoPtr, 0xA0), div(mul(quote, sub(0xFFFFFF, slip)), 0xFFFFFF))
        }
        pos := add(pos, 3)
        executor, pos := getAddress(pos, dataPtr)
        tmp, pos := getAddress(pos, dataPtr)
        if eq(tmp, 0) {
            tmp := executor
        }
        mstore(add(tokenInfoPtr, 0x40), tmp)
        tmp, pos := getAddress(pos, dataPtr)
        if eq(tmp, 0) {
            tmp := msgSender
        }
        mstore(add(tokenInfoPtr, 0xC0), tmp)
        referralCode := shr(224, mload(add(dataPtr, pos)))
        pos := add(pos, 4)
        let pathLen := mul(shr(248, mload(add(dataPtr, pos))), 32)
        pathDefinition := mload(0x40)
        mstore(pathDefinition, pathLen)
        let dest := add(pathDefinition, 0x20)
        mstore(0x40, add(dest, pathLen))
        let pathData := add(add(dataPtr, pos), 1)
        for {
            let i := 0
        } lt(i, pathLen) {
            i := add(i, 32)
        } {
            mstore(add(dest, i), mload(add(pathData, i)))
        }
    }
}
```

### _createOdosSwapHookData(address,uint256,address,address,uint256,uint256,bytes,address,uint32,bool)

- **Kind**: internal
- **Source**: 7295:755:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createOdosSwapHookData(address,uint256,address,address,uint256,uint256,bytes,address,uint32,bool)`

```solidity
function _createOdosSwapHookData(address inputToken, uint256 inputAmount, address inputReceiver, address outputToken, uint256 outputQuote, uint256 outputMin, bytes memory pathDefinition, address executor, uint32 referralCode, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(inputToken, inputAmount, inputReceiver, outputToken, outputQuote, outputMin, usePrevHookAmount, pathDefinition.length, pathDefinition, executor, referralCode);
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

### assertApproxEqRel(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 20668:288:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRel(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta, string memory err) virtual internal pure {
    vm.assertApproxEqRel(left, right, maxPercentDelta, err);
}
```

## External Calls

- **SuperVault::balanceOf(address)**
- **IERC20Metadata::balanceOf(address)**
- **IERC4626::balanceOf(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **instanceOnEth** (`struct AccountInstance`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **odosRouter** (`contract MockOdosRouterV2`) [test/mocks/MockOdosRouterV2.sol/contract_MockOdosRouterV2.md]
- **odosRouterAddress** (`address`)
- **API_QUOTE_URL** (`string`)
- **HEX_DIGITS** (`bytes16`)
- **API_ASSEMBLE_URL** (`string`)
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultSwapTest.test_Deposit_Allocate_And_Swap_SingleVault() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deposit(uint256) (NodeID: 1)
  │   💬 Args: [depositAmount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256) (NodeID: 2)
  │     💬 Args: [instanceOnEth, depositAmount]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 3)
  │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 4)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), address(vault), address(asset), depositAmount, false, address(0), 0]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 5)
  │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 6)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 7)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 8)
  │       💬 Args: [userOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 9)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 10)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 11)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 12)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 13)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 14)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 15)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 16)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 17)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 18)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 19)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 20)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 21)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 22)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 23)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 24)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 25)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 26)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 27)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 28)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 29)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 30)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 31)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 32)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 33)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 34)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 35)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 36)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 37)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 38)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 39)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 40)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 41)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 42)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 43)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 44)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 45)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 46)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 47)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 48)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 49)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 50)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 51)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 52)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 53)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 54)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 55)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 56)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 57)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 58)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 59)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 60)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 61)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 62)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 63)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 64)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 65)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 66)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 67)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 68)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 69)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 70)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 71)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 72)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 73)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 74)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 75)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 76)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 77)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 78)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 79)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 80)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 81)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 82)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 83)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 84)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 85)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 86)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 87)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 88)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 89)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 90)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 91)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 92)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 93)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 94)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 95)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 96)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 97)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 100)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 98)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 99)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 101)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 102)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 103)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 104)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 105)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 106)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 107)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 108)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 109)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 110)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 111)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 112)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 113)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 114)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 115)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 116)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 117)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 118)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 119)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 120)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 121)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 122)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 123)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 124)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 125)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 126)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 127)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 128)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 129)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 130)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 131)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 132)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 133)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 134)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 135)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 136)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 137)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 138)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 139)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 140)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 141)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 142)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 143)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 144)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 145)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 146)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 147)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 148)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 149)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 150)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 151)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 152)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 153)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 154)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 155)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 156)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 157)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 158)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 159)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 160)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 161)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 162)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 163)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 164)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 165)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 166)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 167)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 168)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 169)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 170)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 171)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 172)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 173)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 174)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 175)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 176)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 177)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 178)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 179)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 180)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 181)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 182)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 183)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 184)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 185)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 186)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 187)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 188)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 189)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 190)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 191)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 192)
  │   💬 Args: [userShares, 0, "No shares minted to user"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 193)
  │   💬 Args: [asset.balanceOf(address(strategy)), depositAmount, "Wrong strategy balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultSwapTest._depositAndSwapWithCustomRatios(uint256,address,address,address,address,uint256,uint256) (NodeID: 194)
  │   💬 Args: [depositAmount, address(asset), address(strategy), address(fluidVault), address(aaveVault), 1, 1]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 195)
  │ │   💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 196)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 197)
  │ │   💬 Args: [ratioVars.yieldSourceOracleId, params.vault1, params.assetToDeposit, ratioVars.vault1Amount, false, address(0), 0]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 198)
  │ │   💬 Args: [ratioVars.yieldSourceOracleId, params.vault2, params.assetToDeposit, ratioVars.vault2Amount, false, address(0), 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultSwapTest._processSwapData(struct SuperVaultSwapTest.DepositAndSwapParams,struct SuperVaultSwapTest.ExecutionArrays) (NodeID: 199)
  │     💬 Args: [params, arrays]
  │     👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: OdosAPIParser.surlCallQuoteV2(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool) (NodeID: 200)
  │   │   💬 Args: [swapVars.quoteInputTokens, swapVars.quoteOutputTokens, params.strat, ETH, true]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: OdosAPIParser.buildQuoteV2RequestBody(struct OdosAPIParser.QuoteInputToken[],struct OdosAPIParser.QuoteOutputToken[],address,uint256,bool) (NodeID: 201)
  │   │ │   💬 Args: [_inputTokens, _outputTokens, _account, _chainId, _compact]
  │   │ │   👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: BaseAPIParser.toChecksumString(address) (NodeID: 202)
  │   │ │ │   💬 Args: [_inputTokens[i].tokenAddress]
  │   │ │ │   👁️  Def: internal
  │   │ │ │ └─ [6] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 203)
  │   │ │ │     💬 Args: [uint256(uint160(addr)), 20]
  │   │ │ │     👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 204)
  │   │ │ │   💬 Args: [_inputTokens[i].amount]
  │   │ │ │   👁️  Def: internal
  │   │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 205)
  │   │ │ │     💬 Args: [value]
  │   │ │ │     👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: BaseAPIParser.toChecksumString(address) (NodeID: 206)
  │   │ │ │   💬 Args: [_outputTokens[i].tokenAddress]
  │   │ │ │   👁️  Def: internal
  │   │ │ │ └─ [6] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 207)
  │   │ │ │     💬 Args: [uint256(uint160(addr)), 20]
  │   │ │ │     👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 208)
  │   │ │ │   💬 Args: [_outputTokens[i].proportion]
  │   │ │ │   👁️  Def: internal
  │   │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 209)
  │   │ │ │     💬 Args: [value]
  │   │ │ │     👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 210)
  │   │ │ │   💬 Args: [_chainId]
  │   │ │ │   👁️  Def: internal
  │   │ │ │ └─ [6] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 211)
  │   │ │ │     💬 Args: [value]
  │   │ │ │     👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: BaseAPIParser.toChecksumString(address) (NodeID: 212)
  │   │ │     💬 Args: [_account]
  │   │ │     👁️  Def: internal
  │   │ │   └─ [6] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 213)
  │   │ │       💬 Args: [uint256(uint160(addr)), 20]
  │   │ │       👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Surl.post(string,string[],string) (NodeID: 214)
  │   │ │   💬 Args: [API_QUOTE_URL, headers, body]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Surl.curl(string,string[],string,string) (NodeID: 215)
  │   │ │     💬 Args: [self, headers, body, "POST"]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 216)
  │   │ │   💬 Args: [json]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 217)
  │   │ │   💬 Args: ["\"pathId\":\""]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.find(struct strings.slice,struct strings.slice) (NodeID: 218)
  │   │ │   💬 Args: [jsonSlice, key]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: strings.findPtr(uint256,uint256,uint256,uint256) (NodeID: 219)
  │   │ │     💬 Args: [self._len, self._ptr, needle._len, needle._ptr]
  │   │ │     👁️  Def: private
  │   │ ├─ [4] ⚙️ FUNCTION: strings.beyond(struct strings.slice,struct strings.slice) (NodeID: 220)
  │   │ │   💬 Args: [jsonSlice.find(key), key]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.split(struct strings.slice,struct strings.slice) (NodeID: 221)
  │   │ │   💬 Args: [afterKey, "\"".toSlice()]
  │   │ │   👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 224)
  │   │ │ │   💬 Args: ["\""]
  │   │ │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: strings.split(struct strings.slice,struct strings.slice,struct strings.slice) (NodeID: 222)
  │   │ │     💬 Args: [self, needle, token]
  │   │ │     👁️  Def: internal
  │   │ │   └─ [6] ⚙️ FUNCTION: strings.findPtr(uint256,uint256,uint256,uint256) (NodeID: 223)
  │   │ │       💬 Args: [self._len, self._ptr, needle._len, needle._ptr]
  │   │ │       👁️  Def: private
  │   │ └─ [4] ⚙️ FUNCTION: strings.toString(struct strings.slice) (NodeID: 225)
  │   │     💬 Args: [pathId]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: strings.memcpy(uint256,uint256,uint256) (NodeID: 226)
  │   │       💬 Args: [retptr, self._ptr, self._len]
  │   │       👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: OdosAPIParser.surlCallAssemble(string,address) (NodeID: 227)
  │   │   💬 Args: [swapVars.path, params.strat]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: OdosAPIParser.buildAssembleRequestBody(string,address) (NodeID: 228)
  │   │ │   💬 Args: [_pathId, _userAddr]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: BaseAPIParser.toChecksumString(address) (NodeID: 229)
  │   │ │     💬 Args: [_userAddr]
  │   │ │     👁️  Def: internal
  │   │ │   └─ [6] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 230)
  │   │ │       💬 Args: [uint256(uint160(addr)), 20]
  │   │ │       👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Surl.post(string,string[],string) (NodeID: 231)
  │   │ │   💬 Args: [API_ASSEMBLE_URL, headers, body]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Surl.curl(string,string[],string,string) (NodeID: 232)
  │   │ │     💬 Args: [self, headers, body, "POST"]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 233)
  │   │ │   💬 Args: [json]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 234)
  │   │ │   💬 Args: ["\"data\":\""]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.find(struct strings.slice,struct strings.slice) (NodeID: 235)
  │   │ │   💬 Args: [jsonSlice, key]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: strings.findPtr(uint256,uint256,uint256,uint256) (NodeID: 236)
  │   │ │     💬 Args: [self._len, self._ptr, needle._len, needle._ptr]
  │   │ │     👁️  Def: private
  │   │ ├─ [4] ⚙️ FUNCTION: strings.beyond(struct strings.slice,struct strings.slice) (NodeID: 237)
  │   │ │   💬 Args: [jsonSlice.find(key), key]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: strings.split(struct strings.slice,struct strings.slice) (NodeID: 238)
  │   │ │   💬 Args: [afterKey, "\"".toSlice()]
  │   │ │   👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: strings.toSlice(string) (NodeID: 241)
  │   │ │ │   💬 Args: ["\""]
  │   │ │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: strings.split(struct strings.slice,struct strings.slice,struct strings.slice) (NodeID: 239)
  │   │ │     💬 Args: [self, needle, token]
  │   │ │     👁️  Def: internal
  │   │ │   └─ [6] ⚙️ FUNCTION: strings.findPtr(uint256,uint256,uint256,uint256) (NodeID: 240)
  │   │ │       💬 Args: [self._len, self._ptr, needle._len, needle._ptr]
  │   │ │       👁️  Def: private
  │   │ └─ [4] ⚙️ FUNCTION: strings.toString(struct strings.slice) (NodeID: 242)
  │   │     💬 Args: [swapData]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: strings.memcpy(uint256,uint256,uint256) (NodeID: 243)
  │   │       💬 Args: [retptr, self._ptr, self._len]
  │   │       👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: OdosAPIParser.decodeOdosSwapCalldata(bytes) (NodeID: 244)
  │   │   💬 Args: [fromHex(swapVars.requestBody)]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: BaseAPIParser.fromHex(string) (NodeID: 248)
  │   │ │   💬 Args: [swapVars.requestBody]
  │   │ │   👁️  Def: public
  │   │ │ ├─ [5] ⚙️ FUNCTION: BaseAPIParser._fromHexChar(uint8) (NodeID: 249)
  │   │ │ │   💬 Args: [uint8(ss[(2 * i) + 3])]
  │   │ │ │   👁️  Def: private
  │   │ │ └─ [5] ⚙️ FUNCTION: BaseAPIParser._fromHexChar(uint8) (NodeID: 250)
  │   │ │     💬 Args: [uint8(ss[(2 * i) + 2])]
  │   │ │     👁️  Def: private
  │   │ ├─ [4] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 245)
  │   │ │   💬 Args: [txData, 0, 4]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 246)
  │   │ │   💬 Args: [txData, 4, txData.length - 4]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: OdosAPIParser._decode(bytes) (NodeID: 247)
  │   │     💬 Args: [data]
  │   │     👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createOdosSwapHookData(address,uint256,address,address,uint256,uint256,bytes,address,uint32,bool) (NodeID: 251)
  │   │   💬 Args: [swapVars.odosDecodedSwap.tokenInfo.inputToken, swapVars.odosDecodedSwap.tokenInfo.inputAmount, swapVars.odosDecodedSwap.tokenInfo.inputReceiver, swapVars.odosDecodedSwap.tokenInfo.outputToken, swapVars.odosDecodedSwap.tokenInfo.outputQuote, (swapVars.odosDecodedSwap.tokenInfo.outputMin * (1e5 - 1e4)) / 1e5, swapVars.odosDecodedSwap.pathDefinition, swapVars.odosDecodedSwap.executor, swapVars.odosDecodedSwap.referralCode, false]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 252)
  │   │   💬 Args: [CHAIN_1_USDT, address(odosRouter), params.swapAmount]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 253)
  │   │     💬 Args: [token, to, give, false]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 254)
  │   │   │   💬 Args: [stdstore, token]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 255)
  │   │   │     💬 Args: [self, _target]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 256)
  │   │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 257)
  │   │   │     💬 Args: [self, _sig]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 258)
  │   │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 259)
  │   │   │     💬 Args: [self, who]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 260)
  │   │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 261)
  │   │   │     💬 Args: [self, bytes32(amt)]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 262)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 263)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 264)
  │   │   │   │   💬 Args: [self, false]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 265)
  │   │   │   │     💬 Args: [self, _clear]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 266)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 267)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 268)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 269)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 270)
  │   │   │   │   │ │   💬 Args: [self]
  │   │   │   │   │ │   👁️  Def: internal
  │   │   │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 271)
  │   │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │   │ │     👁️  Def: private
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 272)
  │   │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 273)
  │   │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 274)
  │   │   │   │   │ │   💬 Args: [self]
  │   │   │   │   │ │   👁️  Def: internal
  │   │   │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 275)
  │   │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 276)
  │   │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │   │ │ │     👁️  Def: private
  │   │   │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 277)
  │   │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │   │ │     👁️  Def: private
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 278)
  │   │   │   │   │     💬 Args: [self]
  │   │   │   │   │     👁️  Def: internal
  │   │   │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 279)
  │   │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 280)
  │   │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │   │     👁️  Def: private
  │   │   │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 281)
  │   │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │   │       👁️  Def: private
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 282)
  │   │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 283)
  │   │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │   │ │   👁️  Def: internal
  │   │   │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 284)
  │   │   │   │   │ │     💬 Args: [self]
  │   │   │   │   │ │     👁️  Def: internal
  │   │   │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 285)
  │   │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 286)
  │   │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │   │ │   │     👁️  Def: private
  │   │   │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 287)
  │   │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │   │ │       👁️  Def: private
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 288)
  │   │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │   │     👁️  Def: internal
  │   │   │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 289)
  │   │   │   │   │       💬 Args: [self]
  │   │   │   │   │       👁️  Def: internal
  │   │   │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 290)
  │   │   │   │   │     │   💬 Args: [self]
  │   │   │   │   │     │   👁️  Def: internal
  │   │   │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 291)
  │   │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │   │     │     👁️  Def: private
  │   │   │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 292)
  │   │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │   │         👁️  Def: private
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 293)
  │   │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 294)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 295)
  │   │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 296)
  │   │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 297)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 298)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 299)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 300)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 301)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 302)
  │   │   │         💬 Args: [self]
  │   │   │         👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 303)
  │   │   │   💬 Args: [stdstore, token]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 304)
  │   │   │     💬 Args: [self, _target]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 305)
  │   │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 306)
  │   │   │     💬 Args: [self, _sig]
  │   │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 307)
  │   │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 308)
  │   │         💬 Args: [self, bytes32(amt)]
  │   │         👁️  Def: internal
  │   │       ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 309)
  │   │       │   💬 Args: [self]
  │   │       │   👁️  Def: internal
  │   │       │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 310)
  │   │       │     💬 Args: [self._keys]
  │   │       │     👁️  Def: private
  │   │       ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 311)
  │   │       │   💬 Args: [self, false]
  │   │       │   👁️  Def: internal
  │   │       │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 312)
  │   │       │     💬 Args: [self, _clear]
  │   │       │     👁️  Def: internal
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 313)
  │   │       │   │   💬 Args: [self]
  │   │       │   │   👁️  Def: internal
  │   │       │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 314)
  │   │       │   │     💬 Args: [self._keys]
  │   │       │   │     👁️  Def: private
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 315)
  │   │       │   │   💬 Args: [self]
  │   │       │   │   👁️  Def: internal
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 316)
  │   │       │   │   💬 Args: [self]
  │   │       │   │   👁️  Def: internal
  │   │       │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 317)
  │   │       │   │ │   💬 Args: [self]
  │   │       │   │ │   👁️  Def: internal
  │   │       │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 318)
  │   │       │   │ │     💬 Args: [self._keys]
  │   │       │   │ │     👁️  Def: private
  │   │       │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 319)
  │   │       │   │     💬 Args: [rdat, 32 * self._depth]
  │   │       │   │     👁️  Def: private
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 320)
  │   │       │   │   💬 Args: [self, reads[i]]
  │   │       │   │   👁️  Def: internal
  │   │       │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 321)
  │   │       │   │ │   💬 Args: [self]
  │   │       │   │ │   👁️  Def: internal
  │   │       │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 322)
  │   │       │   │ │ │   💬 Args: [self]
  │   │       │   │ │ │   👁️  Def: internal
  │   │       │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 323)
  │   │       │   │ │ │     💬 Args: [self._keys]
  │   │       │   │ │ │     👁️  Def: private
  │   │       │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 324)
  │   │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │       │   │ │     👁️  Def: private
  │   │       │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 325)
  │   │       │   │     💬 Args: [self]
  │   │       │   │     👁️  Def: internal
  │   │       │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 326)
  │   │       │   │   │   💬 Args: [self]
  │   │       │   │   │   👁️  Def: internal
  │   │       │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 327)
  │   │       │   │   │     💬 Args: [self._keys]
  │   │       │   │   │     👁️  Def: private
  │   │       │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 328)
  │   │       │   │       💬 Args: [rdat, 32 * self._depth]
  │   │       │   │       👁️  Def: private
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 329)
  │   │       │   │   💬 Args: [self, reads[i]]
  │   │       │   │   👁️  Def: internal
  │   │       │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 330)
  │   │       │   │ │   💬 Args: [self, slot, true]
  │   │       │   │ │   👁️  Def: internal
  │   │       │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 331)
  │   │       │   │ │     💬 Args: [self]
  │   │       │   │ │     👁️  Def: internal
  │   │       │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 332)
  │   │       │   │ │   │   💬 Args: [self]
  │   │       │   │ │   │   👁️  Def: internal
  │   │       │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 333)
  │   │       │   │ │   │     💬 Args: [self._keys]
  │   │       │   │ │   │     👁️  Def: private
  │   │       │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 334)
  │   │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │       │   │ │       👁️  Def: private
  │   │       │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 335)
  │   │       │   │     💬 Args: [self, slot, false]
  │   │       │   │     👁️  Def: internal
  │   │       │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 336)
  │   │       │   │       💬 Args: [self]
  │   │       │   │       👁️  Def: internal
  │   │       │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 337)
  │   │       │   │     │   💬 Args: [self]
  │   │       │   │     │   👁️  Def: internal
  │   │       │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 338)
  │   │       │   │     │     💬 Args: [self._keys]
  │   │       │   │     │     👁️  Def: private
  │   │       │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 339)
  │   │       │   │         💬 Args: [rdat, 32 * self._depth]
  │   │       │   │         👁️  Def: private
  │   │       │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 340)
  │   │       │   │   💬 Args: [offsetLeft, offsetRight]
  │   │       │   │   👁️  Def: internal
  │   │       │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 341)
  │   │       │       💬 Args: [self]
  │   │       │       👁️  Def: internal
  │   │       ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 342)
  │   │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │       │   👁️  Def: internal
  │   │       │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 343)
  │   │       │     💬 Args: [offsetLeft, offsetRight]
  │   │       │     👁️  Def: internal
  │   │       ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 344)
  │   │       │   💬 Args: [self]
  │   │       │   👁️  Def: internal
  │   │       │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 345)
  │   │       │ │   💬 Args: [self]
  │   │       │ │   👁️  Def: internal
  │   │       │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 346)
  │   │       │ │     💬 Args: [self._keys]
  │   │       │ │     👁️  Def: private
  │   │       │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 347)
  │   │       │     💬 Args: [rdat, 32 * self._depth]
  │   │       │     👁️  Def: private
  │   │       └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 348)
  │   │           💬 Args: [self]
  │   │           👁️  Def: internal
  │   │         └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 349)
  │   │             💬 Args: [self]
  │   │             👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers._createOdosSwapHookData(address,uint256,address,address,uint256,uint256,bytes,address,uint32,bool) (NodeID: 350)
  │       💬 Args: [params.assetToDeposit, params.swapAmount, odosRouterAddress, CHAIN_1_USDT, params.swapAmount, outputMin, bytes(""), address(0), 0, false]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 351)
  │   💬 Args: [fluidVault.balanceOf(address(strategy)), 0, "No fluid shares allocated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 352)
  │   💬 Args: [aaveVault.balanceOf(address(strategy)), 0, "No aave shares allocated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 353)
  │   💬 Args: [balanceOfUsdt, 0, "No USDT allocated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqRel(uint256,uint256,uint256,string) (NodeID: 354)
      💬 Args: [balanceOfUsdt, expectedSwapAmount, 0.05e18, "USDT amount should be ~300 USDC equivalent"]
      👁️  Def: internal
```
