# Function: configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address)`
- **Visibility**: public
- **Source Range**: 4477:1880:238

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
        callData = abi.encodeCall(IERC7579Account.installModule, (moduleType, module, initData));
    } else {
        initData = getUninstallModuleData({instance: instance, moduleType: moduleType, module: module, initData: initData});
        callData = abi.encodeCall(IERC7579Account.uninstallModule, (moduleType, module, initData));
    }
    if (initCode.length != 0) {
        (initCode, callData) = _getInitCallData(instance.salt, initCode, callData);
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
- **Source**: 8731:311:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getInstallHookData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install a hook on an account instance
///  @param initData the data to pass to the hook
///  @return data the data to install the hook
function getInstallHookData(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(HookType.GLOBAL, bytes4(0x0), initData);
}
```

### getInstallFallbackData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 9371:256:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getInstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the fallback
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

### getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 10350:341:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC1271
function getInstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC1271, initData);
}
```

### getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 10918:341:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to install an ERC4337 prevalidation hook ERC4337
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the prevalidation hook ERC4337
function getInstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC4337, initData);
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
- **Source**: 6641:816:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallValidatorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install a validator on an account instance
///  @param instance AccountInstance the account instance to install the validator on
///  @param initData the data to pass to the validator
///  @return data the data to install the validator
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
- **Source**: 7738:813:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallExecutorData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install an executor on an account instance
///  @param instance AccountInstance the account instance to install the executor on
///  @param initData the data to pass to the executor
///  @return data the data to install the executor
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
- **Source**: 9226:313:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallHookData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to uninstall a hook on an account instance
///  @param initData the data to pass to the hook
///  @return data the data to uninstall the hook
function getUninstallHookData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    data = abi.encode(HookType.GLOBAL, bytes4(0x0), initData);
}
```

### getUninstallFallbackData(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 9731:400:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallFallbackData(struct AccountInstance,address,bytes)`

```solidity
/// @notice Gets the data to install a fallback on an account instance
///  @param initData the data to pass to the fallback
///  @return data the data to install the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encode(selector, _initData);
}
```

### getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 11483:343:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to  uninstall an ERC1271 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC1271
function getUninstallPrevalidationHookERC1271Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC1271, initData);
}
```

### getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)

- **Kind**: internal
- **Source**: 12049:343:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes)`

```solidity
/// @notice get callData to uninstall an ERC4337 prevalidation hook
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to uninstall the prevalidation hook ERC4337
function getUninstallPrevalidationHookERC4337Data(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(MODULE_TYPE_PREVALIDATION_HOOK_ERC4337, initData);
}
```

### _getInitCallData(bytes32,bytes,bytes)

- **Kind**: internal
- **Source**: 19200:877:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:_getInitCallData(bytes32,bytes,bytes)`

```solidity
/// @notice Gets the initCode and callData for a new account instance
///  @param salt bytes32 the salt for the account instance
///  @param originalInitCode bytes the original initCode for the account instance
///  @param erc4337CallData bytes the callData for the ERC4337 call
function _getInitCallData(bytes32 salt, bytes memory originalInitCode, bytes memory erc4337CallData) public pure returns (bytes memory initCode, bytes memory callData) {
    address factory;
    assembly {
        factory := mload(add(originalInitCode, 20))
    }
    bytes memory initData2 = LibBytes.slice(originalInitCode, 120, originalInitCode.length);
    ISafe7579Launchpad.InitData memory initData = abi.decode(initData2, (ISafe7579Launchpad.InitData));
    initData.callData = erc4337CallData;
    initCode = abi.encodePacked(factory, abi.encodeCall(SafeFactory.createAccount, (salt, abi.encode(initData))));
    callData = abi.encodeCall(ISafe7579Launchpad.setupSafe, (initData));
}
```

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 19213:1115:320
- **Link**: `lib/v2-core/lib/solady/src/utils/LibBytes.sol:LibBytes:slice(bytes,uint256,uint256)`

```solidity
/// @dev Returns a copy of `subject` sliced from `start` to `end` (exclusive).
///  `start` and `end` are byte offsets.
function slice(bytes memory subject, uint256 start, uint256 end) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let l := mload(subject)
        if iszero(gt(l, end)) {
            end := l
        }
        if iszero(gt(l, start)) {
            start := l
        }
        if lt(start, end) {
            result := mload(0x40)
            let n := sub(end, start)
            let i := add(subject, start)
            let w := not(0x1f)
            for {
                let j := and(add(n, 0x1f), w)
            } 1 {} {
                mstore(add(result, j), mload(add(i, j)))
                j := add(j, w)
                if iszero(j) {
                    break
                }
            }
            let o := add(add(result, 0x20), n)
            mstore(o, 0)
            mstore(0x40, add(o, 0x20))
            mstore(result, n)
        }
    }
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
┌─ [0] ⚙️ FUNCTION: SafeHelpers.configModuleUserOp(struct AccountInstance,uint256,address,bytes,bool,address) (NodeID: 0)
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
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 4)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 5)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 6)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SafeHelpers.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 7)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 8)
  │   💬 Args: [instance, moduleType, module, initData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 9)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 10)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 11)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 12)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 13)
  │ │   💬 Args: [instance, module, initData]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SafeHelpers.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 14)
  │     💬 Args: [instance, module, initData]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers._getInitCallData(bytes32,bytes,bytes) (NodeID: 15)
  │   💬 Args: [instance.salt, initCode, callData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LibBytes.slice(bytes,uint256,uint256) (NodeID: 16)
  │     💬 Args: [originalInitCode, 120, originalInitCode.length]
  │     👁️  Def: internal
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
