# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 2680:124:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function isModuleType(uint256 typeId) override external pure returns (bool) {
    return typeId == TYPE_VALIDATOR;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
