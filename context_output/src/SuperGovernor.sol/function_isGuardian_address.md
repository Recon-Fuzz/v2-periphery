# Function: isGuardian(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `isGuardian(address)`
- **Visibility**: external
- **Source Range**: 29510:124:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function isGuardian(address guardian) external view returns (bool) {
    return hasRole(_GUARDIAN_ROLE, guardian);
}
```

## Related Implementations

### hasRole(bytes32,address)

- **Kind**: internal
- **Source**: 2830:136:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:hasRole(bytes32,address)`

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual public view returns (bool) {
    return _roles[role].hasRole[account];
}
```

## State Variable Reads

- **_GUARDIAN_ROLE** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.isGuardian(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 1)
      💬 Args: [_GUARDIAN_ROLE, guardian]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Checks if an address has the guardian role
 @param guardian Address to check
 @return true if the address has the GUARDIAN_ROLE
