# Function: getInstallModuleData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getInstallModuleData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 14183:1139:235
- **Inherited From**: HelperBase

## Implementation

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

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 2)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 3)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 4)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 5)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SafeHelpers.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 6)
      💬 Args: [instance, module, initData]
      👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install a module on an ERC7579 Account, based on the module type
 @param instance AccountInstance the account instance to install the module on
 @param moduleType uint256 the type of the module
 @param module address the address of the module to install
 @param initData bytes the data to pass to the module
 @return data bytes the data to install the module
