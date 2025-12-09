# Function: isValidSignature(struct AccountInstance,address,bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `isValidSignature(struct AccountInstance,address,bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 18688:499:236

## Implementation

```solidity
/// @notice Checks if a signature is valid for an account instance
///  @param instance AccountInstance the account instance to check the signature on
///  @param validator address the address of the validator
///  @param hash bytes32 the hash of the data that is signed
///  @param signature bytes the signature to check
///  @return isValid bool whether the signature is valid, return true if isValidSignature return
///  EIP1271_MAGIC_VALUE
function isValidSignature(AccountInstance memory instance, address validator, bytes32 hash, bytes memory signature) virtual override public deployAccountForAction(instance) returns (bool isValid) {
    isValid = IERC1271(instance.account).isValidSignature(hash, abi.encodePacked(ValidatorLib.validatorToIdentifier(IValidator(validator)), signature)) == EIP1271_MAGIC_VALUE;
}
```

## Related Implementations

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

## External Calls

- **IERC1271::isValidSignature(bytes32,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.isValidSignature(struct AccountInstance,address,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 1)
  │   💬 Args: [IValidator(validator)]
  │   👁️  Def: internal
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

@notice Checks if a signature is valid for an account instance
 @param instance AccountInstance the account instance to check the signature on
 @param validator address the address of the validator
 @param hash bytes32 the hash of the data that is signed
 @param signature bytes the signature to check
 @return isValid bool whether the signature is valid, return true if isValidSignature return
 EIP1271_MAGIC_VALUE
