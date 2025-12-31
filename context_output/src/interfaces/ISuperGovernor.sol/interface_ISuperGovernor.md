# Interface: ISuperGovernor

## Metadata

- **Name**: ISuperGovernor
- **Type**: Interface
- **Path**: src/interfaces/ISuperGovernor.sol
- **Documentation**: @title ISuperGovernor
   @author Superform Labs
   @notice Interface for the SuperGovernor contract
   @dev Central registry for all deployed contracts in the Superform periphery

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

### CONTRACT_NOT_FOUND

```solidity
/// @notice Thrown when trying to access a contract that is not registered
error CONTRACT_NOT_FOUND();
```

### INVALID_ADDRESS

```solidity
/// @notice Thrown when providing an invalid address (typically zero address)
error INVALID_ADDRESS();
```

### HOOK_NOT_APPROVED

```solidity
/// @notice Thrown when a hook is not approved but expected to be
error HOOK_NOT_APPROVED();
```

### INVALID_FEE_VALUE

```solidity
/// @notice Thrown when an invalid fee value is proposed (must be <= BPS_MAX)
error INVALID_FEE_VALUE();
```

### NO_PROPOSED_FEE

```solidity
/// @notice Thrown when no proposed fee exists but one is expected
error NO_PROPOSED_FEE(FeeType feeType);
```

### TIMELOCK_NOT_EXPIRED

```solidity
/// @notice Thrown when timelock period has not expired
error TIMELOCK_NOT_EXPIRED();
```

### VALIDATOR_ALREADY_REGISTERED

```solidity
/// @notice Thrown when a validator is already registered
error VALIDATOR_ALREADY_REGISTERED();
```

### MUST_USE_TIMELOCK_FOR_CHANGE

```solidity
/// @notice Thrown when trying to change active PPS oracle directly
error MUST_USE_TIMELOCK_FOR_CHANGE();
```

### INVALID_TIMESTAMP

```solidity
/// @notice Thrown when a SuperBank hook Merkle root is not registered but expected to be
///  @dev This error is defined here for use by other contracts in the system (SuperVaultStrategy,
///  SuperVaultAggregator, ECDSAPPSOracle)
error INVALID_TIMESTAMP();
```

### INVALID_QUORUM

```solidity
/// @notice Thrown when attempting to set an invalid quorum value (typically zero)
error INVALID_QUORUM();
```

### ARRAY_LENGTH_MISMATCH

```solidity
/// @notice Thrown when validator and public key array lengths don't match
error ARRAY_LENGTH_MISMATCH();
```

### EMPTY_VALIDATOR_ARRAY

```solidity
/// @notice Thrown when trying to set validator config with an empty validator array
error EMPTY_VALIDATOR_ARRAY();
```

### NO_ACTIVE_PPS_ORACLE

```solidity
/// @notice Thrown when no active PPS oracle is set but one is required
error NO_ACTIVE_PPS_ORACLE();
```

### NO_PROPOSED_PPS_ORACLE

```solidity
/// @notice Thrown when no proposed PPS oracle exists but one is expected
error NO_PROPOSED_PPS_ORACLE();
```

### MANAGER_TAKEOVERS_FROZEN

```solidity
/// @notice Error thrown when manager takeovers are frozen
error MANAGER_TAKEOVERS_FROZEN();
```

### NO_PROPOSED_MERKLE_ROOT

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error NO_PROPOSED_MERKLE_ROOT();
```

### ZERO_PROPOSED_MERKLE_ROOT

```solidity
/// @notice Thrown when no proposed Merkle root exists but one is expected
error ZERO_PROPOSED_MERKLE_ROOT();
```

### NO_PROPOSED_MIN_STALENESS

```solidity
/// @notice Thrown when no proposed minimum staleness exists but one is expected
error NO_PROPOSED_MIN_STALENESS();
```

### MAX_STALENESS_TOO_LOW

```solidity
/// @notice Thrown when the provided maxStaleness is less than the minimum required staleness
error MAX_STALENESS_TOO_LOW();
```

### NO_PENDING_CHANGE

```solidity
/// @notice Thrown when there's no pending change but one is expected
error NO_PENDING_CHANGE();
```

### SUPER_ORACLE_NOT_FOUND

```solidity
/// @notice Thrown when the super oracle is not found
error SUPER_ORACLE_NOT_FOUND();
```

### UP_NOT_FOUND

```solidity
/// @notice Thrown when the up token is not found
error UP_NOT_FOUND();
```

### UPKEEP_TOKEN_NOT_FOUND

```solidity
/// @notice Thrown when the upkeep token is not found
error UPKEEP_TOKEN_NOT_FOUND();
```

### INVALID_GAS_INFO

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

### AddressSet

```solidity
/// @notice Emitted when an address is set in the registry
///  @param key The key used to reference the address
///  @param oldValue The old address value
///  @param value The address value
event AddressSet(bytes32 indexed key, address indexed oldValue, address indexed value);
```

### HookApproved

```solidity
/// @notice Emitted when a hook is approved
///  @param hook The address of the approved hook
event HookApproved(address indexed hook);
```

### ValidatorConfigSet

```solidity
/// @notice Emitted when validator configuration is set
///  @param version The version of the configuration
///  @param validators Array of validator addresses
///  @param validatorPublicKeys Array of validator public keys (for signature verification)
///  @param quorum The quorum required for validator consensus
///  @param offchainConfig Offchain configuration data
event ValidatorConfigSet(uint256 version, address[] validators, bytes[] validatorPublicKeys, uint256 quorum, bytes offchainConfig);
```

### HookRemoved

```solidity
/// @notice Emitted when a hook is removed
///  @param hook The address of the removed hook
event HookRemoved(address indexed hook);
```

### FeeProposed

```solidity
/// @notice Emitted when a new fee is proposed
///  @param feeType The type of fee being proposed
///  @param value The proposed fee value (in basis points)
///  @param effectiveTime The timestamp when the fee will be effective
event FeeProposed(FeeType indexed feeType, uint256 value, uint256 effectiveTime);
```

### FeeUpdated

```solidity
/// @notice Emitted when a fee is updated
///  @param feeType The type of fee being updated
///  @param value The new fee value (in basis points)
event FeeUpdated(FeeType indexed feeType, uint256 value);
```

### SuperBankHookMerkleRootProposed

```solidity
/// @notice Emitted when a new SuperBank hook Merkle root is proposed
///  @param hook The hook address for which the Merkle root is being proposed
///  @param newRoot The new Merkle root
///  @param effectiveTime The timestamp when the new root will be effective
event SuperBankHookMerkleRootProposed(address indexed hook, bytes32 newRoot, uint256 effectiveTime);
```

### SuperBankHookMerkleRootUpdated

```solidity
/// @notice Emitted when the SuperBank hook Merkle root is updated.
///  @param hook The address of the hook for which the Merkle root was updated.
///  @param newRoot The new Merkle root.
event SuperBankHookMerkleRootUpdated(address indexed hook, bytes32 newRoot);
```

### ActivePPSOracleSet

```solidity
/// @notice Emitted when an active PPS oracle is initially set
///  @param oracle The address of the set oracle
event ActivePPSOracleSet(address indexed oracle);
```

### ActivePPSOracleProposed

```solidity
/// @notice Emitted when a new PPS oracle is proposed
///  @param oracle The address of the proposed oracle
///  @param effectiveTime The timestamp when the proposal will be effective
event ActivePPSOracleProposed(address indexed oracle, uint256 effectiveTime);
```

### ActivePPSOracleChanged

```solidity
/// @notice Emitted when the active PPS oracle is changed
///  @param oldOracle The address of the previous oracle
///  @param newOracle The address of the new oracle
event ActivePPSOracleChanged(address indexed oldOracle, address indexed newOracle);
```

### ManagerTakeoversFrozen

```solidity
/// @notice Event emitted when manager takeovers are permanently frozen
event ManagerTakeoversFrozen();
```

### UpkeepPaymentsChangeProposed

```solidity
/// @notice Emitted when a change to upkeep payments status is proposed
///  @param enabled The proposed status (enabled/disabled)
///  @param effectiveTime The timestamp when the status change will be effective
event UpkeepPaymentsChangeProposed(bool enabled, uint256 effectiveTime);
```

### UpkeepPaymentsChanged

```solidity
/// @notice Emitted when upkeep payments status is changed
///  @param enabled The new status (enabled/disabled)
event UpkeepPaymentsChanged(bool enabled);
```

### MinStalenessProposed

```solidity
/// @notice Emitted when a new minimum staleness is proposed
///  @param newMinStaleness The proposed minimum staleness value
///  @param effectiveTime The timestamp when the new value will be effective
event MinStalenessProposed(uint256 newMinStaleness, uint256 effectiveTime);
```

### MinStalenessChanged

```solidity
/// @notice Emitted when the minimum staleness is changed
///  @param newMinStaleness The new minimum staleness value
event MinStalenessChanged(uint256 newMinStaleness);
```

### GasInfoSet

```solidity
/// @notice Emitted when gas info is set
///  @param oracle The address of the oracle
///  @param gasIncreasePerEntryBatch The gas increase per entry for the oracle
event GasInfoSet(address indexed oracle, uint256 gasIncreasePerEntryBatch);
```

## Public/External Functions

### setAddress(bytes32,address)

- **Signature**: `setAddress(bytes32,address)`
- **Visibility**: external
- **Source Range**: 9049:57:518

**Signature:**
```solidity
/// @notice Sets an address in the registry
///  @param key The key to associate with the address
///  @param value The address value
function setAddress(bytes32 key, address value) external;;
```

### changePrimaryManager(address,address,address)

- **Signature**: `changePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 9583:99:518

**Signature:**
```solidity
/// @notice Change the primary manager for a strategy
///  @dev Only SuperGovernor can call this function directly
///  @param strategy The strategy address
///  @param newManager The new primary manager address
///  @param feeRecipient The new fee recipient address
function changePrimaryManager(address strategy, address newManager, address feeRecipient) external;;
```

### resetHighWaterMark(address)

- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 10262:55:518

**Signature:**
```solidity
/// @notice Resets the high-water mark PPS to the current PPS
///  @dev Only SuperGovernor can call this function
///  @dev If a manager is replaced while the strategy is below its
///  previous HWM, the new manager would otherwise inherit a "loss" state and be unable to earn performance fees
///  until the fee config are updated after the week timelock.
///  @dev This function will reset the High Water Mark (vaultHwmPps) to the current PPS value for the given strategy
///  @param strategy Address of the strategy to reset the high-water mark for
function resetHighWaterMark(address strategy) external;;
```

### freezeManagerTakeover()

- **Signature**: `freezeManagerTakeover()`
- **Visibility**: external
- **Source Range**: 10390:42:518

**Signature:**
```solidity
/// @notice Permanently freezes all manager takeovers globally
function freezeManagerTakeover() external;;
```

### changeHooksRootUpdateTimelock(uint256)

- **Signature**: `changeHooksRootUpdateTimelock(uint256)`
- **Visibility**: external
- **Source Range**: 10562:69:518

**Signature:**
```solidity
/// @notice Changes the hooks root update timelock duration
///  @param newTimelock New timelock duration in seconds
function changeHooksRootUpdateTimelock(uint256 newTimelock) external;;
```

### proposeGlobalHooksRoot(bytes32)

- **Signature**: `proposeGlobalHooksRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 10815:58:518

**Signature:**
```solidity
/// @notice Proposes a new global hooks Merkle root
///  @dev Only GOVERNOR_ROLE can call this function
///  @param newRoot New Merkle root for global hooks validation
function proposeGlobalHooksRoot(bytes32 newRoot) external;;
```

### setGlobalHooksRootVetoStatus(bool)

- **Signature**: `setGlobalHooksRootVetoStatus(bool)`
- **Visibility**: external
- **Source Range**: 11081:60:518

**Signature:**
```solidity
/// @notice Sets veto status for global hooks Merkle root
///  @dev Only GUARDIAN_ROLE can call this function
///  @param vetoed Whether to veto (true) or unveto (false) the global hooks root
function setGlobalHooksRootVetoStatus(bool vetoed) external;;
```

### setStrategyHooksRootVetoStatus(address,bool)

- **Signature**: `setStrategyHooksRootVetoStatus(address,bool)`
- **Visibility**: external
- **Source Range**: 11422:80:518

**Signature:**
```solidity
/// @notice Sets veto status for a strategy-specific hooks Merkle root
///  @dev Only GUARDIAN_ROLE can call this function
///  @param strategy Address of the strategy to affect
///  @param vetoed Whether to veto (true) or unveto (false) the strategy hooks root
function setStrategyHooksRootVetoStatus(address strategy, bool vetoed) external;;
```

### setOracleMaxStaleness(uint256)

- **Signature**: `setOracleMaxStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 11654:65:518

**Signature:**
```solidity
/// @notice Sets the maximum staleness period for all oracle feeds
///  @param newMaxStaleness The new maximum staleness period in seconds
function setOracleMaxStaleness(uint256 newMaxStaleness) external;;
```

### setOracleFeedMaxStaleness(address,uint256)

- **Signature**: `setOracleFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 11942:83:518

**Signature:**
```solidity
/// @notice Sets the maximum staleness period for a specific oracle feed
///  @param feed The address of the feed to set staleness for
///  @param newMaxStaleness The new maximum staleness period in seconds
function setOracleFeedMaxStaleness(address feed, uint256 newMaxStaleness) external;;
```

### setOracleFeedMaxStalenessBatch(address[],uint256[])

- **Signature**: `setOracleFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 12266:115:518

**Signature:**
```solidity
/// @notice Sets the maximum staleness periods for multiple oracle feeds in batch
///  @param feeds The addresses of the feeds to set staleness for
///  @param newMaxStalenessList The new maximum staleness periods in seconds
function setOracleFeedMaxStalenessBatch(address[] calldata feeds, uint256[] calldata newMaxStalenessList) external;;
```

### queueOracleUpdate(address[],address[],bytes32[],address[])

- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 12631:191:518

**Signature:**
```solidity
/// @notice Queues an oracle update for execution after timelock period
///  @param bases Base asset addresses
///  @param quotes Quote asset addresses
///  @param providers Provider identifiers
///  @param feeds Feed addresses
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external;;
```

### executeOracleUpdate()

- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 12914:40:518

**Signature:**
```solidity
/// @notice Executes a previously queued oracle update after timelock has expired
function executeOracleUpdate() external;;
```

### queueOracleProviderRemoval(bytes32[])

- **Signature**: `queueOracleProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 13087:75:518

**Signature:**
```solidity
/// @notice Queues a provider removal for execution after timelock period
///  @param providers The providers to remove
function queueOracleProviderRemoval(bytes32[] calldata providers) external;;
```

### batchSetOracleUptimeFeed(address[],address[],uint256[])

- **Signature**: `batchSetOracleUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 13487:180:518

**Signature:**
```solidity
/// @notice Sets uptime feeds for multiple data oracles in batch (Layer 2 only)
///  @param dataOracles Array of data oracle addresses to set uptime feeds for
///  @param uptimeOracles Array of uptime feed addresses to set
///  @param gracePeriods Array of grace periods in seconds after sequencer restart
function batchSetOracleUptimeFeed(address[] calldata dataOracles, address[] calldata uptimeOracles, uint256[] calldata gracePeriods) external;;
```

### registerHook(address)

- **Signature**: `registerHook(address)`
- **Visibility**: external
- **Source Range**: 13965:45:518

**Signature:**
```solidity
/// @notice Registers a hook for use in SuperVaults
///  @param hook The address of the hook to register
function registerHook(address hook) external;;
```

### unregisterHook(address)

- **Signature**: `unregisterHook(address)`
- **Visibility**: external
- **Source Range**: 14132:47:518

**Signature:**
```solidity
/// @notice Unregisters a hook from the approved list
///  @param hook The address of the hook to unregister
function unregisterHook(address hook) external;;
```

### setValidatorConfig(uint256,address[],bytes[],uint256,bytes)

- **Signature**: `setValidatorConfig(uint256,address[],bytes[],uint256,bytes)`
- **Visibility**: external
- **Source Range**: 15145:224:518

**Signature:**
```solidity
/// @notice Sets the validator configuration for the protocol
///  @dev This function atomically updates all validator configuration including quorum.
///       The entire validator set is replaced (not incrementally updated).
///       Version must be managed externally for cross-chain synchronization.
///       Quorum updates require providing the full validator list.
///  @param version The version number for the configuration (for cross-chain sync)
///  @param validators Array of validator addresses
///  @param validatorPublicKeys Array of validator public keys for signature verification
///  @param quorum The number of validators required for consensus
///  @param offchainConfig Offchain configuration data (emitted but not stored)
function setValidatorConfig(uint256 version, address[] calldata validators, bytes[] calldata validatorPublicKeys, uint256 quorum, bytes calldata offchainConfig) external;;
```

### setActivePPSOracle(address)

- **Signature**: `setActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 15706:53:518

**Signature:**
```solidity
/// @notice Sets the active PPS oracle (only if there is no active oracle yet)
///  @param oracle Address of the PPS oracle to set as active
function setActivePPSOracle(address oracle) external;;
```

### proposeActivePPSOracle(address)

- **Signature**: `proposeActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 15921:57:518

**Signature:**
```solidity
/// @notice Proposes a new active PPS oracle (when there is already an active one)
///  @param oracle Address of the PPS oracle to propose as active
function proposeActivePPSOracle(address oracle) external;;
```

### executeActivePPSOracleChange()

- **Signature**: `executeActivePPSOracleChange()`
- **Visibility**: external
- **Source Range**: 16076:49:518

**Signature:**
```solidity
/// @notice Executes a previously proposed PPS oracle change after timelock has expired
function executeActivePPSOracleChange() external;;
```

### proposeFee(enum FeeType,uint256)

- **Signature**: `proposeFee(enum FeeType,uint256)`
- **Visibility**: external
- **Source Range**: 16469:61:518

**Signature:**
```solidity
/// @notice Proposes a new fee value
///  @param feeType The type of fee to propose
///  @param value The proposed fee value (in basis points)
function proposeFee(FeeType feeType, uint256 value) external;;
```

### executeFeeUpdate(enum FeeType)

- **Signature**: `executeFeeUpdate(enum FeeType)`
- **Visibility**: external
- **Source Range**: 16687:52:518

**Signature:**
```solidity
/// @notice Executes a previously proposed fee update after timelock has expired
///  @param feeType The type of ffee to execute the update for
function executeFeeUpdate(FeeType feeType) external;;
```

### executeUpkeepClaim(uint256)

- **Signature**: `executeUpkeepClaim(uint256)`
- **Visibility**: external
- **Source Range**: 16854:53:518

**Signature:**
```solidity
/// @notice Executes an upkeep claim on `SuperVaultAggregator`
///  @param amount The amount to claim
function executeUpkeepClaim(uint256 amount) external;;
```

### setGasInfo(address,uint256)

- **Signature**: `setGasInfo(address,uint256)`
- **Visibility**: external
- **Source Range**: 17270:79:518

**Signature:**
```solidity
/// @notice Sets gas info for an oracle
///  @param oracle The address of the oracle
///  @param gasIncreasePerEntryBatch The gas increase per entry for the oracle
function setGasInfo(address oracle, uint256 gasIncreasePerEntryBatch) external;;
```

### proposeUpkeepPaymentsChange(bool)

- **Signature**: `proposeUpkeepPaymentsChange(bool)`
- **Visibility**: external
- **Source Range**: 17474:60:518

**Signature:**
```solidity
/// @notice Proposes a change to upkeep payments enabled status
///  @param enabled The proposed enabled status
function proposeUpkeepPaymentsChange(bool enabled) external;;
```

### executeUpkeepPaymentsChange()

- **Signature**: `executeUpkeepPaymentsChange()`
- **Visibility**: external
- **Source Range**: 17617:48:518

**Signature:**
```solidity
/// @notice Executes a previously proposed upkeep payments status change
function executeUpkeepPaymentsChange() external;;
```

### proposeMinStaleness(uint256)

- **Signature**: `proposeMinStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 18043:63:518

**Signature:**
```solidity
/// @notice Proposes a new minimum staleness value to prevent maxStaleness from being set too low
///  @param newMinStaleness The proposed new minimum staleness value in seconds
function proposeMinStaleness(uint256 newMinStaleness) external;;
```

### executeMinStalenessChange()

- **Signature**: `executeMinStalenessChange()`
- **Visibility**: external
- **Source Range**: 18211:46:518

**Signature:**
```solidity
/// @notice Executes a previously proposed minimum staleness change after timelock has expired
function executeMinStalenessChange() external;;
```

### proposeSuperBankHookMerkleRoot(address,bytes32)

- **Signature**: `proposeSuperBankHookMerkleRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 18664:85:518

**Signature:**
```solidity
/// @notice Proposes a new Merkle root for a specific hook's allowed targets.
///  @param hook The address of the hook to update the Merkle root for.
///  @param proposedRoot The proposed new Merkle root.
function proposeSuperBankHookMerkleRoot(address hook, bytes32 proposedRoot) external;;
```

### executeSuperBankHookMerkleRootUpdate(address)

- **Signature**: `executeSuperBankHookMerkleRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 18946:69:518

**Signature:**
```solidity
/// @notice Executes a previously proposed Merkle root update for a specific hook if the effective time has passed.
///  @param hook The address of the hook to execute the update for.
function executeSuperBankHookMerkleRootUpdate(address hook) external;;
```

### SUPER_GOVERNOR_ROLE()

- **Signature**: `SUPER_GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 19302:63:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to critical governance functions
function SUPER_GOVERNOR_ROLE() external view returns (bytes32);;
```

### GOVERNOR_ROLE()

- **Signature**: `GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 19479:57:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to daily operations like hooks and validators
function GOVERNOR_ROLE() external view returns (bytes32);;
```

### BANK_MANAGER_ROLE()

- **Signature**: `BANK_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 19633:61:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to bank management functions
function BANK_MANAGER_ROLE() external view returns (bytes32);;
```

### GAS_MANAGER_ROLE()

- **Signature**: `GAS_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 19790:60:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to gas management functions
function GAS_MANAGER_ROLE() external view returns (bytes32);;
```

### ORACLE_MANAGER_ROLE()

- **Signature**: `ORACLE_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 19949:63:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to oracle management functions
function ORACLE_MANAGER_ROLE() external view returns (bytes32);;
```

### GUARDIAN_ROLE()

- **Signature**: `GUARDIAN_ROLE()`
- **Visibility**: external
- **Source Range**: 20102:57:518

**Signature:**
```solidity
/// @notice The identifier of the role that grants access to guardian functions
function GUARDIAN_ROLE() external view returns (bytes32);;
```

### getAddress(bytes32)

- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 20298:65:518

**Signature:**
```solidity
/// @notice Gets an address from the registry
///  @param key The key of the address to get
///  @return The address value
function getAddress(bytes32 key) external view returns (address);;
```

### isManagerTakeoverFrozen()

- **Signature**: `isManagerTakeoverFrozen()`
- **Visibility**: external
- **Source Range**: 20494:64:518

**Signature:**
```solidity
/// @notice Checks if manager takeovers are frozen
///  @return True if manager takeovers are frozen, false otherwise
function isManagerTakeoverFrozen() external view returns (bool);;
```

### isHookRegistered(address)

- **Signature**: `isHookRegistered(address)`
- **Visibility**: external
- **Source Range**: 20728:69:518

**Signature:**
```solidity
/// @notice Checks if a hook is registered
///  @param hook The address of the hook to check
///  @return True if the hook is registered, false otherwise
function isHookRegistered(address hook) external view returns (bool);;
```

### getRegisteredHooks()

- **Signature**: `getRegisteredHooks()`
- **Visibility**: external
- **Source Range**: 20899:71:518

**Signature:**
```solidity
/// @notice Gets all registered hooks
///  @return An array of registered hook addresses
function getRegisteredHooks() external view returns (address[] memory);;
```

### isValidator(address)

- **Signature**: `isValidator(address)`
- **Visibility**: external
- **Source Range**: 21162:69:518

**Signature:**
```solidity
/// @notice Checks if an address is an approved validator
///  @param validator The address to check
///  @return True if the address is an approved validator, false otherwise
function isValidator(address validator) external view returns (bool);;
```

### isGuardian(address)

- **Signature**: `isGuardian(address)`
- **Visibility**: external
- **Source Range**: 21395:67:518

**Signature:**
```solidity
/// @notice Checks if an address has the guardian role
///  @param guardian Address to check
///  @return true if the address has the GUARDIAN_ROLE
function isGuardian(address guardian) external view returns (bool);;
```

### getValidatorConfig()

- **Signature**: `getValidatorConfig()`
- **Visibility**: external
- **Source Range**: 21803:175:518

**Signature:**
```solidity
/// @notice Returns the complete validator configuration
///  @return version The current configuration version number
///  @return validators Array of all registered validator addresses
///  @return validatorPublicKeys Array of validator public keys
///  @return quorum The number of validators required for consensus
function getValidatorConfig() external view returns (uint256 version, address[] memory validators, bytes[] memory validatorPublicKeys, uint256 quorum);;
```

### getValidators()

- **Signature**: `getValidators()`
- **Visibility**: external
- **Source Range**: 22078:66:518

**Signature:**
```solidity
/// @notice Returns all registered validators
///  @return List of validator addresses
function getValidators() external view returns (address[] memory);;
```

### getValidatorsCount()

- **Signature**: `getValidatorsCount()`
- **Visibility**: external
- **Source Range**: 22217:62:518

**Signature:**
```solidity
/// @notice Returns the number of registered validators (O(1))
function getValidatorsCount() external view returns (uint256);;
```

### getValidatorAt(uint256)

- **Signature**: `getValidatorAt(uint256)`
- **Visibility**: external
- **Source Range**: 22476:81:518

**Signature:**
```solidity
/// @notice Returns a validator address by index (0 … count-1)
///  @param index The index into the validators set
///  @return validator The validator address at the given index
function getValidatorAt(uint256 index) external view returns (address validator);;
```

### getProposedActivePPSOracle()

- **Signature**: `getProposedActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 22788:108:518

**Signature:**
```solidity
/// @notice Gets the proposed active PPS oracle and its effective time
///  @return proposedOracle The proposed oracle address
///  @return effectiveTime The timestamp when the proposed oracle will become effective
function getProposedActivePPSOracle() external view returns (address proposedOracle, uint256 effectiveTime);;
```

### getPPSOracleQuorum()

- **Signature**: `getPPSOracleQuorum()`
- **Visibility**: external
- **Source Range**: 23027:62:518

**Signature:**
```solidity
/// @notice Gets the current quorum requirement for the active PPS Oracle
///  @return The current quorum requirement
function getPPSOracleQuorum() external view returns (uint256);;
```

### getActivePPSOracle()

- **Signature**: `getActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 23184:62:518

**Signature:**
```solidity
/// @notice Gets the active PPS oracle
///  @return The active PPS oracle address
function getActivePPSOracle() external view returns (address);;
```

### isActivePPSOracle(address)

- **Signature**: `isActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 23443:72:518

**Signature:**
```solidity
/// @notice Checks if an address is the current active PPS oracle
///  @param oracle The address to check
///  @return True if the address is the active PPS oracle, false otherwise
function isActivePPSOracle(address oracle) external view returns (bool);;
```

### getFee(enum FeeType)

- **Signature**: `getFee(enum FeeType)`
- **Visibility**: external
- **Source Range**: 23690:65:518

**Signature:**
```solidity
/// @notice Gets the current fee value for a specific fee type
///  @param feeType The type of fee to get
///  @return The current fee value (in basis points)
function getFee(FeeType feeType) external view returns (uint256);;
```

### getUpkeepCostPerSingleUpdate(address)

- **Signature**: `getUpkeepCostPerSingleUpdate(address)`
- **Visibility**: external
- **Source Range**: 23819:87:518

**Signature:**
```solidity
/// @notice Gets the current upkeep cost for an entry
function getUpkeepCostPerSingleUpdate(address oracle_) external view returns (uint256);;
```

### getMinStaleness()

- **Signature**: `getMinStaleness()`
- **Visibility**: external
- **Source Range**: 24112:59:518

**Signature:**
```solidity
/// @notice Gets the proposed upkeep cost per update and its effective time
///  @notice Gets the current minimum staleness value
///  @return The current minimum staleness value in seconds
function getMinStaleness() external view returns (uint256);;
```

### getProposedMinStaleness()

- **Signature**: `getProposedMinStaleness()`
- **Visibility**: external
- **Source Range**: 24421:111:518

**Signature:**
```solidity
/// @notice Gets the proposed minimum staleness value and its effective time
///  @return proposedMinStaleness The proposed new minimum staleness value
///  @return effectiveTime The timestamp when the new value will become effective
function getProposedMinStaleness() external view returns (uint256 proposedMinStaleness, uint256 effectiveTime);;
```

### getSuperBankHookMerkleRoot(address)

- **Signature**: `getSuperBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 24761:82:518

**Signature:**
```solidity
/// @notice Returns the current Merkle root for a specific hook's allowed targets.
///  @param hook The address of the hook to get the Merkle root for.
///  @return The Merkle root for the hook's allowed targets.
function getSuperBankHookMerkleRoot(address hook) external view returns (bytes32);;
```

### getProposedSuperBankHookMerkleRoot(address)

- **Signature**: `getProposedSuperBankHookMerkleRoot(address)`
- **Visibility**: external
- **Source Range**: 25165:150:518

**Signature:**
```solidity
/// @notice Gets the proposed Merkle root and its effective time for a specific hook.
///  @param hook The address of the hook to get the proposed Merkle root for.
///  @return proposedRoot The proposed Merkle root.
///  @return effectiveTime The timestamp when the proposed root will become effective.
function getProposedSuperBankHookMerkleRoot(address hook) external view returns (bytes32 proposedRoot, uint256 effectiveTime);;
```

### isUpkeepPaymentsEnabled()

- **Signature**: `isUpkeepPaymentsEnabled()`
- **Visibility**: external
- **Source Range**: 25445:64:518

**Signature:**
```solidity
/// @notice Checks if upkeep payments are currently enabled
///  @return enabled True if upkeep payments are enabled
function isUpkeepPaymentsEnabled() external view returns (bool);;
```

### getProposedUpkeepPaymentsStatus()

- **Signature**: `getProposedUpkeepPaymentsStatus()`
- **Visibility**: external
- **Source Range**: 25713:103:518

**Signature:**
```solidity
/// @notice Gets the proposed upkeep payments status and effective time
///  @return enabled The proposed status
///  @return effectiveTime The timestamp when the change becomes effective
function getProposedUpkeepPaymentsStatus() external view returns (bool enabled, uint256 effectiveTime);;
```

### SUP_STRATEGY()

- **Signature**: `SUP_STRATEGY()`
- **Visibility**: external
- **Source Range**: 25912:56:518

**Signature:**
```solidity
/// @notice Gets the SUP strategy ID
///  @return The ID of the SUP strategy vault
function SUP_STRATEGY() external view returns (bytes32);;
```

### UP()

- **Signature**: `UP()`
- **Visibility**: external
- **Source Range**: 26044:46:518

**Signature:**
```solidity
/// @notice Gets the UP ID
///  @return The ID of the UP token
function UP() external view returns (bytes32);;
```

### UPKEEP_TOKEN()

- **Signature**: `UPKEEP_TOKEN()`
- **Visibility**: external
- **Source Range**: 26249:56:518

**Signature:**
```solidity
/// @notice Gets the UPKEEP_TOKEN ID
///  @return The ID of the UPKEEP_TOKEN (used for upkeep payments, can be UP on mainnet or WETH/USDC on L2s)
function UPKEEP_TOKEN() external view returns (bytes32);;
```

### TREASURY()

- **Signature**: `TREASURY()`
- **Visibility**: external
- **Source Range**: 26404:52:518

**Signature:**
```solidity
/// @notice Gets the Treasury ID
///  @return The ID for the Treasury in the registry
function TREASURY() external view returns (bytes32);;
```

### SUPER_ORACLE()

- **Signature**: `SUPER_ORACLE()`
- **Visibility**: external
- **Source Range**: 26561:56:518

**Signature:**
```solidity
/// @notice Gets the SuperOracle ID
///  @return The ID for the SuperOracle in the registry
function SUPER_ORACLE() external view returns (bytes32);;
```

### ECDSAPPSORACLE()

- **Signature**: `ECDSAPPSORACLE()`
- **Visibility**: external
- **Source Range**: 26732:58:518

**Signature:**
```solidity
/// @notice Gets the ECDSA PPS Oracle ID
///  @return The ID for the ECDSA PPS Oracle in the registry
function ECDSAPPSORACLE() external view returns (bytes32);;
```

### SUPER_VAULT_AGGREGATOR()

- **Signature**: `SUPER_VAULT_AGGREGATOR()`
- **Visibility**: external
- **Source Range**: 26913:66:518

**Signature:**
```solidity
/// @notice Gets the SuperVaultAggregator ID
///  @return The ID for the SuperVaultAggregator in the registry
function SUPER_VAULT_AGGREGATOR() external view returns (bytes32);;
```

### SUPER_BANK()

- **Signature**: `SUPER_BANK()`
- **Visibility**: external
- **Source Range**: 27080:54:518

**Signature:**
```solidity
/// @notice Gets the SuperBank ID
///  @return The ID for the SuperBank in the registry
function SUPER_BANK() external view returns (bytes32);;
```

### getGasInfo(address)

- **Signature**: `getGasInfo(address)`
- **Visibility**: external
- **Source Range**: 27334:69:518

**Signature:**
```solidity
/// @notice Gets the gas info for a specific SuperVault PPS Oracle
///  @param oracle_ The address of the oracle to get gas info for
///  @return The gas info for the specified oracle
function getGasInfo(address oracle_) external view returns (uint256);;
```

### cancelOracleProviderRemoval()

- **Signature**: `cancelOracleProviderRemoval()`
- **Visibility**: external
- **Source Range**: 27479:48:518

**Signature:**
```solidity
/// @notice Cancels a previously proposed oracle provider removal
function cancelOracleProviderRemoval() external;;
```

### executeOracleProviderRemoval()

- **Signature**: `executeOracleProviderRemoval()`
- **Visibility**: external
- **Source Range**: 27631:49:518

**Signature:**
```solidity
/// @notice Executes a previously proposed oracle provider removal after timelock has expired
function executeOracleProviderRemoval() external;;
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
