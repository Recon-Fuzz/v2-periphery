# Function: configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)`
- **Visibility**: public
- **Source Range**: 3585:1445:235
- **Inherited From**: HelperBase

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
function configModuleUserOp(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData, bool isInstall, address txValidator) virtual public returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    if (instance.account.code.length == 0) {
        initCode = instance.initCode;
    }
    bytes memory callData;
    if (isInstall) {
        initData = getInstallModuleData(instance, moduleType, module, initData);
        callData = getInstallModuleCallData(instance, moduleType, module, initData);
    } else {
        initData = getUninstallModuleData(instance, moduleType, module, initData);
        callData = getUninstallModuleCallData(instance, moduleType, module, initData);
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
- **Source**: 6622:257:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallValidatorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install a validator on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the validator
function getInstallValidatorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getInstallExecutorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 7550:257:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallExecutorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install executor on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the executor
function getInstallExecutorData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
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
- **Source**: 3142:444:234
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol:ERC7579Helpers:getInstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install a fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, CallType callType, bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, callType, _initData);
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
- **Source**: 5358:360:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallModuleCallData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice get callData to install a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to install the module
function getInstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData) {
    callData = abi.encodeCall(IERC7579Account.installModule, (moduleType, module, initData));
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
- **Source**: 1076:816:234
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol:ERC7579Helpers:getUninstallValidatorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall a validator on an ERC7579 Account
///  @param instance AccountInstance the account instance to uninstall the validator from
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
function getUninstallValidatorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data) {
    address previous;
    (address[] memory array, ) = IAccountModulesPaginated(instance.account).getValidatorsPaginated(address(0x1), 100);
    if (array.length == 1) {
        previous = address(0x1);
    } else if (array[0] == module) {
        previous = address(0x1);
    } else {
        for (uint256 i = 1; i < array.length; i++) {
            if (array[i] == module) previous = array[i - 1];
        }
    }
    data = abi.encode(previous, initData);
}
```

### getUninstallExecutorData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 2189:813:234
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol:ERC7579Helpers:getUninstallExecutorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install a validator on an ERC7579 Account
///  @param instance AccountInstance the account instance to install the validator on
///  @param module address the address of the module to install
///  @param initData bytes the data to pass to the module
function getUninstallExecutorData(AccountInstance memory instance, address module, bytes memory initData) virtual override public view returns (bytes memory data) {
    address previous;
    (address[] memory array, ) = IAccountModulesPaginated(instance.account).getExecutorsPaginated(address(0x1), 100);
    if (array.length == 1) {
        previous = address(0x1);
    } else if (array[0] == module) {
        previous = address(0x1);
    } else {
        for (uint256 i = 1; i < array.length; i++) {
            if (array[i] == module) previous = array[i - 1];
        }
    }
    data = abi.encode(previous, initData);
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
- **Source**: 3728:406:234
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol:ERC7579Helpers:getUninstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall a fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
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
- **Source**: 6052:364:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice get callData to uninstall a module on an ERC7579 Account
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return callData bytes the callData to uninstall the module
function getUninstallModuleCallData(AccountInstance memory, uint256 moduleType, address module, bytes memory initData) virtual public view returns (bytes memory callData) {
    callData = abi.encodeCall(IERC7579Account.uninstallModule, (moduleType, module, initData));
}
```

### getNonce(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 23309:343:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getNonce(struct AccountInstance,bytes,address)`

```solidity
/// @notice Get the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param txValidator address the address of the validator
///  @return nonce uint256 the nonce
function getNonce(AccountInstance memory instance, bytes memory, address txValidator) virtual public returns (uint256 nonce) {
    uint192 key = uint192(bytes24(bytes20(address(txValidator))));
    nonce = instance.aux.entrypoint.getNonce(address(instance.account), key);
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 2)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 3)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 4)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC7579Helpers.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 5)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 6)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 7)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 8)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 9)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC7579Helpers.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 10)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC7579Helpers.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 11)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 12)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC7579Helpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 13)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 14)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 15)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 16)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: HelperBase.getNonce(struct AccountInstance,bytes,address) (NodeID: 17)
      💬 Args: [instance, callData, txValidator]
      👁️  Def: public
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
