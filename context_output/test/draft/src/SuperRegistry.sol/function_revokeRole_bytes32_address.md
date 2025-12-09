# Function: revokeRole(bytes32,address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `revokeRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 4618:138:249
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Revokes `role` from `account`.
///  If `account` had been granted `role`, emits a {RoleRevoked} event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleRevoked} event.
function revokeRole(bytes32 role, address account) virtual public onlyRole(getRoleAdmin(role)) {
    _revokeRole(role, account);
}
```

## Related Implementations

### _revokeRole(bytes32,address)

- **Kind**: internal
- **Source**: 6708:317:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_revokeRole(bytes32,address)`

```solidity
///  @dev Attempts to revoke `role` from `account` and returns a boolean indicating if `role` was revoked.
///  Internal function without access restriction.
///  May emit a {RoleRevoked} event.
function _revokeRole(bytes32 role, address account) virtual internal returns (bool) {
    if (hasRole(role, account)) {
        _roles[role].hasRole[account] = false;
        emit RoleRevoked(role, account, _msgSender());
        return true;
    } else {
        return false;
    }
}
```

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

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### onlyRole(bytes32)

- **Kind**: modifier
- **Source**: 2431:76:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:onlyRole(bytes32)`

```solidity
///  @dev Modifier that checks that an account has a specific role. Reverts
///  with an {AccessControlUnauthorizedAccount} error including the required role.
modifier onlyRole(bytes32 role) {
    _checkRole(role);
    _;
}
```

### getRoleAdmin(bytes32)

- **Kind**: internal
- **Source**: 3786:120:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:getRoleAdmin(bytes32)`

```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {_setRoleAdmin}.
function getRoleAdmin(bytes32 role) virtual public view returns (bytes32) {
    return _roles[role].adminRole;
}
```

### _checkRole(bytes32)

- **Kind**: internal
- **Source**: 3175:103:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32)`

```solidity
///  @dev Reverts with an {AccessControlUnauthorizedAccount} error if `_msgSender()`
///  is missing `role`. Overriding this function changes the behavior of the {onlyRole} modifier.
function _checkRole(bytes32 role) virtual internal view {
    _checkRole(role, _msgSender());
}
```

### _checkRole(bytes32,address)

- **Kind**: internal
- **Source**: 3408:197:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32,address)`

```solidity
///  @dev Reverts with an {AccessControlUnauthorizedAccount} error if `account`
///  is missing `role`.
function _checkRole(bytes32 role, address account) virtual internal view {
    if (!hasRole(role, account)) {
        revert AccessControlUnauthorizedAccount(account, role);
    }
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.revokeRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl._revokeRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [role, account]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 2)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 4)
      💬 Args: [getRoleAdmin(role)]
    ├─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 5)
    │   💬 Args: [role]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 6)
        💬 Args: [getRoleAdmin(role)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 7)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 8)
            💬 Args: [role, account]
            👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Revokes `role` from `account`.
 If `account` had been granted `role`, emits a {RoleRevoked} event.
 Requirements:
 - the caller must have ``role``'s admin role.
 May emit a {RoleRevoked} event.

### Interface Documentation

 @dev Revokes `role` from `account`.
 If `account` had been granted `role`, emits a {RoleRevoked} event.
 Requirements:
 - the caller must have ``role``'s admin role.
