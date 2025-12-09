# Function: execUserOp(struct AccountInstance,bytes,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `execUserOp(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 2733:1241:236

## Implementation

```solidity
/// @notice Gets userOp and userOpHash for an executing calldata on an account instance
///  @param instance AccountInstance the account instance to execute the userop for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the packed user operation
///  @return userOpHash bytes32 the hash of the user operation
function execUserOp(AccountInstance memory instance, bytes memory callData, address txValidator) virtual override public returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    bool notDeployedYet = instance.account.code.length == 0;
    if (notDeployedYet) {
        initCode = instance.initCode;
    }
    uint256 nonce = getNonce(instance, callData, txValidator);
    address execHook = getExecHook(instance, txValidator);
    if ((execHook != address(0)) && (execHook != address(1))) {
        callData = abi.encodePacked(IKernel.executeUserOp.selector, callData);
    }
    userOp = PackedUserOperation({sender: instance.account, nonce: nonce, initCode: initCode, callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
    userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
}
```

## Related Implementations

### getNonce(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 4444:563:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getNonce(struct AccountInstance,bytes,address)`

```solidity
/// @notice Gets the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
function getNonce(AccountInstance memory instance, bytes memory callData, address txValidator) virtual override public returns (uint256 nonce) {
    ValidationType vType;
    if (txValidator == address(instance.defaultValidator)) {
        vType = VALIDATION_TYPE_ROOT;
    } else {
        enableValidator(instance, callData, txValidator);
        vType = VALIDATION_TYPE_VALIDATOR;
    }
    nonce = encodeNonce(vType, false, instance.account, txValidator);
}
```

### enableValidator(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 9540:880:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:enableValidator(struct AccountInstance,bytes,address)`

```solidity
/// @notice Enables a validator for an account instance
///  @param instance AccountInstance the account instance to enable the validator for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
function enableValidator(AccountInstance memory instance, bytes memory callData, address txValidator) internal deployAccountForAction(instance) {
    ValidationId vId = ValidatorLib.validatorToIdentifier(IValidator(txValidator));
    bytes4 selector;
    assembly {
        selector := mload(add(callData, 32))
    }
    bool isAllowedSelector = IKernel(payable(instance.account)).isAllowedSelector(vId, selector);
    if (!isAllowedSelector) {
        bytes memory accountCode = instance.account.code;
        address _setSelector = address(deployKernelWithSetSelector(ENTRYPOINT_ADDR));
        etch(instance.account, _setSelector.code);
        ISetSelector(payable(instance.account)).setSelector(vId, selector, true);
        etch(instance.account, accountCode);
    }
}
```

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

### deployKernelWithSetSelector(address)

- **Kind**: internal
- **Source**: 1161:401:183
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/KernelPrecompiles.sol:KernelPrecompiles:deployKernelWithSetSelector(address)`

```solidity
function deployKernelWithSetSelector(address entrypoint) internal returns (ISetSelector kernel) {
    bytes memory creationBytecode = bytes.concat(KERNEL_WITH_SETSELECTOR_BYTECODE, abi.encode(entrypoint));
    kernel = ISetSelector(_deploy(creationBytecode));
    label(address(kernel), "SetSelector");
}
```

### _deploy(bytes)

- **Kind**: internal
- **Source**: 221:412:181
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/BytecodeDeployer.sol:BytecodeDeployer:_deploy(bytes)`

```solidity
/// @notice Deploys a contract using CREATE, reverts on failure
function _deploy(bytes memory creationBytecode) internal returns (address contractAddress) {
    assembly {
        contractAddress := create(0, add(creationBytecode, 0x20), mload(creationBytecode))
    }
    require(contractAddress != address(0), "Deployer: deployment failed");
}
```

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
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

### encodeNonce(ValidationType,bool,address,address)

- **Kind**: internal
- **Source**: 5375:882:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:encodeNonce(ValidationType,bool,address,address)`

```solidity
/// @notice Encodes the nonce for an account instance in the Kernel format
///  @param vType ValidationType the validation type
///  @param enable bool whether to enable the validator
///  @param account address the address of the account
///  @param validator address the address of the validator
///  @return nonce uint256 the encoded nonce
function encodeNonce(ValidationType vType, bool enable, address account, address validator) public view returns (uint256 nonce) {
    uint192 nonceKey = 0;
    if (vType == VALIDATION_TYPE_ROOT) {
        nonceKey = 0;
    } else if (vType == VALIDATION_TYPE_VALIDATOR) {
        ValidationMode mode = VALIDATION_MODE_DEFAULT;
        if (enable) {
            mode = VALIDATION_MODE_ENABLE;
        }
        nonceKey = ValidatorLib.encodeAsNonceKey(ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0);
    } else {
        revert("Invalid validation type");
    }
    return IEntryPoint(ENTRYPOINT_ADDR).getNonce(account, nonceKey);
}
```

### encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)

- **Kind**: internal
- **Source**: 3021:392:164
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/kernel/lib/ValidationTypeLib.sol:ValidatorLib:encodeAsNonceKey(bytes1,bytes1,bytes20,uint16)`

```solidity
function encodeAsNonceKey(bytes1 mode, bytes1 vType, bytes20 ValidationIdWithoutType, uint16 nonceKey) internal pure returns (uint192 res) {
    assembly {
        res := or(nonceKey, shr(80, ValidationIdWithoutType))
        res := or(res, shr(72, vType))
        res := or(res, shr(64, mode))
    }
}
```

### getExecHook(struct AccountInstance,address)

- **Kind**: internal
- **Source**: 21931:448:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getExecHook(struct AccountInstance,address)`

```solidity
/// @notice Gets the exec hook for an account instance
///  @param instance AccountInstance the account instance to get the exec hook for
///  @param txValidator address the address of the validator
///  @return address the address of the exec hook
function getExecHook(AccountInstance memory instance, address txValidator) internal deployAccountForAction(instance) returns (address) {
    ValidationId vId = ValidatorLib.validatorToIdentifier(IValidator(txValidator));
    ValidationConfig memory validationConfig = IKernel(payable(instance.account)).validationConfig(vId);
    return address(validationConfig.hook);
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**

## State Variable Reads

- **KERNEL_WITH_SETSELECTOR_BYTECODE** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.execUserOp(struct AccountInstance,bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getNonce(struct AccountInstance,bytes,address) (NodeID: 1)
  │   💬 Args: [instance, callData, txValidator]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: KernelHelpers.enableValidator(struct AccountInstance,bytes,address) (NodeID: 2)
  │ │   💬 Args: [instance, callData, txValidator]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 3)
  │ │ │   💬 Args: [IValidator(txValidator)]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: KernelPrecompiles.deployKernelWithSetSelector(address) (NodeID: 4)
  │ │ │   💬 Args: [ENTRYPOINT_ADDR]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BytecodeDeployer._deploy(bytes) (NodeID: 5)
  │ │ │ │   💬 Args: [creationBytecode]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 6)
  │ │ │     💬 Args: [address(kernel), "SetSelector"]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 7)
  │ │ │   💬 Args: [instance.account, _setSelector.code]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 8)
  │ │ │   💬 Args: [instance.account, accountCode]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 9)
  │ │     💬 Args: [instance]
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 10)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 11)
  │ │   │   💬 Args: [instance]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 12)
  │ │       💬 Args: [snapShotId]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: KernelHelpers.encodeNonce(ValidationType,bool,address,address) (NodeID: 13)
  │     💬 Args: [vType, false, instance.account, txValidator]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ValidatorLib.encodeAsNonceKey(bytes1,bytes1,bytes20,uint16) (NodeID: 14)
  │       💬 Args: [ValidationMode.unwrap(mode), ValidationType.unwrap(vType), bytes20(validator), 0]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: KernelHelpers.getExecHook(struct AccountInstance,address) (NodeID: 15)
      💬 Args: [instance, txValidator]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 16)
    │   💬 Args: [IValidator(txValidator)]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: HelperBase.deployAccountForAction(struct AccountInstance) (NodeID: 17)
        💬 Args: [instance]
      ├─ [3] ⚙️ FUNCTION: Unknown.snapshot() (NodeID: 18)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 19)
      │   💬 Args: [instance]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Unknown.revertTo(uint256) (NodeID: 20)
          💬 Args: [snapShotId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Gets userOp and userOpHash for an executing calldata on an account instance
 @param instance AccountInstance the account instance to execute the userop for
 @param callData bytes the calldata to execute
 @param txValidator address the address of the validator
 @return userOp PackedUserOperation the packed user operation
 @return userOpHash bytes32 the hash of the user operation
