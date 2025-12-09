# Contract: SuperRegistry

## Metadata

- **Name**: SuperRegistry
- **Type**: Contract
- **Path**: test/draft/src/SuperRegistry.sol
- **Documentation**: @title SuperRegistry
   @author Superform Labs
   @notice Registry for VaultBank and SuperAsset related configurations
   @dev Standalone registry for out-of-scope functionality

## Implements Interfaces

- **IERC165** [lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **ISuperRegistry** [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **IAccessControl** [lib/v2-core/lib/openzeppelin-contracts/contracts/access/IAccessControl.sol/interface_IAccessControl.md]

## State Variables

### _roles (inherited from AccessControl)

```solidity
mapping(bytes32 => RoleData) private _roles
```

### DEFAULT_ADMIN_ROLE (inherited from AccessControl)

```solidity
bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00
```

### _registeredHooks

```solidity
EnumerableSet.AddressSet private _registeredHooks
```

### _relayers

```solidity
EnumerableSet.AddressSet private _relayers
```

### _vaultBanks

```solidity
EnumerableSet.AddressSet private _vaultBanks
```

### _vaultBanksByChainId

```solidity
mapping(uint64 => address) private _vaultBanksByChainId
```

### vaultBankHooksMerkleRoots

```solidity
mapping(address => ISuperRegistry.HookMerkleRootData) private vaultBankHooksMerkleRoots
```

### _prover

```solidity
address private _prover
```

### _isWhitelistedIncentiveToken

```solidity
mapping(address => bool) private _isWhitelistedIncentiveToken
```

### _proposedWhitelistedIncentiveTokens

```solidity
EnumerableSet.AddressSet private _proposedWhitelistedIncentiveTokens
```

### _proposedRemoveWhitelistedIncentiveTokens

```solidity
EnumerableSet.AddressSet private _proposedRemoveWhitelistedIncentiveTokens
```

### _proposedAddWhitelistedIncentiveTokensEffectiveTime

```solidity
uint256 private _proposedAddWhitelistedIncentiveTokensEffectiveTime
```

### _proposedRemoveWhitelistedIncentiveTokensEffectiveTime

```solidity
uint256 private _proposedRemoveWhitelistedIncentiveTokensEffectiveTime
```

### _addressRegistry

```solidity
mapping(bytes32 => address) private _addressRegistry
```

### TIMELOCK

```solidity
uint256 private constant TIMELOCK = 7 days
```

### _SUPER_REGISTRY_ADMIN_ROLE

```solidity
bytes32 private constant _SUPER_REGISTRY_ADMIN_ROLE = keccak256("SUPER_REGISTRY_ADMIN_ROLE")
```

### _REGISTRY_ADMIN_ROLE

```solidity
bytes32 private constant _REGISTRY_ADMIN_ROLE = keccak256("REGISTRY_ADMIN_ROLE")
```

### _SUPER_ASSET_FACTORY

```solidity
bytes32 private constant _SUPER_ASSET_FACTORY = keccak256("SUPER_ASSET_FACTORY")
```

### VAULT_BANK

```solidity
bytes32 public constant VAULT_BANK = keccak256("VAULT_BANK")
```

### SUPER_ASSET_SWAP_FEE

```solidity
uint256 public constant SUPER_ASSET_SWAP_FEE = 4000
```

### _feeValues

```solidity
mapping(SuperAssetFeeType => uint256) private _feeValues
```

## Structs

### HookMerkleRootData (inherited from ISuperRegistry)

```solidity
/// @notice Structure containing Merkle root data for a hook
struct HookMerkleRootData {
    bytes32 currentRoot;
    bytes32 proposedRoot;
    uint256 effectiveTime;
}
```

### RoleData (inherited from AccessControl)

```solidity
struct RoleData {
    mapping(address => bool) hasRole;
    bytes32 adminRole;
}
```

## Errors

### AccessControlUnauthorizedAccount (inherited from IAccessControl)

```solidity
///  @dev The `account` is missing a role.
error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
```

### AccessControlBadConfirmation (inherited from IAccessControl)

```solidity
///  @dev The caller of a function is not the expected one.
///  NOTE: Don't confuse with {AccessControlUnauthorizedAccount}.
error AccessControlBadConfirmation();
```

### INVALID_ADDRESS (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when providing an invalid address (typically zero address)
error INVALID_ADDRESS();
```

### INVALID_CHAIN_ID (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when providing an invalid chain ID
error INVALID_CHAIN_ID();
```

### CONTRACT_NOT_FOUND (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when trying to access a contract that is not registered
error CONTRACT_NOT_FOUND();
```

### TIMELOCK_NOT_EXPIRED (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when timelock period has not expired
error TIMELOCK_NOT_EXPIRED();
```

### HOOK_NOT_APPROVED (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a hook is not approved but expected to be
error HOOK_NOT_APPROVED();
```

### NO_PROPOSED_MERKLE_ROOT (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error NO_PROPOSED_MERKLE_ROOT();
```

### ZERO_PROPOSED_MERKLE_ROOT (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when proposing a zero Merkle root
error ZERO_PROPOSED_MERKLE_ROOT();
```

### RELAYER_NOT_REGISTERED (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a relayer is not registered
error RELAYER_NOT_REGISTERED();
```

### RELAYER_ALREADY_REGISTERED (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a relayer is already registered
error RELAYER_ALREADY_REGISTERED();
```

### TOKEN_ALREADY_WHITELISTED (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a token is already whitelisted
error TOKEN_ALREADY_WHITELISTED();
```

### NOT_PROPOSED_INCENTIVE_TOKEN (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a token is not proposed for whitelisting but expected to be
error NOT_PROPOSED_INCENTIVE_TOKEN();
```

### NOT_WHITELISTED_INCENTIVE_TOKEN (inherited from ISuperRegistry)

```solidity
/// @notice Thrown when a token is not whitelisted but expected to be
error NOT_WHITELISTED_INCENTIVE_TOKEN();
```

## Events

### RoleAdminChanged (inherited from IAccessControl)

```solidity
///  @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
///  `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
///  {RoleAdminChanged} not being emitted to signal this.
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
```

### RoleGranted (inherited from IAccessControl)

```solidity
///  @dev Emitted when `account` is granted `role`.
///  `sender` is the account that originated the contract call. This account bears the admin role (for the granted role).
///  Expected in cases where the role was granted using the internal {AccessControl-_grantRole}.
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
```

### RoleRevoked (inherited from IAccessControl)

```solidity
///  @dev Emitted when `account` is revoked `role`.
///  `sender` is the account that originated the contract call:
///    - if using `revokeRole`, it is the admin role bearer
///    - if using `renounceRole`, it is the role bearer (i.e. `account`)
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
```

### ProverSet (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when a prover is set
///  @param oldProver The address of the old prover
///  @param newProver The address of the new prover
event ProverSet(address indexed oldProver, address indexed newProver);
```

### RelayerAdded (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when a relayer is added
///  @param relayer The address of the added relayer
event RelayerAdded(address indexed relayer);
```

### RelayerRemoved (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when a relayer is removed
///  @param relayer The address of the removed relayer
event RelayerRemoved(address indexed relayer);
```

### VaultBankAddressAdded (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when a vault bank is added
///  @param chainId The chain ID of the added vault bank
///  @param vaultBank The address of the added vault bank
event VaultBankAddressAdded(uint64 indexed chainId, address indexed vaultBank);
```

### VaultBankHookMerkleRootProposed (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when the VaultBank hook Merkle root is proposed
///  @param hook The hook address for which the Merkle root is being proposed
///  @param newRoot The new Merkle root
///  @param effectiveTime The timestamp when the new root will be effective
event VaultBankHookMerkleRootProposed(address indexed hook, bytes32 newRoot, uint256 effectiveTime);
```

### VaultBankHookMerkleRootUpdated (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when the VaultBank hook Merkle root is updated.
///  @param hook The address of the hook for which the Merkle root was updated.
///  @param newRoot The new Merkle root.
event VaultBankHookMerkleRootUpdated(address indexed hook, bytes32 newRoot);
```

### WhitelistedIncentiveTokensProposed (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when incentive tokens are proposed for whitelisting
///  @param tokens The addresses of the proposed tokens
///  @param effectiveTime The timestamp when the proposal will be effective
event WhitelistedIncentiveTokensProposed(address[] tokens, uint256 effectiveTime);
```

### WhitelistedIncentiveTokensAdded (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when whitelisted incentive tokens are added
///  @param tokens The addresses of the added tokens
event WhitelistedIncentiveTokensAdded(address[] tokens);
```

### WhitelistedIncentiveTokensRemoved (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when whitelisted incentive tokens are removed
///  @param tokens The addresses of the removed tokens
event WhitelistedIncentiveTokensRemoved(address[] tokens);
```

### AddressSet (inherited from ISuperRegistry)

```solidity
/// @notice Emitted when an address is set in the registry
///  @param key The registry key
///  @param oldValue The previous address value
///  @param newValue The new address value
event AddressSet(bytes32 indexed key, address oldValue, address newValue);
```

## Public/External Functions

### constructor(address,address,address)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 3039:692:550
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
/// @notice Initializes the SuperRegistry contract
///  @param superRegistryAdmin Address that will have super registry admin role
///  @param registryAdmin Address that will have registry admin role
///  @param prover_ Address of the Polymer prover
constructor(address superRegistryAdmin, address registryAdmin, address prover_);
```

### setProver(address)

- **Signature**: `setProver(address)`
- **Visibility**: external
- **Source Range**: 3959:255:550
- **Details**: [function_setProver_address.md](./function_setProver_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function setProver(address prover) external onlyRole(_SUPER_REGISTRY_ADMIN_ROLE);
```

### setAddress(bytes32,address)

- **Signature**: `setAddress(bytes32,address)`
- **Visibility**: external
- **Source Range**: 4255:297:550
- **Details**: [function_setAddress_bytes32_address.md](./function_setAddress_bytes32_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function setAddress(bytes32 key, address value) external onlyRole(_SUPER_REGISTRY_ADMIN_ROLE);
```

### getAddress(bytes32)

- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 4593:203:550
- **Details**: [function_getAddress_bytes32.md](./function_getAddress_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getAddress(bytes32 key) external view returns (address);
```

### setSuperAssetManager(address,address)

- **Signature**: `setSuperAssetManager(address,address)`
- **Visibility**: external
- **Source Range**: 4837:553:550
- **Details**: [function_setSuperAssetManager_address_address.md](./function_setSuperAssetManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function setSuperAssetManager(address superAsset, address superAssetManager) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### addICCToWhitelist(address)

- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 5431:409:550
- **Details**: [function_addICCToWhitelist_address.md](./function_addICCToWhitelist_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function addICCToWhitelist(address icc) external onlyRole(_SUPER_REGISTRY_ADMIN_ROLE);
```

### removeICCFromWhitelist(address)

- **Signature**: `removeICCFromWhitelist(address)`
- **Visibility**: external
- **Source Range**: 5881:419:550
- **Details**: [function_removeICCFromWhitelist_address.md](./function_removeICCFromWhitelist_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function removeICCFromWhitelist(address icc) external onlyRole(_SUPER_REGISTRY_ADMIN_ROLE);
```

### registerHook(address)

- **Signature**: `registerHook(address)`
- **Visibility**: external
- **Source Range**: 6575:177:550
- **Details**: [function_registerHook_address.md](./function_registerHook_address.md)

**Signature:**
```solidity
/// @notice Registers a hook
///  @param hook The address of the hook to register
function registerHook(address hook) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### unregisterHook(address)

- **Signature**: `unregisterHook(address)`
- **Visibility**: external
- **Source Range**: 6851:172:550
- **Details**: [function_unregisterHook_address.md](./function_unregisterHook_address.md)

**Signature:**
```solidity
/// @notice Unregisters a hook
///  @param hook The address of the hook to unregister
function unregisterHook(address hook) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### isHookRegistered(address)

- **Signature**: `isHookRegistered(address)`
- **Visibility**: external
- **Source Range**: 7160:124:550
- **Details**: [function_isHookRegistered_address.md](./function_isHookRegistered_address.md)

**Signature:**
```solidity
/// @notice Checks if a hook is registered
///  @param hook The address to check
///  @return True if hook is registered
function isHookRegistered(address hook) external view returns (bool);
```

### addRelayer(address)

- **Signature**: `addRelayer(address)`
- **Visibility**: external
- **Source Range**: 7508:256:550
- **Details**: [function_addRelayer_address.md](./function_addRelayer_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function addRelayer(address relayer) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### removeRelayer(address)

- **Signature**: `removeRelayer(address)`
- **Visibility**: external
- **Source Range**: 7805:199:550
- **Details**: [function_removeRelayer_address.md](./function_removeRelayer_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function removeRelayer(address relayer) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### proposeVaultBankHookMerkleRoot(address,bytes32)

- **Signature**: `proposeVaultBankHookMerkleRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 8227:634:550
- **Details**: [function_proposeVaultBankHookMerkleRoot_address_bytes32.md](./function_proposeVaultBankHookMerkleRoot_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function proposeVaultBankHookMerkleRoot(address hook, bytes32 proposedRoot) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### executeVaultBankHookMerkleRootUpdate(address)

- **Signature**: `executeVaultBankHookMerkleRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 8902:628:550
- **Details**: [function_executeVaultBankHookMerkleRootUpdate_address.md](./function_executeVaultBankHookMerkleRootUpdate_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function executeVaultBankHookMerkleRootUpdate(address hook) external;
```

### addVaultBank(uint64,address)

- **Signature**: `addVaultBank(uint64,address)`
- **Visibility**: external
- **Source Range**: 9755:498:550
- **Details**: [function_addVaultBank_uint64_address.md](./function_addVaultBank_uint64_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function addVaultBank(uint64 chainId, address vaultBank) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### proposeAddIncentiveTokens(address[])

- **Signature**: `proposeAddIncentiveTokens(address[])`
- **Visibility**: external
- **Source Range**: 10481:560:550
- **Details**: [function_proposeAddIncentiveTokens_address[].md](./function_proposeAddIncentiveTokens_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function proposeAddIncentiveTokens(address[] memory tokens) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### executeAddIncentiveTokens()

- **Signature**: `executeAddIncentiveTokens()`
- **Visibility**: external
- **Source Range**: 11082:746:550
- **Details**: [function_executeAddIncentiveTokens.md](./function_executeAddIncentiveTokens.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function executeAddIncentiveTokens() external;
```

### proposeRemoveIncentiveTokens(address[])

- **Signature**: `proposeRemoveIncentiveTokens(address[])`
- **Visibility**: external
- **Source Range**: 11869:682:550
- **Details**: [function_proposeRemoveIncentiveTokens_address[].md](./function_proposeRemoveIncentiveTokens_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function proposeRemoveIncentiveTokens(address[] memory tokens) external onlyRole(_REGISTRY_ADMIN_ROLE);
```

### executeRemoveIncentiveTokens()

- **Signature**: `executeRemoveIncentiveTokens()`
- **Visibility**: external
- **Source Range**: 12592:858:550
- **Details**: [function_executeRemoveIncentiveTokens.md](./function_executeRemoveIncentiveTokens.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function executeRemoveIncentiveTokens() external;
```

### getVaultBank(uint64)

- **Signature**: `getVaultBank(uint64)`
- **Visibility**: external
- **Source Range**: 13678:123:550
- **Details**: [function_getVaultBank_uint64.md](./function_getVaultBank_uint64.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getVaultBank(uint64 chainId) external view returns (address);
```

### isRelayer(address)

- **Signature**: `isRelayer(address)`
- **Visibility**: external
- **Source Range**: 13842:116:550
- **Details**: [function_isRelayer_address.md](./function_isRelayer_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function isRelayer(address relayer) external view returns (bool);
```

### getRelayers()

- **Signature**: `getRelayers()`
- **Visibility**: external
- **Source Range**: 13999:106:550
- **Details**: [function_getRelayers.md](./function_getRelayers.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getRelayers() external view returns (address[] memory);
```

### getVaultBankHookMerkleRoot(address)

- **Signature**: `getVaultBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 14146:223:550
- **Details**: [function_getVaultBankHookMerkleRoot_address.md](./function_getVaultBankHookMerkleRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getVaultBankHookMerkleRoot(address hook) external view returns (bytes32);
```

### getProposedVaultBankHookMerkleRoot(address)

- **Signature**: `getProposedVaultBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 14410:381:550
- **Details**: [function_getProposedVaultBankHookMerkleRoot_address.md](./function_getProposedVaultBankHookMerkleRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getProposedVaultBankHookMerkleRoot(address hook) external view returns (bytes32 proposedRoot, uint256 effectiveTime);
```

### isWhitelistedIncentiveToken(address)

- **Signature**: `isWhitelistedIncentiveToken(address)`
- **Visibility**: external
- **Source Range**: 14832:140:550
- **Details**: [function_isWhitelistedIncentiveToken_address.md](./function_isWhitelistedIncentiveToken_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function isWhitelistedIncentiveToken(address token) external view returns (bool);
```

### getProver()

- **Signature**: `getProver()`
- **Visibility**: external
- **Source Range**: 15013:84:550
- **Details**: [function_getProver.md](./function_getProver.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function getProver() external view returns (address);
```

### SUPER_ASSET_FACTORY()

- **Signature**: `SUPER_ASSET_FACTORY()`
- **Visibility**: external
- **Source Range**: 15319:107:550
- **Details**: [function_SUPER_ASSET_FACTORY.md](./function_SUPER_ASSET_FACTORY.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function SUPER_ASSET_FACTORY() external pure returns (bytes32);
```

### SUPER_REGISTRY_ADMIN_ROLE()

- **Signature**: `SUPER_REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 15467:119:550
- **Details**: [function_SUPER_REGISTRY_ADMIN_ROLE.md](./function_SUPER_REGISTRY_ADMIN_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function SUPER_REGISTRY_ADMIN_ROLE() external pure returns (bytes32);
```

### REGISTRY_ADMIN_ROLE()

- **Signature**: `REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 15627:107:550
- **Details**: [function_REGISTRY_ADMIN_ROLE.md](./function_REGISTRY_ADMIN_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperRegistry
function REGISTRY_ADMIN_ROLE() external pure returns (bytes32);
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 15808:209:550
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @dev Advertise ISuperRegistry support for ERC-165 detection
function supportsInterface(bytes4 interfaceId) override(AccessControl) public view returns (bool);
```

### hasRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 2830:136:249
- **Details**: [function_hasRole_bytes32_address.md](./function_hasRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual public view returns (bool);
```

### getRoleAdmin(bytes32) (inherited from AccessControl)

- **Signature**: `getRoleAdmin(bytes32)`
- **Visibility**: public
- **Source Range**: 3786:120:249
- **Details**: [function_getRoleAdmin_bytes32.md](./function_getRoleAdmin_bytes32.md)

**Signature:**
```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {_setRoleAdmin}.
function getRoleAdmin(bytes32 role) virtual public view returns (bytes32);
```

### grantRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `grantRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 4202:136:249
- **Details**: [function_grantRole_bytes32_address.md](./function_grantRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Grants `role` to `account`.
///  If `account` had not been already granted `role`, emits a {RoleGranted}
///  event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleGranted} event.
function grantRole(bytes32 role, address account) virtual public onlyRole(getRoleAdmin(role));
```

### revokeRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `revokeRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 4618:138:249
- **Details**: [function_revokeRole_bytes32_address.md](./function_revokeRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Revokes `role` from `account`.
///  If `account` had been granted `role`, emits a {RoleRevoked} event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleRevoked} event.
function revokeRole(bytes32 role, address account) virtual public onlyRole(getRoleAdmin(role));
```

### renounceRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `renounceRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 5304:245:249
- **Details**: [function_renounceRole_bytes32_address.md](./function_renounceRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Revokes `role` from the calling account.
///  Roles are often managed via {grantRole} and {revokeRole}: this function's
///  purpose is to provide a mechanism for accounts to lose their privileges
///  if they are compromised (such as when a trusted device is misplaced).
///  If the calling account had been revoked `role`, emits a {RoleRevoked}
///  event.
///  Requirements:
///  - the caller must be `callerConfirmation`.
///  May emit a {RoleRevoked} event.
function renounceRole(bytes32 role, address callerConfirmation) virtual public;
```
