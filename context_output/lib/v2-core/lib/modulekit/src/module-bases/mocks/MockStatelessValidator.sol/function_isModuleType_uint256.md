# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

## Metadata

- **Contract**: MockStatelessValidator
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 357:102:226

## Implementation

```solidity
function isModuleType(uint256 typeID) external pure returns (bool) {
    return typeID == 7;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStatelessValidator.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
