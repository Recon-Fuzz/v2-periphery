# Function: registerHook(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `registerHook(address)`
- **Visibility**: external
- **Source Range**: 16175:225:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function registerHook(address hook) external onlyRole(_GOVERNOR_ROLE) {
    if (hook == address(0)) revert INVALID_ADDRESS();
    if (_registeredHooks.add(hook)) {
        emit HookApproved(hook);
    }
}
```

## Related Implementations

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11418:150:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2497:406:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._positions[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 5101:129:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
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

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_registeredHooks** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.registerHook(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 1)
  │   💬 Args: [_registeredHooks, hook]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 2)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 3)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 4)
      💬 Args: [_GOVERNOR_ROLE]
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 5)
        💬 Args: [_GOVERNOR_ROLE]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 6)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 8)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 7)
            💬 Args: [role, account]
            👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Registers a hook for use in SuperVaults
 @param hook The address of the hook to register
