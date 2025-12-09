# Function: getUninstallModuleData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getUninstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7579Helpers.getUninstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7579Helpers.getUninstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 2)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 3)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC7579Helpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 4)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 5)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: HelperBase.getUninstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 6)
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
