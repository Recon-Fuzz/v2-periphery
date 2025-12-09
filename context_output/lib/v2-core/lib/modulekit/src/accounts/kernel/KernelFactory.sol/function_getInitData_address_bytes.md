# Function: getInitData(address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `getInitData(address,bytes)`
- **Visibility**: public
- **Source Range**: 1828:446:156

## Implementation

```solidity
function getInitData(address validator, bytes memory initData) override public view returns (bytes memory _init) {
    ValidationId rootValidator = ValidatorLib.validatorToIdentifier(IValidator(validator));
    _init = abi.encodeCall(IKernel.initialize, (rootValidator, IHook(address(hookMultiPlexer)), initData, hex"00", new bytes[](0)));
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

## State Variable Reads

- **hookMultiPlexer** (`contract MockHookMultiPlexer`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.getInitData(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 1)
      💬 Args: [IValidator(validator)]
      👁️  Def: internal
```
