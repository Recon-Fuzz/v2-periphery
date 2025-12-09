# Function: isModuleInstalled(struct AccountInstance,uint256,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `isModuleInstalled(struct AccountInstance,uint256,address)`
- **Visibility**: public
- **Source Range**: 12624:304:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Checks if a module is installed on an ERC7579 Account
///  @param instance AccountInstance the account instance to check the module on
///  @param moduleTypeId uint256 the type of the module
///  @param module address the address of the module to check
///  @return bool whether the module is installed
function isModuleInstalled(AccountInstance memory instance, uint256 moduleTypeId, address module) virtual public deployAccountForAction(instance) returns (bool) {
    return isModuleInstalled(instance, moduleTypeId, module, "");
}
```

## Related Implementations

### isModuleInstalled(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 13345:405:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:isModuleInstalled(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Checks if a module is installed on an ERC7579 Account
///  @param instance AccountInstance the account instance to check the module on
///  @param moduleTypeId uint256 the type of the module
///  @param module address the address of the module to check
///  @param additionalContext bytes additional context to pass to the module
///  @return bool whether the module is installed
function isModuleInstalled(AccountInstance memory instance, uint256 moduleTypeId, address module, bytes memory additionalContext) virtual public deployAccountForAction(instance) returns (bool) {
    return IERC7579Account(instance.account).isModuleInstalled(moduleTypeId, module, additionalContext);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.isModuleInstalled(struct AccountInstance,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HelperBase.isModuleInstalled(struct AccountInstance,uint256,address,bytes) (NodeID: 1)
  │   💬 Args: [instance, moduleTypeId, module, ""]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 2)
  │     💬 Args: [instance]
  │   ├─ [3] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 3)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 4)
  │   │   💬 Args: [instance]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 5)
  │       💬 Args: [snapShotId]
  │       👁️  Def: internal
  └─ [1] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 6)
      💬 Args: [instance]
    ├─ [2] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 7)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 8)
    │   💬 Args: [instance]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 9)
        💬 Args: [snapShotId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Checks if a module is installed on an ERC7579 Account
 @param instance AccountInstance the account instance to check the module on
 @param moduleTypeId uint256 the type of the module
 @param module address the address of the module to check
 @return bool whether the module is installed
