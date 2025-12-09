# Function: getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])`
- **Visibility**: public
- **Source Range**: 2280:1983:156

## Implementation

```solidity
function getInitData(IAccountFactory.ModuleInitData[] memory validators, IAccountFactory.ModuleInitData[] memory executors, IAccountFactory.ModuleInitData memory hook, IAccountFactory.ModuleInitData[] memory fallbacks) override public pure returns (bytes memory _init) {
    address[] memory attesters = new address[](1);
    attesters[0] = address(0x000000333034E9f539ce08819E12c1b8Cb29084d);
    ValidationId rootValidator = ValidatorLib.validatorToIdentifier(IValidator(validators[0].module));
    bytes[] memory otherModules = new bytes[](((validators.length - 1) + executors.length) + fallbacks.length);
    uint256 index = 0;
    for (uint256 i = 1; i < validators.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_VALIDATOR, validators[i].module, validators[i].data));
        index++;
    }
    for (uint256 i = 0; i < executors.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_EXECUTOR, executors[i].module, executors[i].data));
        index++;
    }
    for (uint256 i = 0; i < fallbacks.length; i++) {
        otherModules[index] = abi.encodeCall(IKernel.installModule, (MODULE_TYPE_FALLBACK, fallbacks[i].module, fallbacks[i].data));
        index++;
    }
    _init = abi.encodeCall(IKernel.initialize, (rootValidator, IHook(address(hook.module)), validators[0].data, hook.data, otherModules));
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
┌─ [0] ⚙️ FUNCTION: KernelFactory.getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 1)
      💬 Args: [IValidator(validators[0].module)]
      👁️  Def: internal
```
