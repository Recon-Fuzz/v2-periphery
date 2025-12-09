# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHybridValidator.sol/contract_MockHybridValidator.md]

## Metadata

- **Contract**: MockHybridValidator
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1016:162:223

## Implementation

```solidity
function isModuleType(uint256 typeID) override external pure returns (bool) {
    return (typeID == TYPE_VALIDATOR) || (typeID == TYPE_STATELESS_VALIDATOR);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHybridValidator.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
