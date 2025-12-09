# Function: constructor(address,address,address,address,address,address,address,bool)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `constructor(address,address,address,address,address,address,address,bool)`
- **Visibility**: public
- **Source Range**: 6236:2549:509

## Implementation

```solidity
/// @notice Initializes the SuperGovernor contract
///  @param superGovernor Address of the default admin (will have SUPER_GOVERNOR_ROLE)
///  @param governor Address that will have the GOVERNOR_ROLE for daily operations
///  @param bankManager Address that will have the BANK_MANAGER_ROLE for daily operations
///  @param oracleManager Address that will have the ORACLE_MANAGER_ROLE for daily operations
///  @param gasManager Address that will have the GAS_MANAGER_ROLE for daily operations
///  @param guardian Address that will have the GUARDIAN_ROLE for veto operations
///  @param treasury Address of the treasury
///  @param upkeepPaymentsEnabled Initial value for upkeep payments (true for mainnet, false otherwise)
constructor(address superGovernor, address governor, address bankManager, address oracleManager, address gasManager, address guardian, address treasury, bool upkeepPaymentsEnabled) {
    if (((((((superGovernor == address(0)) || (treasury == address(0))) || (governor == address(0))) || (bankManager == address(0))) || (gasManager == address(0))) || (oracleManager == address(0))) || (guardian == address(0))) revert INVALID_ADDRESS();
    _grantRole(DEFAULT_ADMIN_ROLE, superGovernor);
    _grantRole(_SUPER_GOVERNOR_ROLE, superGovernor);
    _grantRole(_GOVERNOR_ROLE, governor);
    _grantRole(_BANK_MANAGER_ROLE, bankManager);
    _grantRole(_ORACLE_MANAGER_ROLE, oracleManager);
    _grantRole(_GAS_MANAGER_ROLE, gasManager);
    _grantRole(_GUARDIAN_ROLE, guardian);
    _setRoleAdmin(_GUARDIAN_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(_GOVERNOR_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(_SUPER_GOVERNOR_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(_BANK_MANAGER_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(_ORACLE_MANAGER_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(_GAS_MANAGER_ROLE, DEFAULT_ADMIN_ROLE);
    _feeData[FeeType.REVENUE_SHARE].value = uint128(REVENUE_SHARE);
    _feeData[FeeType.PERFORMANCE_FEE_SHARE].value = uint128(PERFORMANCE_FEE_SHARE);
    emit FeeUpdated(FeeType.REVENUE_SHARE, REVENUE_SHARE);
    emit FeeUpdated(FeeType.PERFORMANCE_FEE_SHARE, PERFORMANCE_FEE_SHARE);
    _addressRegistry[TREASURY] = treasury;
    emit AddressSet(TREASURY, address(0), treasury);
    _minStaleness = 300;
    _upkeepPaymentsEnabled = upkeepPaymentsEnabled;
}
```

## Related Implementations

### _grantRole(bytes32,address)

- **Kind**: internal
- **Source**: 6155:316:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_grantRole(bytes32,address)`

```solidity
///  @dev Attempts to grant `role` to `account` and returns a boolean indicating if `role` was granted.
///  Internal function without access restriction.
///  May emit a {RoleGranted} event.
function _grantRole(bytes32 role, address account) virtual internal returns (bool) {
    if (!hasRole(role, account)) {
        _roles[role].hasRole[account] = true;
        emit RoleGranted(role, account, _msgSender());
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

### _setRoleAdmin(bytes32,bytes32)

- **Kind**: internal
- **Source**: 5674:247:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_setRoleAdmin(bytes32,bytes32)`

```solidity
///  @dev Sets `adminRole` as ``role``'s admin role.
///  Emits a {RoleAdminChanged} event.
function _setRoleAdmin(bytes32 role, bytes32 adminRole) virtual internal {
    bytes32 previousAdminRole = getRoleAdmin(role);
    _roles[role].adminRole = adminRole;
    emit RoleAdminChanged(role, previousAdminRole, adminRole);
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

## State Variable Reads

- **_SUPER_GOVERNOR_ROLE** (`bytes32`)
- **_GOVERNOR_ROLE** (`bytes32`)
- **_BANK_MANAGER_ROLE** (`bytes32`)
- **_ORACLE_MANAGER_ROLE** (`bytes32`)
- **_GAS_MANAGER_ROLE** (`bytes32`)
- **_GUARDIAN_ROLE** (`bytes32`)
- **REVENUE_SHARE** (`uint256`)
- **PERFORMANCE_FEE_SHARE** (`uint256`)
- **TREASURY** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_feeData** (`mapping(enum FeeType => struct SuperGovernor.FeeData)`)
- **_addressRegistry** (`mapping(bytes32 => address)`)
- **_minStaleness** (`uint256`)
- **_upkeepPaymentsEnabled** (`bool`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperGovernor.constructor(address,address,address,address,address,address,address,bool) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperGovernor
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [DEFAULT_ADMIN_ROLE, superGovernor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 2)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 4)
  │   💬 Args: [_SUPER_GOVERNOR_ROLE, superGovernor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 5)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 6)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 7)
  │   💬 Args: [_GOVERNOR_ROLE, governor]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 8)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 10)
  │   💬 Args: [_BANK_MANAGER_ROLE, bankManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 11)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 12)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 13)
  │   💬 Args: [_ORACLE_MANAGER_ROLE, oracleManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 14)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 15)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 16)
  │   💬 Args: [_GAS_MANAGER_ROLE, gasManager]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 17)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 18)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 19)
  │   💬 Args: [_GUARDIAN_ROLE, guardian]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 20)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 21)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 22)
  │   💬 Args: [_GUARDIAN_ROLE, DEFAULT_ADMIN_ROLE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 23)
  │     💬 Args: [role]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 24)
  │   💬 Args: [_GOVERNOR_ROLE, DEFAULT_ADMIN_ROLE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 25)
  │     💬 Args: [role]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 26)
  │   💬 Args: [_SUPER_GOVERNOR_ROLE, DEFAULT_ADMIN_ROLE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 27)
  │     💬 Args: [role]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 28)
  │   💬 Args: [_BANK_MANAGER_ROLE, DEFAULT_ADMIN_ROLE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 29)
  │     💬 Args: [role]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 30)
  │   💬 Args: [_ORACLE_MANAGER_ROLE, DEFAULT_ADMIN_ROLE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 31)
  │     💬 Args: [role]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AccessControl._setRoleAdmin(bytes32,bytes32) (NodeID: 32)
      💬 Args: [_GAS_MANAGER_ROLE, DEFAULT_ADMIN_ROLE]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 33)
        💬 Args: [role]
        👁️  Def: public
```

## Documentation

### Function Documentation

@notice Initializes the SuperGovernor contract
 @param superGovernor Address of the default admin (will have SUPER_GOVERNOR_ROLE)
 @param governor Address that will have the GOVERNOR_ROLE for daily operations
 @param bankManager Address that will have the BANK_MANAGER_ROLE for daily operations
 @param oracleManager Address that will have the ORACLE_MANAGER_ROLE for daily operations
 @param gasManager Address that will have the GAS_MANAGER_ROLE for daily operations
 @param guardian Address that will have the GUARDIAN_ROLE for veto operations
 @param treasury Address of the treasury
 @param upkeepPaymentsEnabled Initial value for upkeep payments (true for mainnet, false otherwise)
