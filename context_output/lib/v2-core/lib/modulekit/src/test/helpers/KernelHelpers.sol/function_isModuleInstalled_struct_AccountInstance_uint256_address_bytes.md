# Function: isModuleInstalled(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `isModuleInstalled(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 17426:575:236

## Implementation

```solidity
/// @notice Checks if a module is installed on an account instance
///  @param instance AccountInstance the account instance to check the module on
///  @param moduleTypeId uint256 the type of the module
///  @param module address the address of the module to check
///  @param data bytes the data to pass to the module
///  @return bool whether the module is installed
function isModuleInstalled(AccountInstance memory instance, uint256 moduleTypeId, address module, bytes memory data) virtual override public deployAccountForAction(instance) returns (bool) {
    if (moduleTypeId == MODULE_TYPE_HOOK) {
        return MockHookMultiPlexer(getHookMultiPlexer(instance)).isHookInstalled(instance.account, module);
    }
    return IERC7579Account(instance.account).isModuleInstalled(moduleTypeId, module, data);
}
```

## Related Implementations

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

## External Calls

- **MockHookMultiPlexer::isHookInstalled(address,address)**
- **IERC7579Account::isModuleInstalled(uint256,address,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.isModuleInstalled(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 1)
  │   💬 Args: [instance]
  │   👁️  Def: public
  └─ [1] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 2)
      💬 Args: [instance]
    ├─ [2] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 4)
    │   💬 Args: [instance]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 5)
        💬 Args: [snapShotId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Checks if a module is installed on an account instance
 @param instance AccountInstance the account instance to check the module on
 @param moduleTypeId uint256 the type of the module
 @param module address the address of the module to check
 @param data bytes the data to pass to the module
 @return bool whether the module is installed
