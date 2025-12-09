# Function: formatERC1271Hash(struct AccountInstance,address,bytes32)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `formatERC1271Hash(struct AccountInstance,address,bytes32)`
- **Visibility**: public
- **Source Range**: 19443:324:236

## Implementation

```solidity
/// @notice Formats a ERC1271 hash for an account instance
///  @param instance AccountInstance the account instance to format the signature for
///  @param hash bytes32 the hash to format
///  @return bytes the formatted signature hash
function formatERC1271Hash(AccountInstance memory instance, address, bytes32 hash) virtual override public deployAccountForAction(instance) returns (bytes32) {
    return IKernel(payable(instance.account))._toWrappedHash(hash);
}
```

## Related Implementations

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

- **IKernel::_toWrappedHash(bytes32)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.formatERC1271Hash(struct AccountInstance,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 1)
      💬 Args: [instance]
    ├─ [2] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 3)
    │   💬 Args: [instance]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 4)
        💬 Args: [snapShotId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Formats a ERC1271 hash for an account instance
 @param instance AccountInstance the account instance to format the signature for
 @param hash bytes32 the hash to format
 @return bytes the formatted signature hash
