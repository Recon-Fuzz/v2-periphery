# Function: test_ShouldExecuteAll_AndLockAssetsInVaultBank_Test1ExistingShares(uint256)

**Contract**: [test/draft/test/unit/VaultBankFromExecutor.t.sol/contract_VaultBankFromExecutor.md]

## Metadata

- **Contract**: VaultBankFromExecutor
- **Signature**: `test_ShouldExecuteAll_AndLockAssetsInVaultBank_Test1ExistingShares(uint256)`
- **Visibility**: external
- **Source Range**: 8661:1791:571

## Implementation

```solidity
function test_ShouldExecuteAll_AndLockAssetsInVaultBank_Test1ExistingShares(uint256 amount) external {
    AccountInstance memory testInstance = makeAccountInstance(keccak256(abi.encode("TEST")));
    address testAccount = testInstance.account;
    testInstance.installModule({moduleTypeId: MODULE_TYPE_EXECUTOR, module: address(superExecutor), data: ""});
    testInstance.installModule({moduleTypeId: MODULE_TYPE_VALIDATOR, module: address(validator), data: abi.encode(signer)});
    amount = _bound(amount);
    superRegistry.addVaultBank(8453, address(vaultBank));
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = address(mintSuperPositionsHook);
    bytes[] memory hooksData = new bytes[](1);
    _getTokens(yieldSourceAddress, testAccount, amount);
    hooksData[0] = _createApproveAndLockVaultBankHookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), yieldSourceAddress, amount, false, address(vaultBank), 8453);
    ISuperExecutor.ExecutorEntry memory entry = ISuperExecutor.ExecutorEntry({hooksAddresses: hooksAddresses, hooksData: hooksData});
    UserOpData memory userOpData = _getExecOpsWithValidator(testInstance, superExecutor, abi.encode(entry), address(validator));
    uint48 validUntil = uint48(block.timestamp + 100 days);
    bytes memory sigData = _createSourceData(validUntil, userOpData);
    userOpData.userOp.signature = sigData;
    executeOp(userOpData);
    uint256 accSharesAfter = vaultInstance.balanceOf(address(vaultBank));
    assertEq(accSharesAfter, amount);
}
```

## Related Implementations

### makeAccountInstance(bytes32)

- **Kind**: internal
- **Source**: 11712:1136:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:makeAccountInstance(bytes32)`

```solidity
/// @notice Create an account instance with the provided salt
///  @param salt The salt used to create the account
///  @return instance The account instance
function makeAccountInstance(bytes32 salt) internal initializeModuleKit() returns (AccountInstance memory instance) {
    (AccountType env, address accountFactoryAddress, address accountHelper) = ModuleKitHelpers.getAccountEnv();
    IAccountFactory accountFactory = IAccountFactory(accountFactoryAddress);
    bytes memory initData = accountFactory.getInitData(address(_defaultValidator), "");
    address account = accountFactory.getAddress(salt, initData);
    bytes memory initCode = abi.encodePacked(address(accountFactory), abi.encodeCall(accountFactory.createAccount, (salt, initData)));
    label(address(account), toString(salt));
    deal(account, 10 ether);
    instance = _makeAccountInstance({salt: salt, accountType: env, helper: accountHelper, account: account, initCode: initCode, validator: address(_defaultValidator), accountFactory: address(accountFactory), sessionValidator: address(_defaultSessionValidator)});
}
```

### getAccountEnv()

- **Kind**: internal
- **Source**: 29353:871:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getAccountEnv()`

```solidity
/// @notice Gets the account environment from storage
function getAccountEnv() internal view returns (AccountType env, address, address) {
    (bytes32 envHash, address factory, address helper) = getAccountEnvFromStorage();
    if (envHash == keccak256(abi.encodePacked(DEFAULT))) {
        return (AccountType.DEFAULT, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(SAFE))) {
        return (AccountType.SAFE, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(KERNEL))) {
        return (AccountType.KERNEL, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(CUSTOM))) {
        return (AccountType.CUSTOM, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(NEXUS))) {
        return (AccountType.NEXUS, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getAccountEnv()

- **Kind**: free-function
- **Source**: 3246:404:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getAccountEnv()`

```solidity
function getAccountEnv() view returns (bytes32 env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    assembly {
        env := sload(envSlot)
        factory := sload(factorySlot)
        helper := sload(helperSlot)
    }
}
```

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

### toString(bytes32)

- **Kind**: free-function
- **Source**: 4142:208:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(bytes32)`

```solidity
function toString(bytes32 input) pure returns (string memory) {
    bytes memory _bytes = new bytes(32);
    for (uint256 i = 0; i < 32; i++) {
        _bytes[i] = input[i];
    }
    return string(_bytes);
}
```

### deal(address,uint256)

- **Kind**: internal
- **Source**: 27055:91:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual internal {
    vm.deal(to, give);
}
```

### _makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)

- **Kind**: internal
- **Source**: 18993:828:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)`

```solidity
/// @notice Create an account instance with the provided salt, account, init code, account
///          factory, validator, session validator, account type, and helper
///  @param salt The salt used to create the account
///  @param account The address of the account
///  @param initCode The init code used to create the account
///  @param accountFactory The address of the account factory
///  @param validator The address of the validator
///  @param sessionValidator The address of the session validator
///  @param accountType The type of the account
///  @param helper The address of the account helper
///  @return instance The account instance
function _makeAccountInstance(bytes32 salt, address account, bytes memory initCode, address accountFactory, address validator, address sessionValidator, AccountType accountType, address helper) internal view returns (AccountInstance memory instance) {
    instance = AccountInstance({accountType: accountType, accountHelper: helper, account: account, aux: auxiliary, salt: salt, defaultValidator: IERC7579Validator(validator), initCode: initCode, accountFactory: accountFactory, smartSession: ISmartSession(SMARTSESSION_ADDR), defaultSessionValidator: ISessionValidator(sessionValidator)});
}
```

### initializeModuleKit()

- **Kind**: modifier
- **Source**: 20107:202:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:initializeModuleKit()`

```solidity
/// @dev Initialize the module kit with the provided environment if it has not been initialized
modifier initializeModuleKit() {
    if (!isInit[block.chainid]) {
        string memory _env = envOr("ACCOUNT_TYPE", DEFAULT);
        _initializeModuleKit(_env);
    }
    _;
}
```

### envOr(string,string)

- **Kind**: internal
- **Source**: 4081:166:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,string)`

```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### _initializeModuleKit(string)

- **Kind**: internal
- **Source**: 8404:2950:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_initializeModuleKit(string)`

```solidity
/// @notice Initialize the module kit with the provided environment, deploy the factories,
///          helpers, and validators, and stake them on the entrypoint
function _initializeModuleKit(string memory _env) internal {
    super.init();
    isInit[block.chainid] = true;
    writeFactory(address(new ERC7579Factory()), DEFAULT);
    writeFactory(address(new SafeFactory()), SAFE);
    writeFactory(address(new KernelFactory()), KERNEL);
    writeFactory(address(new NexusFactory()), NEXUS);
    writeFactory(address(new ERC7579Factory()), CUSTOM);
    writeHelper(address(new ERC7579Helpers()), DEFAULT);
    writeHelper(address(new SafeHelpers()), SAFE);
    writeHelper(address(new KernelHelpers()), KERNEL);
    writeHelper(address(new NexusHelpers()), NEXUS);
    writeHelper(address(new ERC7579Helpers()), CUSTOM);
    IAccountFactory safeFactory = IAccountFactory(getFactory(SAFE));
    IAccountFactory kernelFactory = IAccountFactory(getFactory(KERNEL));
    IAccountFactory erc7579Factory = IAccountFactory(getFactory(DEFAULT));
    IAccountFactory nexusFactory = IAccountFactory(getFactory(NEXUS));
    IAccountFactory customFactory = IAccountFactory(getFactory(CUSTOM));
    safeFactory.init();
    kernelFactory.init();
    erc7579Factory.init();
    nexusFactory.init();
    customFactory.init();
    label(address(safeFactory), "SafeFactory");
    label(address(kernelFactory), "KernelFactory");
    label(address(erc7579Factory), "ERC7579Factory");
    label(address(nexusFactory), "NexusFactory");
    label(address(customFactory), "CustomFactory");
    deal(address(safeFactory), 10 ether);
    deal(address(kernelFactory), 10 ether);
    deal(address(erc7579Factory), 10 ether);
    deal(address(nexusFactory), 10 ether);
    deal(address(customFactory), 10 ether);
    prank(address(safeFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(kernelFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(erc7579Factory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(nexusFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    ModuleKitHelpers.setAccountEnv(_env);
    IAccountFactory accountFactory = IAccountFactory(getFactory(_env));
    label(address(accountFactory), "AccountFactory");
    _defaultValidator = new MockValidator();
    label(address(_defaultValidator), "DefaultValidator");
    _defaultSessionValidator = new MockStatelessValidator();
    label(address(_defaultSessionValidator), "SessionValidator");
}
```

### init()

- **Kind**: internal
- **Source**: 1861:543:231
- **Link**: `lib/v2-core/lib/modulekit/src/test/Auxiliary.sol:AuxiliaryFactory:init()`

```solidity
/// @notice Initializes and labels all the auxiliary contracts.
function init() virtual internal {
    auxiliary.mockFactory = new MockFactory();
    label(address(auxiliary.mockFactory), "Mock Factory");
    auxiliary.gasSimulation = new UserOpGasLog();
    auxiliary.entrypoint = etchEntrypoint();
    label(address(auxiliary.entrypoint), "EntryPoint");
    auxiliary.registry = etchRegistry();
    label(address(auxiliary.registry), "ERC7484Registry");
    auxiliary.smartSession = etchSmartSessions();
    label(address(auxiliary.smartSession), "SmartSession");
}
```

### etchEntrypoint()

- **Kind**: free-function
- **Source**: 1312:297:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:etchEntrypoint()`

```solidity
function etchEntrypoint() returns (IEntryPoint) {
    address payable entryPoint = payable(address(new EntryPointSimulationsPatch()));
    etch(ENTRYPOINT_ADDR, entryPoint.code);
    EntryPointSimulationsPatch(payable(ENTRYPOINT_ADDR)).init(entryPoint);
    return IEntryPoint(ENTRYPOINT_ADDR);
}
```

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
}
```

### etchRegistry()

- **Kind**: free-function
- **Source**: 357:176:189
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/Registry.sol:etchRegistry()`

```solidity
function etchRegistry() returns (IERC7484) {
    address _registry = address(new MockRegistry());
    etch(REGISTRY_ADDR, _registry.code);
    return IERC7484(REGISTRY_ADDR);
}
```

### etchSmartSessions()

- **Kind**: free-function
- **Source**: 378:172:186
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/SmartSessionsPrecompiles.sol:etchSmartSessions()`

```solidity
function etchSmartSessions() returns (ISmartSession) {
    etch(address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE);
    return ISmartSession(SMARTSESSION_ADDR);
}
```

### writeFactory(address,string)

- **Kind**: free-function
- **Source**: 4416:204:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeFactory(address,string)`

```solidity
function writeFactory(address factory, string memory factoryType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        sstore(slot, factory)
    }
}
```

### writeHelper(address,string)

- **Kind**: free-function
- **Source**: 5007:198:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeHelper(address,string)`

```solidity
function writeHelper(address helper, string memory helperType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        sstore(slot, helper)
    }
}
```

### getFactory(string)

- **Kind**: free-function
- **Source**: 4622:217:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getFactory(string)`

```solidity
function getFactory(string memory factoryType) view returns (address factory) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        factory := sload(slot)
    }
}
```

### prank(address)

- **Kind**: free-function
- **Source**: 1619:63:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:prank(address)`

```solidity
function prank(address _addr) {
    Vm(VM_ADDR).prank(_addr);
}
```

### setAccountEnv(string)

- **Kind**: internal
- **Source**: 26858:87:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
///  @param env The string to set
function setAccountEnv(string memory env) internal {
    _setAccountEnv(env);
}
```

### _setAccountEnv(string)

- **Kind**: internal
- **Source**: 28352:937:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:_setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
function _setAccountEnv(string memory env) private {
    address factory = getFactory(env);
    address helper = getHelperFromStorage(env);
    if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(DEFAULT))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(SAFE))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(KERNEL))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(CUSTOM))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(NEXUS))) {
        writeAccountEnv(env, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getHelper(string)

- **Kind**: free-function
- **Source**: 5207:211:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getHelper(string)`

```solidity
function getHelper(string memory helperType) view returns (address helper) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        helper := sload(slot)
    }
}
```

### writeAccountEnv(string,address,address)

- **Kind**: free-function
- **Source**: 2791:453:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeAccountEnv(string,address,address)`

```solidity
function writeAccountEnv(string memory env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    bytes32 envHash = keccak256(abi.encodePacked(env));
    assembly {
        sstore(envSlot, envHash)
        sstore(factorySlot, factory)
        sstore(helperSlot, helper)
    }
}
```

### installModule(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 9158:632:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:installModule(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Installs a module on an account by generating a userOp and sending it to the
///          entrypoint
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param moduleTypeId The type of the module to install
///  @param module The address of the module to install
///  @param data Arbitrary data that may be required on the module during `onInstall`
///          initialization
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function installModule(AccountInstance memory instance, uint256 moduleTypeId, address module, bytes memory data) internal returns (UserOpData memory userOpData) {
    preEnvHook();
    userOpData = instance.getInstallModuleOps(moduleTypeId, module, data, address(instance.defaultValidator));
    userOpData = userOpData.signDefault();
    userOpData.entrypoint = instance.aux.entrypoint;
    userOpData.execUserOps();
}
```

### preEnvHook()

- **Kind**: internal
- **Source**: 7549:199:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:preEnvHook()`

```solidity
/// @notice A hook used to initiate state diff recording before installing a module
function preEnvHook() internal {
    if (envOr("COMPLIANCE", false) || getStorageCompliance()) {
        vmStartStateDiffRecording();
    }
}
```

### getStorageCompliance()

- **Kind**: free-function
- **Source**: 2450:172:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getStorageCompliance()`

```solidity
function getStorageCompliance() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.StorageCompliance");
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

### startStateDiffRecording()

- **Kind**: internal
- **Source**: 4253:96:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:startStateDiffRecording()`

```solidity
function startStateDiffRecording() public {
    Vm(VM_ADDR).startStateDiffRecording();
}
```

### getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address)

- **Kind**: internal
- **Source**: 14540:566:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address)`

```solidity
/// @notice Generates a userOp to install a module on an account
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param module The address of the module to install
///  @param initData Arbitrary data that may be required on the module during `onInstall`
///          initialization
///  @param txValidator The address of the transaction validator
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function getInstallModuleOps(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData, address txValidator) internal returns (UserOpData memory userOpData) {
    (userOpData.userOp, userOpData.userOpHash) = HelperBase(instance.accountHelper).configModuleUserOp(instance, moduleType, module, initData, true, txValidator);
    userOpData.entrypoint = instance.aux.entrypoint;
}
```

### signDefault(struct UserOpData)

- **Kind**: internal
- **Source**: 33955:186:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:signDefault(struct UserOpData)`

```solidity
/// @notice Adds a default signature to a UserOpData struct
///  @param userOpData UserOpData struct with the default signature added
function signDefault(UserOpData memory userOpData) internal pure returns (UserOpData memory) {
    userOpData.userOp.signature = "DEFAULT SIGNATURE";
    return userOpData;
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

### _bound(uint256)

- **Kind**: internal
- **Source**: 2682:144:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_bound(uint256)`

```solidity
function _bound(uint256 amount_) internal pure returns (uint256) {
    amount_ = bound(amount_, SMALL, LARGE);
    return amount_;
}
```

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2815:199:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1546:1263:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 9561:162:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
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

### _createSourceData(uint48,struct UserOpData)

- **Kind**: internal
- **Source**: 10641:921:571
- **Link**: `test/draft/test/unit/VaultBankFromExecutor.t.sol:VaultBankFromExecutor:_createSourceData(uint48,struct UserOpData)`

```solidity
function _createSourceData(uint48 validUntil, UserOpData memory userOpData) private view returns (bytes memory signatureData) {
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = _createSourceValidatorLeaf(userOpData.userOpHash, validUntil, 0, new uint64[](0), address(validator));
    (bytes32[][] memory merkleProof, bytes32 merkleRoot) = _createValidatorMerkleTree(leaves);
    bytes memory signature = _createSignature(SuperValidatorBase(address(validator)).namespace(), merkleRoot, signer, signerPrvKey);
    uint64[] memory chainsWithDestExecutionNone = new uint64[](0);
    ISuperValidator.DstProof[] memory proofDst = new ISuperValidator.DstProof[](0);
    signatureData = abi.encode(chainsWithDestExecutionNone, validUntil, 0, merkleRoot, merkleProof[0], proofDst, signature);
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

### executeOp(struct UserOpData)

- **Kind**: internal
- **Source**: 2902:141:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:executeOp(struct UserOpData)`

```solidity
function executeOp(UserOpData memory userOpData) public returns (ExecutionReturnData memory) {
    return userOpData.execUserOps();
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

- **SuperRegistry::addVaultBank(uint64,address)**
- **IERC4626::balanceOf(address)**

## State Variable Reads

- **superExecutor** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **validator** (`contract SuperValidator`) [lib/v2-core/src/validators/SuperValidator.sol/contract_SuperValidator.md]
- **signer** (`address`)
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract VaultBank`) [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]
- **mintSuperPositionsHook** (`address`)
- **yieldSourceAddress** (`address`)
- **vaultInstance** (`contract IERC4626`) [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **isInit** (`mapping(uint256 => bool)`)
- **VM_ADDR** (`address`)
- **auxiliary** (`struct Auxiliary`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **UINT256_MAX** (`uint256`)
- **stdstore** (`struct StdStorage`)
- **signerPrvKey** (`uint256`)

## State Variable Writes

- **isInit** (`mapping(uint256 => bool)`)
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **auxiliary** (`struct Auxiliary`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankFromExecutor.test_ShouldExecuteAll_AndLockAssetsInVaultBank_Test1ExistingShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 1)
  │   💬 Args: [keccak256(abi.encode("TEST"))]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 3)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 4)
  │ │   💬 Args: [address(account), toString(salt)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 5)
  │ │     💬 Args: [salt]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 6)
  │ │   💬 Args: [account, 10 ether]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 7)
  │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 8)
  │     💬 Args: [no args]
  │   ├─ [3] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 9)
  │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 10)
  │       💬 Args: [_env]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 11)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 12)
  │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │     │ │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 13)
  │     │ │   💬 Args: [no args]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 14)
  │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │     │ │     👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 15)
  │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │     │ │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 16)
  │     │ │   💬 Args: [no args]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 17)
  │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │     │ │     👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 18)
  │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │     │ │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 19)
  │     │ │   💬 Args: [no args]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 20)
  │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 21)
  │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 22)
  │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 23)
  │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 24)
  │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 25)
  │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 26)
  │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 27)
  │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 28)
  │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 29)
  │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 30)
  │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 31)
  │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 32)
  │     │   💬 Args: [SAFE]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 33)
  │     │   💬 Args: [KERNEL]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 34)
  │     │   💬 Args: [DEFAULT]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 35)
  │     │   💬 Args: [NEXUS]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 36)
  │     │   💬 Args: [CUSTOM]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 37)
  │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 38)
  │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 39)
  │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 40)
  │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 41)
  │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 42)
  │     │   💬 Args: [address(safeFactory), 10 ether]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 43)
  │     │   💬 Args: [address(kernelFactory), 10 ether]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 44)
  │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 45)
  │     │   💬 Args: [address(nexusFactory), 10 ether]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 46)
  │     │   💬 Args: [address(customFactory), 10 ether]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 47)
  │     │   💬 Args: [address(safeFactory)]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 48)
  │     │   💬 Args: [address(kernelFactory)]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 49)
  │     │   💬 Args: [address(erc7579Factory)]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 50)
  │     │   💬 Args: [address(nexusFactory)]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 51)
  │     │   💬 Args: [_env]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 52)
  │     │     💬 Args: [env]
  │     │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 53)
  │     │   │   💬 Args: [env]
  │     │   │   👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 54)
  │     │   │   💬 Args: [env]
  │     │   │   👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 55)
  │     │   │   💬 Args: [env, factory, helper]
  │     │   │   👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 56)
  │     │   │   💬 Args: [env, factory, helper]
  │     │   │   👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 57)
  │     │   │   💬 Args: [env, factory, helper]
  │     │   │   👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 58)
  │     │   │   💬 Args: [env, factory, helper]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 59)
  │     │       💬 Args: [env, factory, helper]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 60)
  │     │   💬 Args: [_env]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 61)
  │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 62)
  │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 63)
  │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 64)
  │   💬 Args: [testInstance, MODULE_TYPE_EXECUTOR, address(superExecutor), ""]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 65)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 66)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 67)
  │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 68)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 69)
  │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 70)
  │ │   💬 Args: [userOpData]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 71)
  │     💬 Args: [userOpData]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 72)
  │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 73)
  │         💬 Args: [userOps, onEntryPoint]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 74)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 75)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 76)
  │       │   💬 Args: ["SIMULATE", false]
  │       │   👁️  Def: public
  │       ├─ [5] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 77)
  │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 78)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 79)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 80)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 81)
  │       │ │     💬 Args: [no args]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 82)
  │       │     💬 Args: [userOpDetails]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 83)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 84)
  │       │   │   💬 Args: [userOpDetails, debugTrace]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 85)
  │       │   │ │   💬 Args: [userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 86)
  │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 87)
  │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 88)
  │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 89)
  │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: private
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 90)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 91)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 92)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 93)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 94)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 95)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 96)
  │       │   │ │   💬 Args: [filteredUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 97)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 98)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 99)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 100)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 101)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 102)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 103)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 104)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 105)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 106)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 107)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 108)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 109)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 110)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 111)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 112)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 113)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 114)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 115)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 116)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 117)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 118)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 119)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 120)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 121)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 122)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 123)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 124)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 125)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 126)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 127)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 128)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 129)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 130)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 131)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 132)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 133)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 134)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 135)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 136)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 137)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 138)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 139)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 140)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 141)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 142)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 143)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 144)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 145)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 146)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 147)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 148)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 149)
  │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 150)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 151)
  │       │       💬 Args: [snapShotId]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 152)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 153)
  │       │   💬 Args: [ctx.returnData]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 154)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 155)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 156)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 157)
  │       │   💬 Args: [logs, userOpHash]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 158)
  │       │   💬 Args: [account]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 159)
  │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 162)
  │       │ │   💬 Args: [logs, userOpHash]
  │       │ │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 160)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 161)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 163)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 164)
  │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 165)
  │       │   💬 Args: [logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 166)
  │       │   💬 Args: [j, logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 167)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 168)
  │       │     💬 Args: [slot]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 169)
  │       │   💬 Args: ["GAS", false]
  │       │   👁️  Def: public
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 170)
  │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 171)
  │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 172)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 173)
  │           │ │   💬 Args: [data]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 174)
  │           │     💬 Args: [compressed]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 175)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 176)
  │           │ │   💬 Args: [0.684e18]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 177)
  │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 178)
  │           │   │   💬 Args: [getCallDataGas(data)]
  │           │   │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 179)
  │           │   │     💬 Args: [data]
  │           │   │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 180)
  │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │           │       👁️  Def: internal
  │           │     └─ [10] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 181)
  │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │           │         👁️  Def: internal
  │           │       └─ [11] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 182)
  │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │           │           👁️  Def: internal
  │           │         ├─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 183)
  │           │         │   💬 Args: [x]
  │           │         │   👁️  Def: internal
  │           │         └─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 184)
  │           │             💬 Args: [y]
  │           │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 185)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 186)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 187)
  │           │   💬 Args: [fileContent]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 188)
  │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 189)
  │           │ │     💬 Args: [fileContent, ".Total"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 190)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 191)
  │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 192)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 193)
  │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 194)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 195)
  │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 196)
  │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 197)
  │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 198)
  │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │           │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 199)
  │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 200)
  │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 201)
  │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 202)
  │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 203)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 204)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 205)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 206)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 207)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 208)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 209)
  │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 210)
  │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 211)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 212)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 213)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 214)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 215)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 216)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 217)
  │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 218)
  │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 219)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 220)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 221)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 222)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 223)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 224)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 225)
  │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 226)
  │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 227)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 228)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 229)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 230)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 231)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 232)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 233)
  │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 234)
  │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 235)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 236)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 237)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 238)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 239)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 240)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 241)
  │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 242)
  │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 243)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 244)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 245)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 246)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 247)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 248)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 249)
  │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 250)
  │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 251)
  │           │   💬 Args: [finalJson, fileName]
  │           │   👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 252)
  │               💬 Args: [""]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 253)
  │                 💬 Args: [slot, id]
  │                 👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 254)
  │   💬 Args: [testInstance, MODULE_TYPE_VALIDATOR, address(validator), abi.encode(signer)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 255)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 256)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 257)
  │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 258)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 259)
  │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 260)
  │ │   💬 Args: [userOpData]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 261)
  │     💬 Args: [userOpData]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 262)
  │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 263)
  │         💬 Args: [userOps, onEntryPoint]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 264)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 265)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 266)
  │       │   💬 Args: ["SIMULATE", false]
  │       │   👁️  Def: public
  │       ├─ [5] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 267)
  │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 268)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 269)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 270)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 271)
  │       │ │     💬 Args: [no args]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 272)
  │       │     💬 Args: [userOpDetails]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 273)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 274)
  │       │   │   💬 Args: [userOpDetails, debugTrace]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 275)
  │       │   │ │   💬 Args: [userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 276)
  │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 277)
  │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 278)
  │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 279)
  │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: private
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 280)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 281)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 282)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 283)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 284)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 285)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 286)
  │       │   │ │   💬 Args: [filteredUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 287)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 288)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 289)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 290)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 291)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 292)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 293)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 294)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 295)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 296)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 297)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 298)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 299)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 300)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 301)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 302)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 303)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 304)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 305)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 306)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 307)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 308)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 309)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 310)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 311)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 312)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 313)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 314)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 315)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 316)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 317)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 318)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 319)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 320)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 321)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 322)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 323)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 324)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 325)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 326)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 327)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 328)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 329)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 330)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 331)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 332)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 333)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 334)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 335)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 336)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 337)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 338)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 339)
  │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 340)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 341)
  │       │       💬 Args: [snapShotId]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 342)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 343)
  │       │   💬 Args: [ctx.returnData]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 344)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 345)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 346)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 347)
  │       │   💬 Args: [logs, userOpHash]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 348)
  │       │   💬 Args: [account]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 349)
  │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 352)
  │       │ │   💬 Args: [logs, userOpHash]
  │       │ │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 350)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 351)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 353)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 354)
  │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 355)
  │       │   💬 Args: [logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 356)
  │       │   💬 Args: [j, logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 357)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 358)
  │       │     💬 Args: [slot]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 359)
  │       │   💬 Args: ["GAS", false]
  │       │   👁️  Def: public
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 360)
  │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 361)
  │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 362)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 363)
  │           │ │   💬 Args: [data]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 364)
  │           │     💬 Args: [compressed]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 365)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 366)
  │           │ │   💬 Args: [0.684e18]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 367)
  │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 368)
  │           │   │   💬 Args: [getCallDataGas(data)]
  │           │   │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 369)
  │           │   │     💬 Args: [data]
  │           │   │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 370)
  │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │           │       👁️  Def: internal
  │           │     └─ [10] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 371)
  │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │           │         👁️  Def: internal
  │           │       └─ [11] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 372)
  │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │           │           👁️  Def: internal
  │           │         ├─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 373)
  │           │         │   💬 Args: [x]
  │           │         │   👁️  Def: internal
  │           │         └─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 374)
  │           │             💬 Args: [y]
  │           │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 375)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 376)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 377)
  │           │   💬 Args: [fileContent]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 378)
  │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 379)
  │           │ │     💬 Args: [fileContent, ".Total"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 380)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 381)
  │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 382)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 383)
  │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 384)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 385)
  │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 386)
  │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 387)
  │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 388)
  │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │           │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 389)
  │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 390)
  │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 391)
  │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 392)
  │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 393)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 394)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 395)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 396)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 397)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 398)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 399)
  │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 400)
  │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 401)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 402)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 403)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 404)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 405)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 406)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 407)
  │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 408)
  │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 409)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 410)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 411)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 412)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 413)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 414)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 415)
  │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 416)
  │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 417)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 418)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 419)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 420)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 421)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 422)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 423)
  │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 424)
  │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 425)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 426)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 427)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 428)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 429)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 430)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 431)
  │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 432)
  │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 433)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 434)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 435)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 436)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 437)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 438)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 439)
  │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 440)
  │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 441)
  │           │   💬 Args: [finalJson, fileName]
  │           │   👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 442)
  │               💬 Args: [""]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 443)
  │                 💬 Args: [slot, id]
  │                 👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._bound(uint256) (NodeID: 444)
  │   💬 Args: [amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 445)
  │     💬 Args: [amount_, SMALL, LARGE]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 446)
  │   │   💬 Args: [x, min, max]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 447)
  │       💬 Args: ["Bound result", result]
  │       👁️  Def: private
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 448)
  │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 449)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 450)
  │   💬 Args: [yieldSourceAddress, testAccount, amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 451)
  │     💬 Args: [token_, to_, amount_]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 452)
  │       💬 Args: [token, to, give, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 453)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 454)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 455)
  │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 456)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 457)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 458)
  │     │     💬 Args: [self, who]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 459)
  │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 460)
  │     │     💬 Args: [self, bytes32(amt)]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 461)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 462)
  │     │   │     💬 Args: [self._keys]
  │     │   │     👁️  Def: private
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 463)
  │     │   │   💬 Args: [self, false]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 464)
  │     │   │     💬 Args: [self, _clear]
  │     │   │     👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 465)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 466)
  │     │   │   │     💬 Args: [self._keys]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 467)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 468)
  │     │   │   │   💬 Args: [self]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 469)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 470)
  │     │   │   │ │     💬 Args: [self._keys]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 471)
  │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │     👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 472)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 473)
  │     │   │   │ │   💬 Args: [self]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 474)
  │     │   │   │ │ │   💬 Args: [self]
  │     │   │   │ │ │   👁️  Def: internal
  │     │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 475)
  │     │   │   │ │ │     💬 Args: [self._keys]
  │     │   │   │ │ │     👁️  Def: private
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 476)
  │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │     👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 477)
  │     │   │   │     💬 Args: [self]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 478)
  │     │   │   │   │   💬 Args: [self]
  │     │   │   │   │   👁️  Def: internal
  │     │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 479)
  │     │   │   │   │     💬 Args: [self._keys]
  │     │   │   │   │     👁️  Def: private
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 480)
  │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │       👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 481)
  │     │   │   │   💬 Args: [self, reads[i]]
  │     │   │   │   👁️  Def: internal
  │     │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 482)
  │     │   │   │ │   💬 Args: [self, slot, true]
  │     │   │   │ │   👁️  Def: internal
  │     │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 483)
  │     │   │   │ │     💬 Args: [self]
  │     │   │   │ │     👁️  Def: internal
  │     │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 484)
  │     │   │   │ │   │   💬 Args: [self]
  │     │   │   │ │   │   👁️  Def: internal
  │     │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 485)
  │     │   │   │ │   │     💬 Args: [self._keys]
  │     │   │   │ │   │     👁️  Def: private
  │     │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 486)
  │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │     │   │   │ │       👁️  Def: private
  │     │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 487)
  │     │   │   │     💬 Args: [self, slot, false]
  │     │   │   │     👁️  Def: internal
  │     │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 488)
  │     │   │   │       💬 Args: [self]
  │     │   │   │       👁️  Def: internal
  │     │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 489)
  │     │   │   │     │   💬 Args: [self]
  │     │   │   │     │   👁️  Def: internal
  │     │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 490)
  │     │   │   │     │     💬 Args: [self._keys]
  │     │   │   │     │     👁️  Def: private
  │     │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 491)
  │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │     │   │   │         👁️  Def: private
  │     │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 492)
  │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │     │   │   │   👁️  Def: internal
  │     │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 493)
  │     │   │       💬 Args: [self]
  │     │   │       👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 494)
  │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │     │   │   👁️  Def: internal
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 495)
  │     │   │     💬 Args: [offsetLeft, offsetRight]
  │     │   │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 496)
  │     │   │   💬 Args: [self]
  │     │   │   👁️  Def: internal
  │     │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 497)
  │     │   │ │   💬 Args: [self]
  │     │   │ │   👁️  Def: internal
  │     │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 498)
  │     │   │ │     💬 Args: [self._keys]
  │     │   │ │     👁️  Def: private
  │     │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 499)
  │     │   │     💬 Args: [rdat, 32 * self._depth]
  │     │   │     👁️  Def: private
  │     │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 500)
  │     │       💬 Args: [self]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 501)
  │     │         💬 Args: [self]
  │     │         👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 502)
  │     │   💬 Args: [stdstore, token]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 503)
  │     │     💬 Args: [self, _target]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 504)
  │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 505)
  │     │     💬 Args: [self, _sig]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 506)
  │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 507)
  │           💬 Args: [self, bytes32(amt)]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 508)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 509)
  │         │     💬 Args: [self._keys]
  │         │     👁️  Def: private
  │         ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 510)
  │         │   💬 Args: [self, false]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 511)
  │         │     💬 Args: [self, _clear]
  │         │     👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 512)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 513)
  │         │   │     💬 Args: [self._keys]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 514)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 515)
  │         │   │   💬 Args: [self]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 516)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 517)
  │         │   │ │     💬 Args: [self._keys]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 518)
  │         │   │     💬 Args: [rdat, 32 * self._depth]
  │         │   │     👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 519)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 520)
  │         │   │ │   💬 Args: [self]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 521)
  │         │   │ │ │   💬 Args: [self]
  │         │   │ │ │   👁️  Def: internal
  │         │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 522)
  │         │   │ │ │     💬 Args: [self._keys]
  │         │   │ │ │     👁️  Def: private
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 523)
  │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │         │   │ │     👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 524)
  │         │   │     💬 Args: [self]
  │         │   │     👁️  Def: internal
  │         │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 525)
  │         │   │   │   💬 Args: [self]
  │         │   │   │   👁️  Def: internal
  │         │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 526)
  │         │   │   │     💬 Args: [self._keys]
  │         │   │   │     👁️  Def: private
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 527)
  │         │   │       💬 Args: [rdat, 32 * self._depth]
  │         │   │       👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 528)
  │         │   │   💬 Args: [self, reads[i]]
  │         │   │   👁️  Def: internal
  │         │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 529)
  │         │   │ │   💬 Args: [self, slot, true]
  │         │   │ │   👁️  Def: internal
  │         │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 530)
  │         │   │ │     💬 Args: [self]
  │         │   │ │     👁️  Def: internal
  │         │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 531)
  │         │   │ │   │   💬 Args: [self]
  │         │   │ │   │   👁️  Def: internal
  │         │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 532)
  │         │   │ │   │     💬 Args: [self._keys]
  │         │   │ │   │     👁️  Def: private
  │         │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 533)
  │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │         │   │ │       👁️  Def: private
  │         │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 534)
  │         │   │     💬 Args: [self, slot, false]
  │         │   │     👁️  Def: internal
  │         │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 535)
  │         │   │       💬 Args: [self]
  │         │   │       👁️  Def: internal
  │         │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 536)
  │         │   │     │   💬 Args: [self]
  │         │   │     │   👁️  Def: internal
  │         │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 537)
  │         │   │     │     💬 Args: [self._keys]
  │         │   │     │     👁️  Def: private
  │         │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 538)
  │         │   │         💬 Args: [rdat, 32 * self._depth]
  │         │   │         👁️  Def: private
  │         │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 539)
  │         │   │   💬 Args: [offsetLeft, offsetRight]
  │         │   │   👁️  Def: internal
  │         │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 540)
  │         │       💬 Args: [self]
  │         │       👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 541)
  │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 542)
  │         │     💬 Args: [offsetLeft, offsetRight]
  │         │     👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 543)
  │         │   💬 Args: [self]
  │         │   👁️  Def: internal
  │         │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 544)
  │         │ │   💬 Args: [self]
  │         │ │   👁️  Def: internal
  │         │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 545)
  │         │ │     💬 Args: [self._keys]
  │         │ │     👁️  Def: private
  │         │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 546)
  │         │     💬 Args: [rdat, 32 * self._depth]
  │         │     👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 547)
  │             💬 Args: [self]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 548)
  │               💬 Args: [self]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._createApproveAndLockVaultBankHookData(bytes32,address,uint256,bool,address,uint256) (NodeID: 549)
  │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), yieldSourceAddress, amount, false, address(vaultBank), 8453]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 550)
  │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers._getExecOpsWithValidator(struct AccountInstance,contract ISuperExecutor,bytes,address) (NodeID: 551)
  │   💬 Args: [testInstance, superExecutor, abi.encode(entry), address(validator)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 552)
  │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), validator]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: VaultBankFromExecutor._createSourceData(uint48,struct UserOpData) (NodeID: 553)
  │   💬 Args: [validUntil, userOpData]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeHelper._createSourceValidatorLeaf(bytes32,uint48,uint48,uint64[],address) (NodeID: 554)
  │ │   💬 Args: [userOpData.userOpHash, validUntil, 0, new uint64[](0), address(validator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeHelper._createValidatorMerkleTree(bytes32[]) (NodeID: 555)
  │ │   💬 Args: [leaves]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MerkleTreeHelper._sortAndHashPair(bytes32,bytes32) (NodeID: 556)
  │ │ │   💬 Args: [tree[level][2 * i], tree[level][(2 * i) + 1]]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MerkleTreeHelper._generateProof(uint256,bytes32[][]) (NodeID: 557)
  │ │     💬 Args: [i, tree]
  │ │     👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SignatureHelper._createSignature(string,bytes32,address,uint256) (NodeID: 558)
  │     💬 Args: [SuperValidatorBase(address(validator)).namespace(), merkleRoot, signer, signerPrvKey]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toEthSignedMessageHash(bytes32) (NodeID: 559)
  │   │   💬 Args: [messageHash]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 560)
  │   │   💬 Args: [ethSignedMessageHash, signature]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 561)
  │   │ │   💬 Args: [hash, signature]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 562)
  │   │ │     💬 Args: [hash, v, r, s]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 563)
  │   │     💬 Args: [error, errorArg]
  │   │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 564)
  │       💬 Args: [_expectedSigner, signer, "Signature should be valid"]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 565)
  │   💬 Args: [userOpData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 566)
  │     💬 Args: [userOpData]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 567)
  │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 568)
  │         💬 Args: [userOps, onEntryPoint]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 569)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 570)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 571)
  │       │   💬 Args: ["SIMULATE", false]
  │       │   👁️  Def: public
  │       ├─ [5] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 572)
  │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 573)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 574)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 575)
  │       │ │ │   💬 Args: [no args]
  │       │ │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 576)
  │       │ │     💬 Args: [no args]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 577)
  │       │     💬 Args: [userOpDetails]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 578)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 579)
  │       │   │   💬 Args: [userOpDetails, debugTrace]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 580)
  │       │   │ │   💬 Args: [userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 581)
  │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 582)
  │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 583)
  │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 584)
  │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: private
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 585)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 586)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 587)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 588)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 589)
  │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │       │   │ │ │   👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 590)
  │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 591)
  │       │   │ │   💬 Args: [filteredUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 592)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │       │   │ │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 593)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 594)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 595)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 596)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 597)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 598)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 599)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 600)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 601)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 602)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 603)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 604)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 605)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 606)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 607)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 608)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 609)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 610)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 611)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 612)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 613)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 614)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 615)
  │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 616)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 617)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 618)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 619)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 620)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 621)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 622)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 623)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 624)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 625)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 626)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 627)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 628)
  │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 629)
  │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 630)
  │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ ├─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 631)
  │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │       │   │ │ │ │ │   👁️  Def: internal
  │       │   │ │ │ │ └─ [11] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 632)
  │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │       │   │ │ │ │     👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 633)
  │       │   │ │ │     💬 Args: [key, entity]
  │       │   │ │ │     👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 634)
  │       │   │ │     💬 Args: [currentAccessAccount]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 635)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 636)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 637)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 638)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 639)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 640)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 641)
  │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 642)
  │       │   │ │     💬 Args: [targetAddr]
  │       │   │ │     👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 643)
  │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │       │   │ │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 644)
  │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │       │   │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 645)
  │       │   │   💬 Args: [no args]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 646)
  │       │       💬 Args: [snapShotId]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 647)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 648)
  │       │   💬 Args: [ctx.returnData]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 649)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 650)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 651)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 652)
  │       │   💬 Args: [logs, userOpHash]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 653)
  │       │   💬 Args: [account]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 654)
  │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 657)
  │       │ │   💬 Args: [logs, userOpHash]
  │       │ │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 655)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 656)
  │       │     💬 Args: [actualReason, revertMessage]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 658)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 659)
  │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 660)
  │       │   💬 Args: [logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 661)
  │       │   💬 Args: [j, logs[i].emitter]
  │       │   👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 662)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 663)
  │       │     💬 Args: [slot]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 664)
  │       │   💬 Args: ["GAS", false]
  │       │   👁️  Def: public
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 665)
  │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 666)
  │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 667)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 668)
  │           │ │   💬 Args: [data]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 669)
  │           │     💬 Args: [compressed]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 670)
  │           │   💬 Args: [userOpCalldata]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 671)
  │           │ │   💬 Args: [0.684e18]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 672)
  │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 673)
  │           │   │   💬 Args: [getCallDataGas(data)]
  │           │   │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 674)
  │           │   │     💬 Args: [data]
  │           │   │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 675)
  │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │           │       👁️  Def: internal
  │           │     └─ [10] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 676)
  │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │           │         👁️  Def: internal
  │           │       └─ [11] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 677)
  │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │           │           👁️  Def: internal
  │           │         ├─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 678)
  │           │         │   💬 Args: [x]
  │           │         │   👁️  Def: internal
  │           │         └─ [12] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 679)
  │           │             💬 Args: [y]
  │           │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 680)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 681)
  │           │   💬 Args: [fileName]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 682)
  │           │   💬 Args: [fileContent]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 683)
  │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 684)
  │           │ │     💬 Args: [fileContent, ".Total"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 685)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 686)
  │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 687)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 688)
  │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 689)
  │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 690)
  │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │           │ │     👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 691)
  │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 692)
  │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 693)
  │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │           │     👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 694)
  │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 695)
  │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 696)
  │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 697)
  │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 698)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 699)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 700)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 701)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 702)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 703)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 704)
  │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 705)
  │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 706)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 707)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 708)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 709)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 710)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 711)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 712)
  │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 713)
  │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 714)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 715)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 716)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 717)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 718)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 719)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 720)
  │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 721)
  │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 722)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 723)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 724)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 725)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 726)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 727)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 728)
  │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 729)
  │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 730)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 731)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 732)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 733)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 734)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 735)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 736)
  │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │           │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 737)
  │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │           │ │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 738)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 739)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   ├─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 740)
  │           │ │   │   💬 Args: [int256(newValue)]
  │           │ │   │   👁️  Def: internal
  │           │ │   │ └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 741)
  │           │ │   │     💬 Args: [value]
  │           │ │   │     👁️  Def: internal
  │           │ │   └─ [10] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 742)
  │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │           │ │       👁️  Def: internal
  │           │ │     └─ [11] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 743)
  │           │ │         💬 Args: [value]
  │           │ │         👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 744)
  │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 745)
  │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 746)
  │           │   💬 Args: [finalJson, fileName]
  │           │   👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 747)
  │               💬 Args: [""]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 748)
  │                 💬 Args: [slot, id]
  │                 👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 749)
      💬 Args: [accSharesAfter, amount]
      👁️  Def: internal
```
