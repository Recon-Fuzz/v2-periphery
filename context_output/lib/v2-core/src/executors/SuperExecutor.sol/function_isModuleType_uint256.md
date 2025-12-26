# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 4379:123:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @notice Verifies if this module is of the specified type
///  @dev Part of the ERC-7579 module interface
///  @param typeId The module type identifier to check against
///  @return True if this module matches the specified type, false otherwise
function isModuleType(uint256 typeId) override external pure returns (bool) {
    return typeId == TYPE_EXECUTOR;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Verifies if this module is of the specified type
 @dev Part of the ERC-7579 module interface
 @param typeId The module type identifier to check against
 @return True if this module matches the specified type, false otherwise

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
