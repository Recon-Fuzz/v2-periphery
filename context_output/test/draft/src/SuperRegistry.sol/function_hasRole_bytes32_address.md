# Function: hasRole(bytes32,address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 2830:136:249
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual public view returns (bool) {
    return _roles[role].hasRole[account];
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns `true` if `account` has been granted `role`.

### Interface Documentation

 @dev Returns `true` if `account` has been granted `role`.
