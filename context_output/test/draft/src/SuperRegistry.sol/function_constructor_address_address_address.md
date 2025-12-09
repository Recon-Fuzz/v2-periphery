# Function: constructor(address,address,address)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 3039:692:550

## Implementation

```solidity
/// @notice Initializes the SuperRegistry contract
///  @param superRegistryAdmin Address that will have super registry admin role
///  @param registryAdmin Address that will have registry admin role
///  @param prover_ Address of the Polymer prover
constructor(address superRegistryAdmin, address registryAdmin, address prover_) {
    if (((superRegistryAdmin == address(0)) || (registryAdmin == address(0))) || (prover_ == address(0))) {
        revert INVALID_ADDRESS();
    }
    _grantRole(DEFAULT_ADMIN_ROLE, superRegistryAdmin);
    _grantRole(_SUPER_REGISTRY_ADMIN_ROLE, superRegistryAdmin);
    _grantRole(_REGISTRY_ADMIN_ROLE, registryAdmin);
    _prover = prover_;
    emit ProverSet(address(0), prover_);
    _feeValues[SuperAssetFeeType.SUPER_ASSET_SWAP_FEE] = SUPER_ASSET_SWAP_FEE;
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

## State Variable Reads

- **_SUPER_REGISTRY_ADMIN_ROLE** (`bytes32`)
- **_REGISTRY_ADMIN_ROLE** (`bytes32`)
- **SUPER_ASSET_SWAP_FEE** (`uint256`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_prover** (`address`)
- **_feeValues** (`mapping(enum SuperAssetFeeType => uint256)`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperRegistry.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperRegistry
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [DEFAULT_ADMIN_ROLE, superRegistryAdmin]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 2)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 4)
  │   💬 Args: [_SUPER_REGISTRY_ADMIN_ROLE, superRegistryAdmin]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 5)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 6)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 7)
      💬 Args: [_REGISTRY_ADMIN_ROLE, registryAdmin]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 8)
    │   💬 Args: [role, account]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Initializes the SuperRegistry contract
 @param superRegistryAdmin Address that will have super registry admin role
 @param registryAdmin Address that will have registry admin role
 @param prover_ Address of the Polymer prover
