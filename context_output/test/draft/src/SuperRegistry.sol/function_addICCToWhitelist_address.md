# Function: addICCToWhitelist(address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 5431:409:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function addICCToWhitelist(address icc) external onlyRole(_SUPER_REGISTRY_ADMIN_ROLE) {
    if (icc == address(0)) revert INVALID_ADDRESS();
    address factoryAddress = _addressRegistry[_SUPER_ASSET_FACTORY];
    if (factoryAddress == address(0)) revert CONTRACT_NOT_FOUND();
    ISuperAssetFactory factory = ISuperAssetFactory(factoryAddress);
    factory.addICCToWhitelist(icc);
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

- **ISuperAssetFactory::addICCToWhitelist(address)**

## State Variable Reads

- **_addressRegistry** (`mapping(bytes32 => address)`)
- **_SUPER_ASSET_FACTORY** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.addICCToWhitelist(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 1)
      💬 Args: [_SUPER_REGISTRY_ADMIN_ROLE]
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 2)
        💬 Args: [_SUPER_REGISTRY_ADMIN_ROLE]
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

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Adds an ICC to the whitelist
 @param icc The ICC address to add
