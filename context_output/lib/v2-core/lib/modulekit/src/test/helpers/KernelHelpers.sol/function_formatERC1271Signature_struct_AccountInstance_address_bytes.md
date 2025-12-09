# Function: formatERC1271Signature(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `formatERC1271Signature(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 20005:346:236

## Implementation

```solidity
/// @notice Formats an ERC1271 signature for an account instance
///  @param validator address the address of the validator
///  @param signature bytes the signature to format
///  @return bytes the formatted signature
function formatERC1271Signature(AccountInstance memory, address validator, bytes memory signature) virtual override public returns (bytes memory) {
    return abi.encodePacked(ValidatorLib.validatorToIdentifier(IValidator(validator)), signature);
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
┌─ [0] ⚙️ FUNCTION: KernelHelpers.formatERC1271Signature(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ValidatorLib.validatorToIdentifier(contract IValidator) (NodeID: 1)
      💬 Args: [IValidator(validator)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Formats an ERC1271 signature for an account instance
 @param validator address the address of the validator
 @param signature bytes the signature to format
 @return bytes the formatted signature
