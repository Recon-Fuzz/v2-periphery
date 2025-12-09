# Interface: ISuperRegistry

## Metadata

- **Name**: ISuperRegistry
- **Type**: Interface
- **Path**: test/draft/src/interfaces/ISuperRegistry.sol
- **Documentation**: @title ISuperRegistry
   @author Superform Labs
   @notice Interface for the SuperRegistry contract
   @dev Registry for VaultBank and SuperAsset related configurations
   @dev Extracted from SuperGovernor to separate out-of-scope functionality

## Implements Interfaces

- **IAccessControl** [lib/v2-core/lib/openzeppelin-contracts/contracts/access/IAccessControl.sol/interface_IAccessControl.md]

## Structs

### HookMerkleRootData

```solidity
/// @notice Structure containing Merkle root data for a hook
struct HookMerkleRootData {
    bytes32 currentRoot;
    bytes32 proposedRoot;
    uint256 effectiveTime;
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

### INVALID_ADDRESS

```solidity
/// @notice Thrown when providing an invalid address (typically zero address)
error INVALID_ADDRESS();
```

### INVALID_CHAIN_ID

```solidity
/// @notice Thrown when providing an invalid chain ID
error INVALID_CHAIN_ID();
```

### CONTRACT_NOT_FOUND

```solidity
/// @notice Thrown when trying to access a contract that is not registered
error CONTRACT_NOT_FOUND();
```

### TIMELOCK_NOT_EXPIRED

```solidity
/// @notice Thrown when timelock period has not expired
error TIMELOCK_NOT_EXPIRED();
```

### HOOK_NOT_APPROVED

```solidity
/// @notice Thrown when a hook is not approved but expected to be
error HOOK_NOT_APPROVED();
```

### NO_PROPOSED_MERKLE_ROOT

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error NO_PROPOSED_MERKLE_ROOT();
```

### ZERO_PROPOSED_MERKLE_ROOT

```solidity
/// @notice Thrown when proposing a zero Merkle root
error ZERO_PROPOSED_MERKLE_ROOT();
```

### RELAYER_NOT_REGISTERED

```solidity
/// @notice Thrown when a relayer is not registered
error RELAYER_NOT_REGISTERED();
```

### RELAYER_ALREADY_REGISTERED

```solidity
/// @notice Thrown when a relayer is already registered
error RELAYER_ALREADY_REGISTERED();
```

### TOKEN_ALREADY_WHITELISTED

```solidity
/// @notice Thrown when a token is already whitelisted
error TOKEN_ALREADY_WHITELISTED();
```

### NOT_PROPOSED_INCENTIVE_TOKEN

```solidity
/// @notice Thrown when a token is not proposed for whitelisting but expected to be
error NOT_PROPOSED_INCENTIVE_TOKEN();
```

### NOT_WHITELISTED_INCENTIVE_TOKEN

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

### ProverSet

```solidity
/// @notice Emitted when a prover is set
///  @param oldProver The address of the old prover
///  @param newProver The address of the new prover
event ProverSet(address indexed oldProver, address indexed newProver);
```

### RelayerAdded

```solidity
/// @notice Emitted when a relayer is added
///  @param relayer The address of the added relayer
event RelayerAdded(address indexed relayer);
```

### RelayerRemoved

```solidity
/// @notice Emitted when a relayer is removed
///  @param relayer The address of the removed relayer
event RelayerRemoved(address indexed relayer);
```

### VaultBankAddressAdded

```solidity
/// @notice Emitted when a vault bank is added
///  @param chainId The chain ID of the added vault bank
///  @param vaultBank The address of the added vault bank
event VaultBankAddressAdded(uint64 indexed chainId, address indexed vaultBank);
```

### VaultBankHookMerkleRootProposed

```solidity
/// @notice Emitted when the VaultBank hook Merkle root is proposed
///  @param hook The hook address for which the Merkle root is being proposed
///  @param newRoot The new Merkle root
///  @param effectiveTime The timestamp when the new root will be effective
event VaultBankHookMerkleRootProposed(address indexed hook, bytes32 newRoot, uint256 effectiveTime);
```

### VaultBankHookMerkleRootUpdated

```solidity
/// @notice Emitted when the VaultBank hook Merkle root is updated.
///  @param hook The address of the hook for which the Merkle root was updated.
///  @param newRoot The new Merkle root.
event VaultBankHookMerkleRootUpdated(address indexed hook, bytes32 newRoot);
```

### WhitelistedIncentiveTokensProposed

```solidity
/// @notice Emitted when incentive tokens are proposed for whitelisting
///  @param tokens The addresses of the proposed tokens
///  @param effectiveTime The timestamp when the proposal will be effective
event WhitelistedIncentiveTokensProposed(address[] tokens, uint256 effectiveTime);
```

### WhitelistedIncentiveTokensAdded

```solidity
/// @notice Emitted when whitelisted incentive tokens are added
///  @param tokens The addresses of the added tokens
event WhitelistedIncentiveTokensAdded(address[] tokens);
```

### WhitelistedIncentiveTokensRemoved

```solidity
/// @notice Emitted when whitelisted incentive tokens are removed
///  @param tokens The addresses of the removed tokens
event WhitelistedIncentiveTokensRemoved(address[] tokens);
```

### AddressSet

```solidity
/// @notice Emitted when an address is set in the registry
///  @param key The registry key
///  @param oldValue The previous address value
///  @param newValue The new address value
event AddressSet(bytes32 indexed key, address oldValue, address newValue);
```

## Public/External Functions

### SUPER_ASSET_FACTORY()

- **Signature**: `SUPER_ASSET_FACTORY()`
- **Visibility**: external
- **Source Range**: 5591:63:556

**Signature:**
```solidity
/// @notice Returns the SuperAsset factory registry key
///  @return The keccak256 hash used as the registry key for SuperAsset factory
function SUPER_ASSET_FACTORY() external pure returns (bytes32);;
```

### SUPER_REGISTRY_ADMIN_ROLE()

- **Signature**: `SUPER_REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 5791:69:556

**Signature:**
```solidity
/// @notice Returns the super registry admin role identifier
///  @return The keccak256 hash of "SUPER_REGISTRY_ADMIN_ROLE"
function SUPER_REGISTRY_ADMIN_ROLE() external pure returns (bytes32);;
```

### REGISTRY_ADMIN_ROLE()

- **Signature**: `REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 5985:63:556

**Signature:**
```solidity
/// @notice Returns the registry admin role identifier
///  @return The keccak256 hash of "REGISTRY_ADMIN_ROLE"
function REGISTRY_ADMIN_ROLE() external pure returns (bytes32);;
```

### setProver(address)

- **Signature**: `setProver(address)`
- **Visibility**: external
- **Source Range**: 6329:44:556

**Signature:**
```solidity
/// @notice Sets the prover address
///  @param prover The address of the prover
function setProver(address prover) external;;
```

### setAddress(bytes32,address)

- **Signature**: `setAddress(bytes32,address)`
- **Visibility**: external
- **Source Range**: 6509:57:556

**Signature:**
```solidity
/// @notice Sets an address in the registry
///  @param key The registry key
///  @param value The address value to set
function setAddress(bytes32 key, address value) external;;
```

### getAddress(bytes32)

- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 6692:65:556

**Signature:**
```solidity
/// @notice Gets an address from the registry
///  @param key The registry key
///  @return The address value
function getAddress(bytes32 key) external view returns (address);;
```

### setSuperAssetManager(address,address)

- **Signature**: `setSuperAssetManager(address,address)`
- **Visibility**: external
- **Source Range**: 6941:86:556

**Signature:**
```solidity
/// @notice Sets the superasset manager for a superasset
///  @param superAsset The superasset address
///  @param superAssetManager The new superasset manager address
function setSuperAssetManager(address superAsset, address superAssetManager) external;;
```

### addICCToWhitelist(address)

- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 7120:49:556

**Signature:**
```solidity
/// @notice Adds an ICC to the whitelist
///  @param icc The ICC address to add
function addICCToWhitelist(address icc) external;;
```

### removeICCFromWhitelist(address)

- **Signature**: `removeICCFromWhitelist(address)`
- **Visibility**: external
- **Source Range**: 7270:54:556

**Signature:**
```solidity
/// @notice Removes an ICC from the whitelist
///  @param icc The ICC address to remove
function removeICCFromWhitelist(address icc) external;;
```

### addRelayer(address)

- **Signature**: `addRelayer(address)`
- **Visibility**: external
- **Source Range**: 7622:46:556

**Signature:**
```solidity
/// @notice Adds a relayer to the approved list
///  @param relayer The address of the relayer to add
function addRelayer(address relayer) external;;
```

### removeRelayer(address)

- **Signature**: `removeRelayer(address)`
- **Visibility**: external
- **Source Range**: 7791:49:556

**Signature:**
```solidity
/// @notice Removes a relayer from the approved list
///  @param relayer The address of the relayer to remove
function removeRelayer(address relayer) external;;
```

### proposeVaultBankHookMerkleRoot(address,bytes32)

- **Signature**: `proposeVaultBankHookMerkleRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 8243:85:556

**Signature:**
```solidity
/// @notice Proposes a new Merkle root for a specific hook's allowed targets.
///  @param hook The address of the hook to update the Merkle root for.
///  @param proposedRoot The proposed new Merkle root.
function proposeVaultBankHookMerkleRoot(address hook, bytes32 proposedRoot) external;;
```

### executeVaultBankHookMerkleRootUpdate(address)

- **Signature**: `executeVaultBankHookMerkleRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 8525:69:556

**Signature:**
```solidity
/// @notice Executes a previously proposed Merkle root update for a specific hook if the effective time has passed.
///  @param hook The address of the hook to execute the update for.
function executeVaultBankHookMerkleRootUpdate(address hook) external;;
```

### addVaultBank(uint64,address)

- **Signature**: `addVaultBank(uint64,address)`
- **Visibility**: external
- **Source Range**: 8974:66:556

**Signature:**
```solidity
/// @notice Adds a vault bank address for a specific chain ID
///  @param chainId The chain ID to add the vault bank for
///  @param vaultBank The address of the vault bank to add
function addVaultBank(uint64 chainId, address vaultBank) external;;
```

### proposeAddIncentiveTokens(address[])

- **Signature**: `proposeAddIncentiveTokens(address[])`
- **Visibility**: external
- **Source Range**: 9346:69:556

**Signature:**
```solidity
/// @notice Proposes whitelisted incentive tokens
///  @param tokens The addresses of the tokens to add
function proposeAddIncentiveTokens(address[] memory tokens) external;;
```

### executeAddIncentiveTokens()

- **Signature**: `executeAddIncentiveTokens()`
- **Visibility**: external
- **Source Range**: 9530:46:556

**Signature:**
```solidity
/// @notice Executes a previously proposed whitelisted incentive token update after timelock has expired
function executeAddIncentiveTokens() external;;
```

### proposeRemoveIncentiveTokens(address[])

- **Signature**: `proposeRemoveIncentiveTokens(address[])`
- **Visibility**: external
- **Source Range**: 9698:72:556

**Signature:**
```solidity
/// @notice Proposes a new whitelisted incentive token
///  @param tokens The addresses of the tokens to add
function proposeRemoveIncentiveTokens(address[] memory tokens) external;;
```

### executeRemoveIncentiveTokens()

- **Signature**: `executeRemoveIncentiveTokens()`
- **Visibility**: external
- **Source Range**: 9887:49:556

**Signature:**
```solidity
/// @notice Executes a previously proposed whitelisted incentive tokens removal after timelock has expired
function executeRemoveIncentiveTokens() external;;
```

### getVaultBank(uint64)

- **Signature**: `getVaultBank(uint64)`
- **Visibility**: external
- **Source Range**: 10297:70:556

**Signature:**
```solidity
/// @notice Gets the vault bank address for a specific chain ID
///  @param chainId The chain ID to get the vault bank for
///  @return The vault bank address
function getVaultBank(uint64 chainId) external view returns (address);;
```

### isRelayer(address)

- **Signature**: `isRelayer(address)`
- **Visibility**: external
- **Source Range**: 10553:65:556

**Signature:**
```solidity
/// @notice Checks if an address is an approved relayer
///  @param relayer The address to check
///  @return True if the address is an approved relayer, false otherwise
function isRelayer(address relayer) external view returns (bool);;
```

### getRelayers()

- **Signature**: `getRelayers()`
- **Visibility**: external
- **Source Range**: 10714:64:556

**Signature:**
```solidity
/// @notice Returns all registered relayers
///  @return List of relayer addresses
function getRelayers() external view returns (address[] memory);;
```

### getVaultBankHookMerkleRoot(address)

- **Signature**: `getVaultBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 11007:82:556

**Signature:**
```solidity
/// @notice Returns the current Merkle root for a specific hook's allowed targets.
///  @param hook The address of the hook to get the Merkle root for.
///  @return The Merkle root for the hook's allowed targets.
function getVaultBankHookMerkleRoot(address hook) external view returns (bytes32);;
```

### getProposedVaultBankHookMerkleRoot(address)

- **Signature**: `getProposedVaultBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 11411:150:556

**Signature:**
```solidity
/// @notice Gets the proposed Merkle root and its effective time for a specific hook.
///  @param hook The address of the hook to get the proposed Merkle root for.
///  @return proposedRoot The proposed Merkle root.
///  @return effectiveTime The timestamp when the proposed root will become effective.
function getProposedVaultBankHookMerkleRoot(address hook) external view returns (bytes32 proposedRoot, uint256 effectiveTime);;
```

### isWhitelistedIncentiveToken(address)

- **Signature**: `isWhitelistedIncentiveToken(address)`
- **Visibility**: external
- **Source Range**: 11781:81:556

**Signature:**
```solidity
/// @notice Checks if a token is whitelisted as an incentive token
///  @param token The address of the token to check
///  @return True if the token is whitelisted as an incentive token, false otherwise
function isWhitelistedIncentiveToken(address token) external view returns (bool);;
```

### getProver()

- **Signature**: `getProver()`
- **Visibility**: external
- **Source Range**: 11950:53:556

**Signature:**
```solidity
/// @notice Gets the prover address
///  @return The address of the prover
function getProver() external view returns (address);;
```

### hasRole(bytes32,address) (inherited from IAccessControl)

- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 1822:77:250

**Signature:**
```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) external view returns (bool);;
```

### getRoleAdmin(bytes32) (inherited from IAccessControl)

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

### grantRole(bytes32,address) (inherited from IAccessControl)

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

### revokeRole(bytes32,address) (inherited from IAccessControl)

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

### renounceRole(bytes32,address) (inherited from IAccessControl)

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
