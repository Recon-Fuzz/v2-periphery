# Contract: SuperGovernor

## Metadata

- **Name**: SuperGovernor
- **Type**: Contract
- **Path**: src/SuperGovernor.sol
- **Documentation**: @title SuperGovernor
   @author Superform Labs
   @notice Central registry for all deployed contracts in the Superform periphery

## Implements Interfaces

- **IERC165** [lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **ISuperGovernor** [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
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

### _addressRegistry

```solidity
mapping(bytes32 => address) private _addressRegistry
```

### _activePPSOracle

```solidity
address private _activePPSOracle
```

### _proposedActivePPSOracle

```solidity
address private _proposedActivePPSOracle
```

### _activePPSOracleEffectiveTime

```solidity
uint256 private _activePPSOracleEffectiveTime
```

### _registeredHooks

```solidity
EnumerableSet.AddressSet private _registeredHooks
```

### superBankHooksMerkleRoots

```solidity
mapping(address => ISuperGovernor.HookMerkleRootData) private superBankHooksMerkleRoots
```

### _managerTakeoversFrozen

```solidity
bool private _managerTakeoversFrozen
```

### _validatorConfig

```solidity
ValidatorConfig private _validatorConfig
```

### _feeData

```solidity
mapping(FeeType => FeeData) private _feeData
```

### _gasPerEntry

```solidity
mapping(address => uint256) private _gasPerEntry
```

### _upkeepPaymentsEnabled

```solidity
bool private _upkeepPaymentsEnabled
```

### _proposedUpkeepPaymentsEnabled

```solidity
bool private _proposedUpkeepPaymentsEnabled
```

### _upkeepPaymentsChangeEffectiveTime

```solidity
uint256 private _upkeepPaymentsChangeEffectiveTime
```

### _minStaleness

```solidity
uint256 private _minStaleness
```

### _proposedMinStaleness

```solidity
uint256 private _proposedMinStaleness
```

### _minStalenessEffectiveTime

```solidity
uint256 private _minStalenessEffectiveTime
```

### NATIVE_TOKEN

```solidity
address private constant NATIVE_TOKEN = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
```

### USD_TOKEN

```solidity
address private constant USD_TOKEN = address(840)
```

### GAS_QUOTE

```solidity
address private constant GAS_QUOTE = address(uint160(uint256(keccak256("GAS_QUOTE"))))
```

### WEI_QUOTE

```solidity
address private constant WEI_QUOTE = address(uint160(uint256(keccak256("WEI_QUOTE"))))
```

### AVERAGE_PROVIDER

```solidity
bytes32 private constant AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER")
```

### TIMELOCK

```solidity
uint256 private constant TIMELOCK = 7 days
```

### BPS_MAX

```solidity
uint256 private constant BPS_MAX = 10_000
```

### _SUPER_GOVERNOR_ROLE

```solidity
bytes32 private constant _SUPER_GOVERNOR_ROLE = keccak256("SUPER_GOVERNOR_ROLE")
```

### _GOVERNOR_ROLE

```solidity
bytes32 private constant _GOVERNOR_ROLE = keccak256("GOVERNOR_ROLE")
```

### _BANK_MANAGER_ROLE

```solidity
bytes32 private constant _BANK_MANAGER_ROLE = keccak256("BANK_MANAGER_ROLE")
```

### _GUARDIAN_ROLE

```solidity
bytes32 private constant _GUARDIAN_ROLE = keccak256("GUARDIAN_ROLE")
```

### _GAS_MANAGER_ROLE

```solidity
bytes32 private constant _GAS_MANAGER_ROLE = keccak256("GAS_MANAGER_ROLE")
```

### _ORACLE_MANAGER_ROLE

```solidity
bytes32 private constant _ORACLE_MANAGER_ROLE = keccak256("ORACLE_MANAGER_ROLE")
```

### UP

```solidity
bytes32 public constant UP = keccak256("UP")
```

### UPKEEP_TOKEN

```solidity
bytes32 public constant UPKEEP_TOKEN = keccak256("UPKEEP_TOKEN")
```

### SUP_STRATEGY

```solidity
bytes32 public constant SUP_STRATEGY = keccak256("SUP_STRATEGY")
```

### TREASURY

```solidity
bytes32 public constant TREASURY = keccak256("TREASURY")
```

### SUPER_BANK

```solidity
bytes32 public constant SUPER_BANK = keccak256("SUPER_BANK")
```

### SUPER_ORACLE

```solidity
bytes32 public constant SUPER_ORACLE = keccak256("SUPER_ORACLE")
```

### BANK_MANAGER

```solidity
bytes32 public constant BANK_MANAGER = keccak256("BANK_MANAGER")
```

### ECDSAPPSORACLE

```solidity
bytes32 public constant ECDSAPPSORACLE = keccak256("ECDSAPPSORACLE")
```

### SUPER_VAULT_AGGREGATOR

```solidity
bytes32 public constant SUPER_VAULT_AGGREGATOR = keccak256("SUPER_VAULT_AGGREGATOR")
```

### REVENUE_SHARE

```solidity
uint256 public constant REVENUE_SHARE = 0
```

### PERFORMANCE_FEE_SHARE

```solidity
uint256 public constant PERFORMANCE_FEE_SHARE = 5000
```

## Structs

### HookMerkleRootData (inherited from ISuperGovernor)

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

### ValidatorConfig

```solidity
struct ValidatorConfig {
    uint256 version;
    EnumerableSet.AddressSet validators;
    bytes[] validatorPublicKeys;
    uint256 quorum;
}
```

### FeeData

```solidity
struct FeeData {
    uint128 value;
    uint128 proposedValue;
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

### CONTRACT_NOT_FOUND (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when trying to access a contract that is not registered
error CONTRACT_NOT_FOUND();
```

### INVALID_ADDRESS (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when providing an invalid address (typically zero address)
error INVALID_ADDRESS();
```

### HOOK_NOT_APPROVED (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when a hook is not approved but expected to be
error HOOK_NOT_APPROVED();
```

### INVALID_FEE_VALUE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when an invalid fee value is proposed (must be <= BPS_MAX)
error INVALID_FEE_VALUE();
```

### NO_PROPOSED_FEE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no proposed fee exists but one is expected
error NO_PROPOSED_FEE(FeeType feeType);
```

### TIMELOCK_NOT_EXPIRED (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when timelock period has not expired
error TIMELOCK_NOT_EXPIRED();
```

### VALIDATOR_ALREADY_REGISTERED (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when a validator is already registered
error VALIDATOR_ALREADY_REGISTERED();
```

### MUST_USE_TIMELOCK_FOR_CHANGE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when trying to change active PPS oracle directly
error MUST_USE_TIMELOCK_FOR_CHANGE();
```

### INVALID_TIMESTAMP (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when a SuperBank hook Merkle root is not registered but expected to be
///  @dev This error is defined here for use by other contracts in the system (SuperVaultStrategy,
///  SuperVaultAggregator, ECDSAPPSOracle)
error INVALID_TIMESTAMP();
```

### INVALID_QUORUM (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when attempting to set an invalid quorum value (typically zero)
error INVALID_QUORUM();
```

### ARRAY_LENGTH_MISMATCH (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when validator and public key array lengths don't match
error ARRAY_LENGTH_MISMATCH();
```

### EMPTY_VALIDATOR_ARRAY (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when trying to set validator config with an empty validator array
error EMPTY_VALIDATOR_ARRAY();
```

### NO_ACTIVE_PPS_ORACLE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no active PPS oracle is set but one is required
error NO_ACTIVE_PPS_ORACLE();
```

### NO_PROPOSED_PPS_ORACLE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no proposed PPS oracle exists but one is expected
error NO_PROPOSED_PPS_ORACLE();
```

### MANAGER_TAKEOVERS_FROZEN (inherited from ISuperGovernor)

```solidity
/// @notice Error thrown when manager takeovers are frozen
error MANAGER_TAKEOVERS_FROZEN();
```

### NO_PROPOSED_MERKLE_ROOT (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error NO_PROPOSED_MERKLE_ROOT();
```

### ZERO_PROPOSED_MERKLE_ROOT (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error ZERO_PROPOSED_MERKLE_ROOT();
```

### NO_PROPOSED_MIN_STALENESS (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when no proposed minimum staleness exists but one is expected
error NO_PROPOSED_MIN_STALENESS();
```

### MAX_STALENESS_TOO_LOW (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when the provided maxStaleness is less than the minimum required staleness
error MAX_STALENESS_TOO_LOW();
```

### NO_PENDING_CHANGE (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when there's no pending change but one is expected
error NO_PENDING_CHANGE();
```

### SUPER_ORACLE_NOT_FOUND (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when the super oracle is not found
error SUPER_ORACLE_NOT_FOUND();
```

### UP_NOT_FOUND (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when the up token is not found
error UP_NOT_FOUND();
```

### UPKEEP_TOKEN_NOT_FOUND (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when the upkeep token is not found
error UPKEEP_TOKEN_NOT_FOUND();
```

### INVALID_GAS_INFO (inherited from ISuperGovernor)

```solidity
/// @notice Thrown when the gas info is invalid
error INVALID_GAS_INFO();
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

### AddressSet (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when an address is set in the registry
///  @param key The key used to reference the address
///  @param oldValue The old address value
///  @param value The address value
event AddressSet(bytes32 indexed key, address indexed oldValue, address indexed value);
```

### HookApproved (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a hook is approved
///  @param hook The address of the approved hook
event HookApproved(address indexed hook);
```

### ValidatorConfigSet (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when validator configuration is set
///  @param version The version of the configuration
///  @param validators Array of validator addresses
///  @param validatorPublicKeys Array of validator public keys (for signature verification)
///  @param quorum The quorum required for validator consensus
///  @param offchainConfig Offchain configuration data
event ValidatorConfigSet(uint256 version, address[] validators, bytes[] validatorPublicKeys, uint256 quorum, bytes offchainConfig);
```

### HookRemoved (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a hook is removed
///  @param hook The address of the removed hook
event HookRemoved(address indexed hook);
```

### FeeProposed (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a new fee is proposed
///  @param feeType The type of fee being proposed
///  @param value The proposed fee value (in basis points)
///  @param effectiveTime The timestamp when the fee will be effective
event FeeProposed(FeeType indexed feeType, uint256 value, uint256 effectiveTime);
```

### FeeUpdated (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a fee is updated
///  @param feeType The type of fee being updated
///  @param value The new fee value (in basis points)
event FeeUpdated(FeeType indexed feeType, uint256 value);
```

### SuperBankHookMerkleRootProposed (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a new SuperBank hook Merkle root is proposed
///  @param hook The hook address for which the Merkle root is being proposed
///  @param newRoot The new Merkle root
///  @param effectiveTime The timestamp when the new root will be effective
event SuperBankHookMerkleRootProposed(address indexed hook, bytes32 newRoot, uint256 effectiveTime);
```

### SuperBankHookMerkleRootUpdated (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when the SuperBank hook Merkle root is updated.
///  @param hook The address of the hook for which the Merkle root was updated.
///  @param newRoot The new Merkle root.
event SuperBankHookMerkleRootUpdated(address indexed hook, bytes32 newRoot);
```

### ActivePPSOracleSet (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when an active PPS oracle is initially set
///  @param oracle The address of the set oracle
event ActivePPSOracleSet(address indexed oracle);
```

### ActivePPSOracleProposed (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a new PPS oracle is proposed
///  @param oracle The address of the proposed oracle
///  @param effectiveTime The timestamp when the proposal will be effective
event ActivePPSOracleProposed(address indexed oracle, uint256 effectiveTime);
```

### ActivePPSOracleChanged (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when the active PPS oracle is changed
///  @param oldOracle The address of the previous oracle
///  @param newOracle The address of the new oracle
event ActivePPSOracleChanged(address indexed oldOracle, address indexed newOracle);
```

### ManagerTakeoversFrozen (inherited from ISuperGovernor)

```solidity
/// @notice Event emitted when manager takeovers are permanently frozen
event ManagerTakeoversFrozen();
```

### UpkeepPaymentsChangeProposed (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a change to upkeep payments status is proposed
///  @param enabled The proposed status (enabled/disabled)
///  @param effectiveTime The timestamp when the status change will be effective
event UpkeepPaymentsChangeProposed(bool enabled, uint256 effectiveTime);
```

### UpkeepPaymentsChanged (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when upkeep payments status is changed
///  @param enabled The new status (enabled/disabled)
event UpkeepPaymentsChanged(bool enabled);
```

### MinStalenessProposed (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when a new minimum staleness is proposed
///  @param newMinStaleness The proposed minimum staleness value
///  @param effectiveTime The timestamp when the new value will be effective
event MinStalenessProposed(uint256 newMinStaleness, uint256 effectiveTime);
```

### MinStalenessChanged (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when the minimum staleness is changed
///  @param newMinStaleness The new minimum staleness value
event MinStalenessChanged(uint256 newMinStaleness);
```

### GasInfoSet (inherited from ISuperGovernor)

```solidity
/// @notice Emitted when gas info is set
///  @param oracle The address of the oracle
///  @param gasIncreasePerEntryBatch The gas increase per entry for the oracle
event GasInfoSet(address indexed oracle, uint256 gasIncreasePerEntryBatch);
```

## Public/External Functions

### constructor(address,address,address,address,address,address,address,bool)

- **Signature**: `constructor(address,address,address,address,address,address,address,bool)`
- **Visibility**: public
- **Source Range**: 6236:2549:509
- **Details**: [function_constructor_address_address_address_address_address_address_address_bool.md](./function_constructor_address_address_address_address_address_address_address_bool.md)

**Signature:**
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
constructor(address superGovernor, address governor, address bankManager, address oracleManager, address gasManager, address guardian, address treasury, bool upkeepPaymentsEnabled);
```

### setAddress(bytes32,address)

- **Signature**: `setAddress(bytes32,address)`
- **Visibility**: external
- **Source Range**: 9015:292:509
- **Details**: [function_setAddress_bytes32_address.md](./function_setAddress_bytes32_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setAddress(bytes32 key, address value) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### changePrimaryManager(address,address,address)

- **Signature**: `changePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 9531:699:509
- **Details**: [function_changePrimaryManager_address_address_address.md](./function_changePrimaryManager_address_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function changePrimaryManager(address strategy, address newManager, address feeRecipient) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### resetHighWaterMark(address)

- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 10271:367:509
- **Details**: [function_resetHighWaterMark_address.md](./function_resetHighWaterMark_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function resetHighWaterMark(address strategy) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### freezeManagerTakeover()

- **Signature**: `freezeManagerTakeover()`
- **Visibility**: external
- **Source Range**: 10679:344:509
- **Details**: [function_freezeManagerTakeover.md](./function_freezeManagerTakeover.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function freezeManagerTakeover() external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### changeHooksRootUpdateTimelock(uint256)

- **Signature**: `changeHooksRootUpdateTimelock(uint256)`
- **Visibility**: external
- **Source Range**: 11064:559:509
- **Details**: [function_changeHooksRootUpdateTimelock_uint256.md](./function_changeHooksRootUpdateTimelock_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function changeHooksRootUpdateTimelock(uint256 newTimelock) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### proposeGlobalHooksRoot(bytes32)

- **Signature**: `proposeGlobalHooksRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 11664:304:509
- **Details**: [function_proposeGlobalHooksRoot_bytes32.md](./function_proposeGlobalHooksRoot_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function proposeGlobalHooksRoot(bytes32 newRoot) external onlyRole(_GOVERNOR_ROLE);
```

### setGlobalHooksRootVetoStatus(bool)

- **Signature**: `setGlobalHooksRootVetoStatus(bool)`
- **Visibility**: external
- **Source Range**: 12009:311:509
- **Details**: [function_setGlobalHooksRootVetoStatus_bool.md](./function_setGlobalHooksRootVetoStatus_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setGlobalHooksRootVetoStatus(bool vetoed) external onlyRole(_GUARDIAN_ROLE);
```

### setStrategyHooksRootVetoStatus(address,bool)

- **Signature**: `setStrategyHooksRootVetoStatus(address,bool)`
- **Visibility**: external
- **Source Range**: 12361:406:509
- **Details**: [function_setStrategyHooksRootVetoStatus_address_bool.md](./function_setStrategyHooksRootVetoStatus_address_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setStrategyHooksRootVetoStatus(address strategy, bool vetoed) external onlyRole(_GUARDIAN_ROLE);
```

### setOracleMaxStaleness(uint256)

- **Signature**: `setOracleMaxStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 12808:368:509
- **Details**: [function_setOracleMaxStaleness_uint256.md](./function_setOracleMaxStaleness_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setOracleMaxStaleness(uint256 newMaxStaleness) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### setOracleFeedMaxStaleness(address,uint256)

- **Signature**: `setOracleFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 13217:450:509
- **Details**: [function_setOracleFeedMaxStaleness_address_uint256.md](./function_setOracleFeedMaxStaleness_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setOracleFeedMaxStaleness(address feed, uint256 newMaxStaleness) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### setOracleFeedMaxStalenessBatch(address[],uint256[])

- **Signature**: `setOracleFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 13708:626:509
- **Details**: [function_setOracleFeedMaxStalenessBatch_address[]_uint256[].md](./function_setOracleFeedMaxStalenessBatch_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setOracleFeedMaxStalenessBatch(address[] calldata feeds_, uint256[] calldata newMaxStalenessList_) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### queueOracleUpdate(address[],address[],bytes32[],address[])

- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 14375:451:509
- **Details**: [function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md](./function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function queueOracleUpdate(address[] calldata bases_, address[] calldata quotes_, bytes32[] calldata providers_, address[] calldata feeds_) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### executeOracleUpdate()

- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 14867:251:509
- **Details**: [function_executeOracleUpdate.md](./function_executeOracleUpdate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeOracleUpdate() external onlyRole(_ORACLE_MANAGER_ROLE);
```

### queueOracleProviderRemoval(bytes32[])

- **Signature**: `queueOracleProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 15159:296:509
- **Details**: [function_queueOracleProviderRemoval_bytes32[].md](./function_queueOracleProviderRemoval_bytes32[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function queueOracleProviderRemoval(bytes32[] calldata providers) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### batchSetOracleUptimeFeed(address[],address[],uint256[])

- **Signature**: `batchSetOracleUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 15496:456:509
- **Details**: [function_batchSetOracleUptimeFeed_address[]_address[]_uint256[].md](./function_batchSetOracleUptimeFeed_address[]_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function batchSetOracleUptimeFeed(address[] calldata dataOracles_, address[] calldata uptimeOracles_, uint256[] calldata gracePeriods_) external onlyRole(_ORACLE_MANAGER_ROLE);
```

### registerHook(address)

- **Signature**: `registerHook(address)`
- **Visibility**: external
- **Source Range**: 16175:225:509
- **Details**: [function_registerHook_address.md](./function_registerHook_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function registerHook(address hook) external onlyRole(_GOVERNOR_ROLE);
```

### unregisterHook(address)

- **Signature**: `unregisterHook(address)`
- **Visibility**: external
- **Source Range**: 16441:309:509
- **Details**: [function_unregisterHook_address.md](./function_unregisterHook_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function unregisterHook(address hook) external onlyRole(_GOVERNOR_ROLE);
```

### setValidatorConfig(uint256,address[],bytes[],uint256,bytes)

- **Signature**: `setValidatorConfig(uint256,address[],bytes[],uint256,bytes)`
- **Visibility**: external
- **Source Range**: 17191:1509:509
- **Details**: [function_setValidatorConfig_uint256_address[]_bytes[]_uint256_bytes.md](./function_setValidatorConfig_uint256_address[]_bytes[]_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setValidatorConfig(uint256 version, address[] calldata validators, bytes[] calldata validatorPublicKeys, uint256 quorum, bytes calldata offchainConfig) external onlyRole(_GOVERNOR_ROLE);
```

### setActivePPSOracle(address)

- **Signature**: `setActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 18926:500:509
- **Details**: [function_setActivePPSOracle_address.md](./function_setActivePPSOracle_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setActivePPSOracle(address oracle) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### proposeActivePPSOracle(address)

- **Signature**: `proposeActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 19467:345:509
- **Details**: [function_proposeActivePPSOracle_address.md](./function_proposeActivePPSOracle_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function proposeActivePPSOracle(address oracle) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### executeActivePPSOracleChange()

- **Signature**: `executeActivePPSOracleChange()`
- **Visibility**: external
- **Source Range**: 19853:547:509
- **Details**: [function_executeActivePPSOracleChange.md](./function_executeActivePPSOracleChange.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeActivePPSOracleChange() external;
```

### cancelOracleProviderRemoval()

- **Signature**: `cancelOracleProviderRemoval()`
- **Visibility**: external
- **Source Range**: 20441:261:509
- **Details**: [function_cancelOracleProviderRemoval.md](./function_cancelOracleProviderRemoval.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function cancelOracleProviderRemoval() external onlyRole(_ORACLE_MANAGER_ROLE);
```

### executeOracleProviderRemoval()

- **Signature**: `executeOracleProviderRemoval()`
- **Visibility**: external
- **Source Range**: 20743:263:509
- **Details**: [function_executeOracleProviderRemoval.md](./function_executeOracleProviderRemoval.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeOracleProviderRemoval() external onlyRole(_ORACLE_MANAGER_ROLE);
```

### proposeFee(enum FeeType,uint256)

- **Signature**: `proposeFee(enum FeeType,uint256)`
- **Visibility**: external
- **Source Range**: 21232:534:509
- **Details**: [function_proposeFee_enum_FeeType_uint256.md](./function_proposeFee_enum_FeeType_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function proposeFee(FeeType feeType, uint256 value) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### executeFeeUpdate(enum FeeType)

- **Signature**: `executeFeeUpdate(enum FeeType)`
- **Visibility**: external
- **Source Range**: 21807:578:509
- **Details**: [function_executeFeeUpdate_enum_FeeType.md](./function_executeFeeUpdate_enum_FeeType.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeFeeUpdate(FeeType feeType) external;
```

### executeUpkeepClaim(uint256)

- **Signature**: `executeUpkeepClaim(uint256)`
- **Visibility**: external
- **Source Range**: 22426:287:509
- **Details**: [function_executeUpkeepClaim_uint256.md](./function_executeUpkeepClaim_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeUpkeepClaim(uint256 amount) external onlyRole(_GOVERNOR_ROLE);
```

### setGasInfo(address,uint256)

- **Signature**: `setGasInfo(address,uint256)`
- **Visibility**: external
- **Source Range**: 22939:361:509
- **Details**: [function_setGasInfo_address_uint256.md](./function_setGasInfo_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function setGasInfo(address oracle, uint256 gasIncreasePerEntryBatch) external onlyRole(_GAS_MANAGER_ROLE);
```

### proposeUpkeepPaymentsChange(bool)

- **Signature**: `proposeUpkeepPaymentsChange(bool)`
- **Visibility**: external
- **Source Range**: 23480:310:509
- **Details**: [function_proposeUpkeepPaymentsChange_bool.md](./function_proposeUpkeepPaymentsChange_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
///  @notice Proposes a change to the upkeep payments enabled status
///  @param enabled The proposed new status for upkeep payments
function proposeUpkeepPaymentsChange(bool enabled) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### executeUpkeepPaymentsChange()

- **Signature**: `executeUpkeepPaymentsChange()`
- **Visibility**: external
- **Source Range**: 23934:456:509
- **Details**: [function_executeUpkeepPaymentsChange.md](./function_executeUpkeepPaymentsChange.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
///  @notice Executes a previously proposed change to upkeep payments status after timelock expires
function executeUpkeepPaymentsChange() external;
```

### proposeMinStaleness(uint256)

- **Signature**: `proposeMinStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 24618:296:509
- **Details**: [function_proposeMinStaleness_uint256.md](./function_proposeMinStaleness_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function proposeMinStaleness(uint256 newMinStaleness) external onlyRole(_SUPER_GOVERNOR_ROLE);
```

### executeMinStalenessChange()

- **Signature**: `executeMinStalenessChange()`
- **Visibility**: external
- **Source Range**: 24955:498:509
- **Details**: [function_executeMinStalenessChange.md](./function_executeMinStalenessChange.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeMinStalenessChange() external;
```

### proposeSuperBankHookMerkleRoot(address,bytes32)

- **Signature**: `proposeSuperBankHookMerkleRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 25680:586:509
- **Details**: [function_proposeSuperBankHookMerkleRoot_address_bytes32.md](./function_proposeSuperBankHookMerkleRoot_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function proposeSuperBankHookMerkleRoot(address hook, bytes32 proposedRoot) external onlyRole(_GOVERNOR_ROLE);
```

### executeSuperBankHookMerkleRootUpdate(address)

- **Signature**: `executeSuperBankHookMerkleRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 26307:789:509
- **Details**: [function_executeSuperBankHookMerkleRootUpdate_address.md](./function_executeSuperBankHookMerkleRootUpdate_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function executeSuperBankHookMerkleRootUpdate(address hook) external;
```

### SUPER_GOVERNOR_ROLE()

- **Signature**: `SUPER_GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 27324:107:509
- **Details**: [function_SUPER_GOVERNOR_ROLE.md](./function_SUPER_GOVERNOR_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function SUPER_GOVERNOR_ROLE() external pure returns (bytes32);
```

### GOVERNOR_ROLE()

- **Signature**: `GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 27472:95:509
- **Details**: [function_GOVERNOR_ROLE.md](./function_GOVERNOR_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function GOVERNOR_ROLE() external pure returns (bytes32);
```

### BANK_MANAGER_ROLE()

- **Signature**: `BANK_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27608:103:509
- **Details**: [function_BANK_MANAGER_ROLE.md](./function_BANK_MANAGER_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function BANK_MANAGER_ROLE() external pure returns (bytes32);
```

### GAS_MANAGER_ROLE()

- **Signature**: `GAS_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27752:101:509
- **Details**: [function_GAS_MANAGER_ROLE.md](./function_GAS_MANAGER_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function GAS_MANAGER_ROLE() external pure returns (bytes32);
```

### ORACLE_MANAGER_ROLE()

- **Signature**: `ORACLE_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27894:107:509
- **Details**: [function_ORACLE_MANAGER_ROLE.md](./function_ORACLE_MANAGER_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function ORACLE_MANAGER_ROLE() external pure returns (bytes32);
```

### GUARDIAN_ROLE()

- **Signature**: `GUARDIAN_ROLE()`
- **Visibility**: external
- **Source Range**: 28042:95:509
- **Details**: [function_GUARDIAN_ROLE.md](./function_GUARDIAN_ROLE.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function GUARDIAN_ROLE() external pure returns (bytes32);
```

### getAddress(bytes32)

- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 28178:203:509
- **Details**: [function_getAddress_bytes32.md](./function_getAddress_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getAddress(bytes32 key) external view returns (address);
```

### isManagerTakeoverFrozen()

- **Signature**: `isManagerTakeoverFrozen()`
- **Visibility**: external
- **Source Range**: 28422:111:509
- **Details**: [function_isManagerTakeoverFrozen.md](./function_isManagerTakeoverFrozen.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isManagerTakeoverFrozen() external view returns (bool);
```

### isHookRegistered(address)

- **Signature**: `isHookRegistered(address)`
- **Visibility**: external
- **Source Range**: 28574:124:509
- **Details**: [function_isHookRegistered_address.md](./function_isHookRegistered_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isHookRegistered(address hook) external view returns (bool);
```

### getRegisteredHooks()

- **Signature**: `getRegisteredHooks()`
- **Visibility**: external
- **Source Range**: 28739:120:509
- **Details**: [function_getRegisteredHooks.md](./function_getRegisteredHooks.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getRegisteredHooks() external view returns (address[] memory);
```

### getValidatorConfig()

- **Signature**: `getValidatorConfig()`
- **Visibility**: external
- **Source Range**: 28900:388:509
- **Details**: [function_getValidatorConfig.md](./function_getValidatorConfig.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getValidatorConfig() external view returns (uint256 version, address[] memory validators, bytes[] memory validatorPublicKeys, uint256 quorum);
```

### isValidator(address)

- **Signature**: `isValidator(address)`
- **Visibility**: external
- **Source Range**: 29329:140:509
- **Details**: [function_isValidator_address.md](./function_isValidator_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isValidator(address validator) external view returns (bool);
```

### isGuardian(address)

- **Signature**: `isGuardian(address)`
- **Visibility**: external
- **Source Range**: 29510:124:509
- **Details**: [function_isGuardian_address.md](./function_isGuardian_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isGuardian(address guardian) external view returns (bool);
```

### getValidators()

- **Signature**: `getValidators()`
- **Visibility**: external
- **Source Range**: 29675:126:509
- **Details**: [function_getValidators.md](./function_getValidators.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getValidators() external view returns (address[] memory);
```

### getValidatorsCount()

- **Signature**: `getValidatorsCount()`
- **Visibility**: external
- **Source Range**: 29842:122:509
- **Details**: [function_getValidatorsCount.md](./function_getValidatorsCount.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getValidatorsCount() external view returns (uint256);
```

### getValidatorAt(uint256)

- **Signature**: `getValidatorAt(uint256)`
- **Visibility**: external
- **Source Range**: 30005:132:509
- **Details**: [function_getValidatorAt_uint256.md](./function_getValidatorAt_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getValidatorAt(uint256 index) external view returns (address);
```

### getProposedActivePPSOracle()

- **Signature**: `getProposedActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 30178:189:509
- **Details**: [function_getProposedActivePPSOracle.md](./function_getProposedActivePPSOracle.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getProposedActivePPSOracle() external view returns (address proposedOracle, uint256 effectiveTime);
```

### getPPSOracleQuorum()

- **Signature**: `getPPSOracleQuorum()`
- **Visibility**: external
- **Source Range**: 30408:109:509
- **Details**: [function_getPPSOracleQuorum.md](./function_getPPSOracleQuorum.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getPPSOracleQuorum() external view returns (uint256);
```

### getActivePPSOracle()

- **Signature**: `getActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 30558:177:509
- **Details**: [function_getActivePPSOracle.md](./function_getActivePPSOracle.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getActivePPSOracle() external view returns (address);
```

### isActivePPSOracle(address)

- **Signature**: `isActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 30776:122:509
- **Details**: [function_isActivePPSOracle_address.md](./function_isActivePPSOracle_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isActivePPSOracle(address oracle) external view returns (bool);
```

### getFee(enum FeeType)

- **Signature**: `getFee(enum FeeType)`
- **Visibility**: external
- **Source Range**: 30939:112:509
- **Details**: [function_getFee_enum_FeeType.md](./function_getFee_enum_FeeType.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getFee(FeeType feeType) external view returns (uint256);
```

### getGasInfo(address)

- **Signature**: `getGasInfo(address)`
- **Visibility**: external
- **Source Range**: 31092:114:509
- **Details**: [function_getGasInfo_address.md](./function_getGasInfo_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getGasInfo(address oracle_) external view returns (uint256);
```

### getUpkeepCostPerSingleUpdate(address)

- **Signature**: `getUpkeepCostPerSingleUpdate(address)`
- **Visibility**: external
- **Source Range**: 31247:158:509
- **Details**: [function_getUpkeepCostPerSingleUpdate_address.md](./function_getUpkeepCostPerSingleUpdate_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getUpkeepCostPerSingleUpdate(address oracle_) external view returns (uint256);
```

### getMinStaleness()

- **Signature**: `getMinStaleness()`
- **Visibility**: external
- **Source Range**: 31446:96:509
- **Details**: [function_getMinStaleness.md](./function_getMinStaleness.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getMinStaleness() external view returns (uint256);
```

### getProposedMinStaleness()

- **Signature**: `getProposedMinStaleness()`
- **Visibility**: external
- **Source Range**: 31583:186:509
- **Details**: [function_getProposedMinStaleness.md](./function_getProposedMinStaleness.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getProposedMinStaleness() external view returns (uint256 proposedMinStaleness, uint256 effectiveTime);
```

### getSuperBankHookMerkleRoot(address)

- **Signature**: `getSuperBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 31810:223:509
- **Details**: [function_getSuperBankHookMerkleRoot_address.md](./function_getSuperBankHookMerkleRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getSuperBankHookMerkleRoot(address hook) external view returns (bytes32);
```

### getProposedSuperBankHookMerkleRoot(address)

- **Signature**: `getProposedSuperBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 32074:381:509
- **Details**: [function_getProposedSuperBankHookMerkleRoot_address.md](./function_getProposedSuperBankHookMerkleRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getProposedSuperBankHookMerkleRoot(address hook) external view returns (bytes32 proposedRoot, uint256 effectiveTime);
```

### isUpkeepPaymentsEnabled()

- **Signature**: `isUpkeepPaymentsEnabled()`
- **Visibility**: external
- **Source Range**: 32496:118:509
- **Details**: [function_isUpkeepPaymentsEnabled.md](./function_isUpkeepPaymentsEnabled.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function isUpkeepPaymentsEnabled() external view returns (bool enabled);
```

### getProposedUpkeepPaymentsStatus()

- **Signature**: `getProposedUpkeepPaymentsStatus()`
- **Visibility**: external
- **Source Range**: 32655:195:509
- **Details**: [function_getProposedUpkeepPaymentsStatus.md](./function_getProposedUpkeepPaymentsStatus.md)

**Signature:**
```solidity
/// @inheritdoc ISuperGovernor
function getProposedUpkeepPaymentsStatus() external view returns (bool enabled, uint256 effectiveTime);
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 32924:209:509
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @dev Advertise ISuperGovernor support for ERC-165 detection
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
