# Function: getInitData(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `getInitData(bytes)`
- **Visibility**: public
- **Source Range**: 4269:2078:156

## Implementation

```solidity
function getInitData(bytes memory initData) public pure returns (bytes memory _init) {
    (ModuleBootstrapConfig[] memory validators, ModuleBootstrapConfig[] memory executors, ModuleBootstrapConfig memory hook, ModuleBootstrapConfig[] memory fallbacks) = abi.decode(initData, (ModuleBootstrapConfig[], ModuleBootstrapConfig[], ModuleBootstrapConfig, ModuleBootstrapConfig[]));
    ValidationId rootValidator = ValidatorLib.validatorToIdentifier(IValidator(validators[0].module));
    bytes[] memory otherModules = new bytes[](((validators.length - 1) + executors.length) + fallbacks.length);
    uint256 index = 0;
    for (uint256 i = 1; i < validators.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_VALIDATOR, validators[i].module, validators[i].initData));
        index++;
    }
    for (uint256 i = 0; i < executors.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_EXECUTOR, executors[i].module, executors[i].initData));
        index++;
    }
    for (uint256 i = 0; i < fallbacks.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_FALLBACK, fallbacks[i].module, fallbacks[i].initData));
        index++;
    }
    _init = abi.encodeCall(IKernel.initialize, (rootValidator, IHook(address(hook.module)), validators[0].initData, hook.initData, otherModules));
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.getInitData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 1)
      💬 Args: [IValidator(validators[0].module)]
      👁️  Def: internal
```
