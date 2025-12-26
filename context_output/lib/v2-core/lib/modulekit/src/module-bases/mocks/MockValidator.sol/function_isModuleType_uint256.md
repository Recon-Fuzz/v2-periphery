# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

## Metadata

- **Contract**: MockValidator
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1029:124:228

## Implementation

```solidity
function isModuleType(uint256 typeID) override external pure returns (bool) {
    return typeID == TYPE_VALIDATOR;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockValidator.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
