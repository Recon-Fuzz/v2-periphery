# Function: isModuleType(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 767:110:221

## Implementation

```solidity
function isModuleType(uint256 typeID) external pure returns (bool) {
    return typeID == TYPE_HOOK;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.isModuleType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns boolean value if module is a certain type
 @param moduleTypeId the module type ID according the ERC-7579 spec
 MUST return true if the module is of the given type and false otherwise
