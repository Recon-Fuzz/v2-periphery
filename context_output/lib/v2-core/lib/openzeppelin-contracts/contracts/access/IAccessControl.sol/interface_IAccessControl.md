# Interface: IAccessControl

## Metadata

- **Name**: IAccessControl
- **Type**: Interface
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/access/IAccessControl.sol
- **Documentation**:  @dev External interface of AccessControl declared to support ERC-165 detection.

## Errors

### AccessControlUnauthorizedAccount

```solidity
///  @dev The `account` is missing a role.
error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
```

### AccessControlBadConfirmation

```solidity
///  @dev The caller of a function is not the expected one.
///  NOTE: Don't confuse with {AccessControlUnauthorizedAccount}.
error AccessControlBadConfirmation();
```

## Events

### RoleAdminChanged

```solidity
///  @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
///  `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
///  {RoleAdminChanged} not being emitted to signal this.
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
```

### RoleGranted

```solidity
///  @dev Emitted when `account` is granted `role`.
///  `sender` is the account that originated the contract call. This account bears the admin role (for the granted role).
///  Expected in cases where the role was granted using the internal {AccessControl-_grantRole}.
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
```

### RoleRevoked

```solidity
///  @dev Emitted when `account` is revoked `role`.
///  `sender` is the account that originated the contract call:
///    - if using `revokeRole`, it is the admin role bearer
///    - if using `renounceRole`, it is the role bearer (i.e. `account`)
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
```

## Public/External Functions

### hasRole(bytes32,address)

- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 1822:77:250

**Signature:**
```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) external view returns (bool);;
```

### getRoleAdmin(bytes32)

- **Signature**: `getRoleAdmin(bytes32)`
- **Visibility**: external
- **Source Range**: 2094:68:250

**Signature:**
```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {AccessControl-_setRoleAdmin}.
function getRoleAdmin(bytes32 role) external view returns (bytes32);;
```

### grantRole(bytes32,address)

- **Signature**: `grantRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 2412:59:250

**Signature:**
```solidity
///  @dev Grants `role` to `account`.
///  If `account` had not been already granted `role`, emits a {RoleGranted}
///  event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
function grantRole(bytes32 role, address account) external;;
```

### revokeRole(bytes32,address)

- **Signature**: `revokeRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 2705:60:250

**Signature:**
```solidity
///  @dev Revokes `role` from `account`.
///  If `account` had been granted `role`, emits a {RoleRevoked} event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
function revokeRole(bytes32 role, address account) external;;
```

### renounceRole(bytes32,address)

- **Signature**: `renounceRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 3267:73:250

**Signature:**
```solidity
///  @dev Revokes `role` from the calling account.
///  Roles are often managed via {grantRole} and {revokeRole}: this function's
///  purpose is to provide a mechanism for accounts to lose their privileges
///  if they are compromised (such as when a trusted device is misplaced).
///  If the calling account had been granted `role`, emits a {RoleRevoked}
///  event.
///  Requirements:
///  - the caller must be `callerConfirmation`.
function renounceRole(bytes32 role, address callerConfirmation) external;;
```
