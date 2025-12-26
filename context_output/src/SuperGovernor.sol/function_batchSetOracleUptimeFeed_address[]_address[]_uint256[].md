# Function: batchSetOracleUptimeFeed(address[],address[],uint256[])

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `batchSetOracleUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 15496:456:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function batchSetOracleUptimeFeed(address[] calldata dataOracles_, address[] calldata uptimeOracles_, uint256[] calldata gracePeriods_) external onlyRole(_ORACLE_MANAGER_ROLE) {
    address oracleL2 = _addressRegistry[SUPER_ORACLE];
    if (oracleL2 == address(0)) revert CONTRACT_NOT_FOUND();
    ISuperOracleL2(oracleL2).batchSetUptimeFeed(dataOracles_, uptimeOracles_, gracePeriods_);
}
```

## Related Implementations

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

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
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

## External Calls

- **ISuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **_addressRegistry** (`mapping(bytes32 => address)`)
- **SUPER_ORACLE** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.batchSetOracleUptimeFeed(address[],address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 1)
      💬 Args: [_ORACLE_MANAGER_ROLE]
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 2)
        💬 Args: [_ORACLE_MANAGER_ROLE]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 3)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 4)
            💬 Args: [role, account]
            👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Sets uptime feeds for multiple data oracles in batch (Layer 2 only)
 @param dataOracles Array of data oracle addresses to set uptime feeds for
 @param uptimeOracles Array of uptime feed addresses to set
 @param gracePeriods Array of grace periods in seconds after sequencer restart
