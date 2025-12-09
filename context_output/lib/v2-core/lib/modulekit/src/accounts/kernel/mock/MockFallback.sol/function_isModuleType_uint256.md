# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 1109:160:165

## Implementation

```solidity
function isModuleType(uint256 moduleTypeId) override external view returns (bool) {
    return (moduleTypeId == 3) || (isExecutor && (moduleTypeId == 2));
}
```

## State Variable Reads

- **isExecutor** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
