# Function: resetHighWaterMark(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 10271:367:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function resetHighWaterMark(address strategy) external onlyRole(_SUPER_GOVERNOR_ROLE) {
    if (strategy == address(0)) revert INVALID_ADDRESS();
    address aggregator = _addressRegistry[SUPER_VAULT_AGGREGATOR];
    if (aggregator == address(0)) revert CONTRACT_NOT_FOUND();
    ISuperVaultAggregator(aggregator).resetHighWaterMark(strategy);
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

- **ISuperVaultAggregator::resetHighWaterMark(address)**

## State Variable Reads

- **_addressRegistry** (`mapping(bytes32 => address)`)
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.resetHighWaterMark(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 1)
      💬 Args: [_SUPER_GOVERNOR_ROLE]
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 2)
        💬 Args: [_SUPER_GOVERNOR_ROLE]
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

@notice Resets the high-water mark PPS to the current PPS
 @dev Only SuperGovernor can call this function
 @dev If a manager is replaced while the strategy is below its
 previous HWM, the new manager would otherwise inherit a "loss" state and be unable to earn performance fees
 until the fee config are updated after the week timelock.
 @dev This function will reset the High Water Mark (vaultHwmPps) to the current PPS value for the given strategy
 @param strategy Address of the strategy to reset the high-water mark for
