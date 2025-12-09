# Function: getUninstallModuleData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallModuleData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 15765:1153:235
- **Inherited From**: HelperBase

## Implementation

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

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 2)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 3)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 4)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 5)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SafeHelpers.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 6)
      💬 Args: [instance, module, initData]
      👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to uninstall a module on an ERC7579 Account, based on the module type
 @param instance AccountInstance the account instance to uninstall the module from
 @param moduleType uint256 the type of the module
 @param module address the address of the module to uninstall
 @param initData bytes the data to pass to the module
 @return data bytes the data to uninstall the module
