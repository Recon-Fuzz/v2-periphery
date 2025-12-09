# Function: getInstallModuleData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallModuleData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getInstallValidatorData(struct AccountInstance,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 2)
  │     💬 Args: [instance]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getInstallExecutorData(struct AccountInstance,address,bytes) (NodeID: 3)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 4)
  │     💬 Args: [instance]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 5)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 6)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 7)
  │     💬 Args: [instance]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC1271Data(struct AccountInstance,address,bytes) (NodeID: 8)
  │   💬 Args: [instance, module, initData]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: HelperBase.getInstallPrevalidationHookERC4337Data(struct AccountInstance,address,bytes) (NodeID: 9)
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
