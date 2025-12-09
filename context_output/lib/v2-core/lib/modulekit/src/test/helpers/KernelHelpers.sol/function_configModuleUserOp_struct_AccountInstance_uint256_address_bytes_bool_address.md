# Function: configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)`
- **Visibility**: public
- **Source Range**: 7104:2163:236

## Implementation

```solidity
/// @notice Configures a userop for an account instance to install or uninstall a module
///  @param instance AccountInstance the account instance to configure the userop for
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module
///  @param initData bytes the data to pass to the module
///  @param isInstall bool whether to install or uninstall the module
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the packed user operation
///  @return userOpHash bytes32 the hash of the user operation
function configModuleUserOp(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData, bool isInstall, address txValidator) virtual override public returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    if (instance.account.code.length == 0) {
        initCode = instance.initCode;
    }
    bytes memory callData;
    if (isInstall) {
        initData = getInstallModuleData({instance: instance, moduleType: moduleType, module: module, initData: initData});
        callData = getInstallModuleCallData({instance: instance, moduleType: moduleType, module: module, initData: initData});
    } else {
        initData = getUninstallModuleData({instance: instance, moduleType: moduleType, module: module, initData: initData});
        callData = getUninstallModuleCallData({instance: instance, moduleType: moduleType, module: module, initData: initData});
    }
    address execHook = getExecHook(instance, txValidator);
    if ((execHook != address(0)) && (execHook != address(1))) {
        callData = abi.encodePacked(IKernel.executeUserOp.selector, callData);
    }
    userOp = PackedUserOperation({sender: instance.account, nonce: getNonce(instance, callData, txValidator), initCode: initCode, callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
    userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
}
```

## Related Implementations

### getInstallModuleData(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 14183:1139:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallModuleData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Gets the data to install a module on an ERC7579 Account, based on the module type
///  @param instance AccountInstance the account instance to install the module on
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return data bytes the data to install the module
function getInstallModuleData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory) {
    if (moduleType == MODULE_TYPE_VALIDATOR) {
        return getInstallValidatorData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_EXECUTOR) {
        return getInstallExecutorData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_HOOK) {
        return getInstallHookData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_FALLBACK) {
        return getInstallFallbackData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_PREVALIDATION_HOOK_ERC1271) {
        return getInstallPrevalidationHookERC1271Data(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_PREVALIDATION_HOOK_ERC4337) {
        return getInstallPrevalidationHookERC4337Data(instance, module, initData);
    } else {
        revert("Invalid module type");
    }
}
```

### getInstallValidatorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 10859:384:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getInstallValidatorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install a validator on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L311-L321
///  @param instance AccountInstance the account instance to install the validator on
///  implementation)
///  @param initData the data to pass to the validator
///  @return data the data to install the validator
function getInstallValidatorData(AccountInstance memory instance, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encodePacked(getHookMultiPlexer(instance), abi.encode(initData, hex"00", bytes(hex"00000001")));
}
```

### getHookMultiPlexer(struct AccountInstance)

- **Kind**: internal
- **Source**: 20760:180:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getHookMultiPlexer(struct AccountInstance)`

```solidity
/// @notice Gets the hook multiplexer for an account instance
///  @param instance AccountInstance the account instance to get the hook multiplexer for
///  @return address the address of the hook multiplexer
function getHookMultiPlexer(AccountInstance memory instance) public view returns (address) {
    return address(KernelFactory(instance.accountFactory).hookMultiPlexer());
}
```

### getInstallExecutorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 11655:388:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getInstallExecutorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install an executor on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L324-L334
///  @param instance AccountInstance the account instance to install the executor on
///  @param initData the data to pass to the executor
///  @return data the data to install the executor
function getInstallExecutorData(AccountInstance memory instance, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encodePacked(getHookMultiPlexer(instance), abi.encode(initData, abi.encodePacked(bytes1(0x00), "")));
}
```

### getInstallHookData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 8465:252:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallHookData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install hook on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the hook
function getInstallHookData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getInstallFallbackData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 12454:583:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getInstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install a fallback on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L336-L345
///  @param instance AccountInstance the account instance to install the fallback on
///  @param initData the data to pass to the fallback
///  @return data the data to install the fallback
function getInstallFallbackData(AccountInstance memory instance, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    (bytes4 selector, CallType callType, bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, getHookMultiPlexer(instance), abi.encode(abi.encodePacked(callType, _initData), abi.encodePacked(bytes1(0x00), "")));
}
```

### getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 10310:272:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC1271
function getInstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 10809:272:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install an ERC4337 prevalidation hook ERC4337
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC4337
function getInstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 14176:1239:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Gets the data to install a module on an account instance
///  @param instance AccountInstance the account instance to install the module on
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return callData the data to install the module
function getInstallModuleCallData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual override public view returns (bytes memory callData) {
    if (moduleType == MODULE_TYPE_HOOK) {
        Execution[] memory executions = new Execution[](3);
        executions[0] = Execution({target: getHookMultiPlexer(instance), value: 0, callData: abi.encodeCall(MockHookMultiPlexer.addHook, (module))});
        executions[1] = Execution({target: module, value: 0, callData: abi.encodeCall(IModule.onInstall, (initData))});
        executions[2] = Execution({target: module, value: 0, callData: abi.encodeCall(TrustedForwarder.setTrustedForwarder, (getHookMultiPlexer(instance)))});
        callData = encode({executions: executions});
    } else {
        callData = abi.encodeCall(IERC7579Account.installModule, (moduleType, module, initData));
    }
}
```

### encode(struct Execution[])

- **Kind**: internal
- **Source**: 21481:444:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:encode(struct Execution[])`

```solidity
/// @notice Encode a batch of ERC7579 Execution Transactions
///  @param executions Execution[] the array of executions
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(Execution[] memory executions) virtual public pure returns (bytes memory erc7579Tx) {
    ModeCode mode = ModeLib.encode({callType: CALLTYPE_BATCH, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    return abi.encodeCall(IERC7579Account.execute, (mode, abi.encode(executions)));
}
```

### encode(CallType,ExecType,ModeSelector,ModePayload)

- **Kind**: internal
- **Source**: 4337:376:150
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/common/lib/ModeLib.sol:ModeLib:encode(CallType,ExecType,ModeSelector,ModePayload)`

```solidity
function encode(CallType callType, ExecType execType, ModeSelector mode, ModePayload payload) internal pure returns (ModeCode) {
    return ModeCode.wrap(bytes32(abi.encodePacked(callType, execType, bytes4(0), ModeSelector.unwrap(mode), payload)));
}
```

### getUninstallModuleData(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 15765:1153:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallModuleData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Gets the data to uninstall a module on an ERC7579 Account, based on the module type
///  @param instance AccountInstance the account instance to uninstall the module from
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return data bytes the data to uninstall the module
function getUninstallModuleData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory) {
    if (moduleType == MODULE_TYPE_VALIDATOR) {
        return getUninstallValidatorData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_EXECUTOR) {
        return getUninstallExecutorData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_HOOK) {
        return getUninstallHookData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_FALLBACK) {
        return getUninstallFallbackData(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_PREVALIDATION_HOOK_ERC1271) {
        return getUninstallPrevalidationHookERC1271Data(instance, module, initData);
    } else if (moduleType == MODULE_TYPE_PREVALIDATION_HOOK_ERC4337) {
        return getUninstallPrevalidationHookERC4337Data(instance, module, initData);
    } else {
        revert("Invalid module type");
    }
}
```

### getUninstallValidatorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 7089:259:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallValidatorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall a validator on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the validator
function getUninstallValidatorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getUninstallExecutorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 8013:258:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallExecutorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall executor on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the executor
function getUninstallExecutorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getUninstallHookData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 8915:254:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallHookData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall hook on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the hook
function getUninstallHookData(AccountInstance memory, address, bytes memory initData) virtual public pure returns (bytes memory data) {
    data = initData;
}
```

### getUninstallFallbackData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 13364:406:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getUninstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to uninstall a fallback on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L402-L403
///  @param initData the data to pass to the fallback
///  @return data the data to uninstall the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, _initData);
}
```

### getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 11304:274:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC1271
function getUninstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 11801:274:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall an ERC4337 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC4337
function getUninstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 15831:1200:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Gets the data to uninstall a module on an account instance
///  @param instance AccountInstance the account instance to uninstall the module from
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return callData the data to uninstall the module
function getUninstallModuleCallData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual override public view returns (bytes memory callData) {
    if (moduleType == MODULE_TYPE_HOOK) {
        Execution[] memory executions = new Execution[](3);
        executions[0] = Execution({target: getHookMultiPlexer(instance), value: 0, callData: abi.encodeCall(MockHookMultiPlexer.removeHook, (module))});
        executions[1] = Execution({target: module, value: 0, callData: abi.encodeCall(IModule.onUninstall, (initData))});
        executions[2] = Execution({target: module, value: 0, callData: abi.encodeCall(TrustedForwarder.clearTrustedForwarder, ())});
        callData = encode({executions: executions});
    } else {
        callData = abi.encodeCall(IERC7579Account.uninstallModule, (moduleType, module, initData));
    }
}
```

### getExecHook(struct AccountInstance,address)

- **Kind**: internal
- **Source**: 21931:448:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getExecHook(struct AccountInstance,address)`

```solidity
/// @notice Gets the exec hook for an account instance
///  @param instance AccountInstance the account instance to get the exec hook for
///  @param txValidator address the address of the validator
///  @return address the address of the exec hook
function getExecHook(AccountInstance memory instance, address txValidator) internal deployAccountForAction(instance) returns (address) {
    ValidationId vId = ValidatorLib.validatorToIdentifier(IValidator(txValidator));
    ValidationConfig memory validationConfig = IKernel(payable(instance.account)).validationConfig(vId);
    return address(validationConfig.hook);
}
```

### validatorToIdentifier(contract IValidator)

- **Kind**: internal
- **Source**: 5361:263:164
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ValidationTypeLib.sol:ValidatorLib:validatorToIdentifier(contract IValidator)`

```solidity
function validatorToIdentifier(IValidator validator) internal pure returns (ValidationId vId) {
    assembly {
        vId := 0x0100000000000000000000000000000000000000000000000000000000000000
        vId := or(vId, shl(88, validator))
    }
}
```

### deployAccountForAction(struct AccountInstance)

- **Kind**: modifier
- **Source**: 19883:377:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:deployAccountForAction(struct AccountInstance)`

```solidity
/// @notice Deploys an account instance, if it has not been deployed yet, and reverts to the
///          snapshot after the action
modifier deployAccountForAction(AccountInstance memory instance) {
    bool isAccountDeployed = instance.account.code.length != 0;
    uint256 snapShotId;
    if (!isAccountDeployed) {
        snapShotId = snapshot();
        deployAccount(instance);
    }
    _;
    if (!isAccountDeployed) {
        revertTo(snapShotId);
    }
}
```

### snapshot()

- **Kind**: free-function
- **Source**: 2210:81:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:snapshot()`

```solidity
function snapshot() returns (uint256) {
    return Vm(VM_ADDR).snapshotState();
}
```

### deployAccount(struct AccountInstance)

- **Kind**: internal
- **Source**: 19133:605:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:deployAccount(struct AccountInstance)`

```solidity
/// @notice Deploys an account instance, if it has not been deployed yet
///          reverts if no initCode is provided
///  @param instance AccountInstance the account instance to deploy
function deployAccount(AccountInstance memory instance) virtual public {
    if (instance.account.code.length == 0) {
        if (instance.initCode.length == 0) {
            revert("deployAccount: no initCode provided");
        } else {
            bytes memory initCode = instance.initCode;
            assembly {
                let factory := mload(add(initCode, 20))
                let success := call(gas(), factory, 0, add(initCode, 52), mload(initCode), 0, 0)
                if iszero(success) {
                    revert(0, 0)
                }
            }
        }
    }
}
```

### revertTo(uint256)

- **Kind**: free-function
- **Source**: 2293:90:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:revertTo(uint256)`

```solidity
function revertTo(uint256 id) returns (bool) {
    return Vm(VM_ADDR).revertToState(id);
}
```

### getNonce(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 4444:563:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getNonce(struct AccountInstance,bytes,address)`

```solidity
/// @notice Gets the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
function getNonce(AccountInstance memory instance, bytes memory callData, address txValidator) virtual override public returns (uint256 nonce) {
    ValidationType vType;
    if (txValidator == address(instance.defaultValidator)) {
        vType = VALIDATION_TYPE_ROOT;
    } else {
        enableValidator(instance, callData, txValidator);
        vType = VALIDATION_TYPE_VALIDATOR;
    }
    nonce = encodeNonce(vType, false, instance.account, txValidator);
}
```

### enableValidator(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 9540:880:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:enableValidator(struct AccountInstance,bytes,address)`

```solidity
/// @notice Enables a validator for an account instance
///  @param instance AccountInstance the account instance to enable the validator for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
function enableValidator(AccountInstance memory instance, bytes memory callData, address txValidator) internal deployAccountForAction(instance) {
    ValidationId vId = ValidatorLib.validatorToIdentifier(IValidator(txValidator));
    bytes4 selector;
    assembly {
        selector := mload(add(callData, 32))
    }
    bool isAllowedSelector = IKernel(payable(instance.account)).isAllowedSelector(vId, selector);
    if (!isAllowedSelector) {
        bytes memory accountCode = instance.account.code;
        address _setSelector = address(deployKernelWithSetSelector(ENTRYPOINT_ADDR));
        etch(instance.account, _setSelector.code);
        ISetSelector(payable(instance.account)).setSelector(vId, selector, true);
        etch(instance.account, accountCode);
    }
}
```

### deployKernelWithSetSelector(address)

- **Kind**: internal
- **Source**: 1161:401:183
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/KernelPrecompiles.sol:KernelPrecompiles:deployKernelWithSetSelector(address)`

```solidity
function deployKernelWithSetSelector(address entrypoint) internal returns (ISetSelector kernel) {
    bytes memory creationBytecode = bytes.concat(KERNEL_WITH_SETSELECTOR_BYTECODE, abi.encode(entrypoint));
    kernel = ISetSelector(_deploy(creationBytecode));
    label(address(kernel), "SetSelector");
}
```

### _deploy(bytes)

- **Kind**: internal
- **Source**: 221:412:181
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/BytecodeDeployer.sol:BytecodeDeployer:_deploy(bytes)`

```solidity
/// @notice Deploys a contract using CREATE, reverts on failure
function _deploy(bytes memory creationBytecode) internal returns (address contractAddress) {
    assembly {
        contractAddress := create(0, add(creationBytecode, 0x20), mload(creationBytecode))
    }
    require(contractAddress != address(0), "Deployer: deployment failed");
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

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
}
```

### encodeNonce(ValidationType,bool,address,address)

- **Kind**: internal
- **Source**: 5375:882:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:encodeNonce(ValidationType,bool,address,address)`

```solidity
/// @notice Encodes the nonce for an account instance in the Kernel format
///  @param vType ValidationType the validation type
///  @param enable bool whether to enable the validator
///  @param account address the address of the account
///  @param validator address the address of the validator
///  @return nonce uint256 the encoded nonce
function encodeNonce(ValidationType vType, bool enable, address account, address validator) public view returns (uint256 nonce) {
    uint192 nonceKey = 0;
    if (vType == VALIDATION_TYPE_ROOT) {
        nonceKey = 0;
    } else if (vType == VALIDATION_TYPE_VALIDATOR) {
        ValidationMode mode = VALIDATION_MODE_DEFAULT;
        if (enable) {
            mode = VALIDATION_MODE_ENABLE;
        }
        nonceKey = ValidatorLib.encodeAsNonceKey(ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0);
    } else {
        revert("Invalid validation type");
    }
    return IEntryPoint(ENTRYPOINT_ADDR).getNonce(account, nonceKey);
}
```

### encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)

- **Kind**: internal
- **Source**: 3021:392:164
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ValidationTypeLib.sol:ValidatorLib:encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)`

```solidity
function encodeAsNonceKey(bytes1 mode, bytes1 vType, bytes20 ValidationIdWithoutType, uint16 nonceKey) internal pure returns (uint192 res) {
    assembly {
        res := or(nonceKey, shr(80, ValidationIdWithoutType))
        res := or(res, shr(72, vType))
        res := or(res, shr(64, mode))
    }
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**

## State Variable Reads

- **KERNEL_WITH_SETSELECTOR_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 2)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 3)
  │ │     💬 Args: [instance]
  │ │     👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getInstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 4)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 5)
  │ │     💬 Args: [instance]
  │ │     👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 6)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 7)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 8)
  │ │     💬 Args: [instance]
  │ │     👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 9)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 10)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getInstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 11)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 12)
  │ │   💬 Args: [instance]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 13)
  │ │   💬 Args: [instance]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.encode(struct Execution[]) (NodeID: 14)
  │     💬 Args: [executions]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 15)
  │       💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 16)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 17)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 18)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 19)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 20)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 21)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 22)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 23)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 24)
  │ │   💬 Args: [instance]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.encode(struct Execution[]) (NodeID: 25)
  │     💬 Args: [executions]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 26)
  │       💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getExecHook(struct AccountInstance,address) (NodeID: 27)
  │   💬 Args: [instance, txValidator]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 28)
  │ │   💬 Args: [IValidator(txValidator)]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 29)
  │     💬 Args: [instance]
  │   ├─ [3] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 30)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 31)
  │   │   💬 Args: [instance]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 32)
  │       💬 Args: [snapShotId]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: KernelHelpers.getNonce(struct AccountInstance,bytes,address) (NodeID: 33)
      💬 Args: [instance, callData, txValidator]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: KernelHelpers.enableValidator(struct AccountInstance,bytes,address) (NodeID: 34)
    │   💬 Args: [instance, callData, txValidator]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 35)
    │ │   💬 Args: [IValidator(txValidator)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: KernelPrecompiles.deployKernelWithSetSelector(address) (NodeID: 36)
    │ │   💬 Args: [ENTRYPOINT_ADDR]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 37)
    │ │ │   💬 Args: [creationBytecode]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 38)
    │ │     💬 Args: [address(kernel), "SetSelector"]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 39)
    │ │   💬 Args: [instance.account, _setSelector.code]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 40)
    │ │   💬 Args: [instance.account, accountCode]
    │ │   👁️  Def: internal
    │ └─ [3] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 41)
    │     💬 Args: [instance]
    │   ├─ [4] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 42)
    │   │   💬 Args: [no args]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 43)
    │   │   💬 Args: [instance]
    │   │   👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 44)
    │       💬 Args: [snapShotId]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: KernelHelpers.encodeNonce(ValidationType,bool,address,address) (NodeID: 45)
        💬 Args: [vType, false, instance.account, txValidator]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: ValidatorLib.encodeAsNonceKey(bytes1,bytes1,bytes20,uint16) (NodeID: 46)
          💬 Args: [ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Configures a userop for an account instance to install or uninstall a module
 @param instance AccountInstance the account instance to configure the userop for
 @param moduleType uint256 the type of the module
 @param module address the address of the module
 @param initData bytes the data to pass to the module
 @param isInstall bool whether to install or uninstall the module
 @param txValidator address the address of the validator
 @return userOp PackedUserOperation the packed user operation
 @return userOpHash bytes32 the hash of the user operation
