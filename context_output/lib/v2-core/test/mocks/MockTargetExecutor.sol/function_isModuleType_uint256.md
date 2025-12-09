# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 2499:123:487

## Implementation

```solidity
function isModuleType(uint256 typeId) override external pure returns (bool) {
    return typeId == TYPE_EXECUTOR;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
