# Contract: SuperVaultAggregator

## Metadata

- **Name**: SuperVaultAggregator
- **Type**: Contract
- **Path**: src/SuperVault/SuperVaultAggregator.sol
- **Documentation**: @title SuperVaultAggregator
   @author Superform Labs
   @notice Registry and PPS oracle for all SuperVaults
   @dev Creates new SuperVault trios and manages PPS updates

## Implements Interfaces

- **ISuperVaultAggregator** [src/interfaces/SuperVault/ISuperVaultAggregator.sol/interface_ISuperVaultAggregator.md]

## State Variables

### VAULT_IMPLEMENTATION

```solidity
address public immutable VAULT_IMPLEMENTATION
```

### STRATEGY_IMPLEMENTATION

```solidity
address public immutable STRATEGY_IMPLEMENTATION
```

### ESCROW_IMPLEMENTATION

```solidity
address public immutable ESCROW_IMPLEMENTATION
```

### SUPER_GOVERNOR

```solidity
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### claimableUpkeep

```solidity
uint256 public claimableUpkeep
```

### _strategyData

```solidity
mapping(address => StrategyData) private _strategyData
```

### _strategyUpkeepBalance

```solidity
mapping(address => uint256) private _strategyUpkeepBalance
```

### pendingUpkeepWithdrawals

```solidity
mapping(address => UpkeepWithdrawalRequest) public pendingUpkeepWithdrawals
```

### _superVaults

```solidity
EnumerableSet.AddressSet private _superVaults
```

### _superVaultStrategies

```solidity
EnumerableSet.AddressSet private _superVaultStrategies
```

### _superVaultEscrows

```solidity
EnumerableSet.AddressSet private _superVaultEscrows
```

### BPS_PRECISION

```solidity
uint256 private constant BPS_PRECISION = 10_000
```

### MAX_PERFORMANCE_FEE

```solidity
uint256 private constant MAX_PERFORMANCE_FEE = 5100
```

### MAX_SECONDARY_MANAGERS

```solidity
uint256 public constant MAX_SECONDARY_MANAGERS = 5
```

### DEFAULT_DEVIATION_THRESHOLD

```solidity
uint256 private constant DEFAULT_DEVIATION_THRESHOLD = 5e17
```

### UPKEEP_WITHDRAWAL_TIMELOCK

```solidity
uint256 public constant UPKEEP_WITHDRAWAL_TIMELOCK = 24 hours
```

### _MANAGER_CHANGE_TIMELOCK

```solidity
uint256 private constant _MANAGER_CHANGE_TIMELOCK = 7 days
```

### _hooksRootUpdateTimelock

```solidity
uint256 private _hooksRootUpdateTimelock = 15 minutes
```

### _PARAMETER_CHANGE_TIMELOCK

```solidity
uint256 private constant _PARAMETER_CHANGE_TIMELOCK = 3 days
```

### _globalHooksRoot

```solidity
bytes32 private _globalHooksRoot
```

### _proposedGlobalHooksRoot

```solidity
bytes32 private _proposedGlobalHooksRoot
```

### _globalHooksRootEffectiveTime

```solidity
uint256 private _globalHooksRootEffectiveTime
```

### _globalHooksRootVetoed

```solidity
bool private _globalHooksRootVetoed
```

### _vaultCreationNonce

```solidity
uint256 private _vaultCreationNonce
```

## Structs

### PPSUpdateData (inherited from ISuperVaultAggregator)

```solidity
/// @notice Arguments for forwarding PPS updates to avoid stack too deep errors
///  @param strategy Address of the strategy being updated
///  @param isExempt Whether the update is exempt from paying upkeep
///  @param pps New price-per-share value
///  @param timestamp Timestamp when the value was generated
///  @param upkeepCost Amount of upkeep tokens to charge if not exempt
struct PPSUpdateData {
    address strategy;
    bool isExempt;
    uint256 pps;
    uint256 timestamp;
    uint256 upkeepCost;
}
```

### VaultCreationLocalVars (inherited from ISuperVaultAggregator)

```solidity
/// @notice Local variables for vault creation to avoid stack too deep
///  @param currentNonce Current vault creation nonce
///  @param salt Salt for deterministic proxy creation
///  @param initialPPS Initial price-per-share value
struct VaultCreationLocalVars {
    uint256 currentNonce;
    bytes32 salt;
    uint256 initialPPS;
}
```

### StrategyData (inherited from ISuperVaultAggregator)

```solidity
/// @notice Strategy configuration and state data
///  @param pps Current price-per-share value
///  @param lastUpdateTimestamp Last time PPS was updated
///  @param minUpdateInterval Minimum time interval between PPS updates
///  @param maxStaleness Maximum time allowed between PPS updates before staleness
///  @param isPaused Whether the strategy is paused
///  @param mainManager Address of the primary manager controlling the strategy
///  @param secondaryManagers Set of secondary managers that can manage the strategy
struct StrategyData {
    uint256 pps;
    uint256 lastUpdateTimestamp;
    uint256 minUpdateInterval;
    uint256 maxStaleness;
    address mainManager;
    bool ppsStale;
    bool isPaused;
    bool hooksRootVetoed;
    uint72 __gap1;
    EnumerableSet.AddressSet secondaryManagers;
    address proposedManager;
    address proposedFeeRecipient;
    uint256 managerChangeEffectiveTime;
    bytes32 managerHooksRoot;
    bytes32 proposedHooksRoot;
    uint256 hooksRootEffectiveTime;
    uint256 deviationThreshold;
    mapping(bytes32 => bool) bannedLeaves;
    uint256 proposedMinUpdateInterval;
    uint256 minUpdateIntervalEffectiveTime;
    uint256 lastUnpauseTimestamp;
}
```

### VaultCreationParams (inherited from ISuperVaultAggregator)

```solidity
/// @notice Parameters for creating a new SuperVault trio
///  @param asset Address of the underlying asset
///  @param name Name of the vault token
///  @param symbol Symbol of the vault token
///  @param mainManager Address of the vault mainManager
///  @param minUpdateInterval Minimum time interval between PPS updates
///  @param maxStaleness Maximum time allowed between PPS updates before staleness
///  @param feeConfig Fee configuration for the vault
struct VaultCreationParams {
    address asset;
    string name;
    string symbol;
    address mainManager;
    address[] secondaryManagers;
    uint256 minUpdateInterval;
    uint256 maxStaleness;
    ISuperVaultStrategy.FeeConfig feeConfig;
}
```

### HookValidationCache (inherited from ISuperVaultAggregator)

```solidity
/// @notice Struct to hold cached hook validation state variables to avoid stack too deep
///  @param globalHooksRootVetoed Cached global hooks root veto status
///  @param globalHooksRoot Cached global hooks root
///  @param strategyHooksRootVetoed Cached strategy hooks root veto status
///  @param strategyRoot Cached strategy hooks root
struct HookValidationCache {
    bool globalHooksRootVetoed;
    bytes32 globalHooksRoot;
    bool strategyHooksRootVetoed;
    bytes32 strategyRoot;
}
```

### ValidateHookArgs (inherited from ISuperVaultAggregator)

```solidity
/// @notice Arguments for validating a hook to avoid stack too deep
///  @param hookAddress Address of the hook contract
///  @param hookArgs Encoded arguments for the hook operation
///  @param globalProof Merkle proof for the global root
///  @param strategyProof Merkle proof for the strategy-specific root
struct ValidateHookArgs {
    address hookAddress;
    bytes hookArgs;
    bytes32[] globalProof;
    bytes32[] strategyProof;
}
```

### UpkeepWithdrawalRequest (inherited from ISuperVaultAggregator)

```solidity
/// @notice Two-step upkeep withdrawal request
///  @param amount Amount to withdraw (full balance at time of request)
///  @param effectiveTime When withdrawal can be executed (timestamp + 24h)
struct UpkeepWithdrawalRequest {
    uint256 amount;
    uint256 effectiveTime;
}
```

### ForwardPPSArgs (inherited from ISuperVaultAggregator)

```solidity
/// @notice Arguments for batch forwarding PPS updates
///  @param strategies Array of strategy addresses
///  @param ppss Array of price-per-share values
///  @param timestamps Array of timestamps when values were generated
///  @param updateAuthority Address of the update authority
struct ForwardPPSArgs {
    address[] strategies;
    uint256[] ppss;
    uint256[] timestamps;
    address updateAuthority;
}
```

## Errors

### ZERO_ADDRESS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when address provided is zero
error ZERO_ADDRESS();
```

### ZERO_AMOUNT (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when amount provided is zero
error ZERO_AMOUNT();
```

### INVALID_VAULT_PARAMS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when vault creation parameters are invalid (empty name or symbol)
error INVALID_VAULT_PARAMS();
```

### ZERO_ARRAY_LENGTH (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when array length is zero
error ZERO_ARRAY_LENGTH();
```

### ARRAY_LENGTH_MISMATCH (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when array length is zero
error ARRAY_LENGTH_MISMATCH();
```

### INVALID_ASSET (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when asset is invalid
error INVALID_ASSET();
```

### INSUFFICIENT_UPKEEP (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when insufficient upkeep balance for operation
error INSUFFICIENT_UPKEEP();
```

### CALLER_NOT_AUTHORIZED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when caller is not authorized
error CALLER_NOT_AUTHORIZED();
```

### UNAUTHORIZED_PPS_ORACLE (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when caller is not an approved PPS oracle
error UNAUTHORIZED_PPS_ORACLE();
```

### UNAUTHORIZED_UPDATE_AUTHORITY (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when caller is not authorized for update
error UNAUTHORIZED_UPDATE_AUTHORITY();
```

### UNKNOWN_STRATEGY (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when strategy address is not a known SuperVault strategy
error UNKNOWN_STRATEGY();
```

### STRATEGY_NOT_PAUSED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when trying to unpause a strategy that is not paused
error STRATEGY_NOT_PAUSED();
```

### STRATEGY_ALREADY_PAUSED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when trying to pause a strategy that is already paused
error STRATEGY_ALREADY_PAUSED();
```

### INDEX_OUT_OF_BOUNDS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when array index is out of bounds
error INDEX_OUT_OF_BOUNDS();
```

### MANAGER_ALREADY_EXISTS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when attempting to add a manager that already exists
error MANAGER_ALREADY_EXISTS();
```

### SECONDARY_MANAGER_CANNOT_BE_PRIMARY (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when attempting to add a manager that is the primary manager
error SECONDARY_MANAGER_CANNOT_BE_PRIMARY();
```

### NO_PENDING_GLOBAL_ROOT_CHANGE (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when there is no pending global hooks root change
error NO_PENDING_GLOBAL_ROOT_CHANGE();
```

### ROOT_UPDATE_NOT_READY (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when attempting to execute a hooks root change before timelock has elapsed
error ROOT_UPDATE_NOT_READY();
```

### HOOK_VALIDATION_FAILED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when a provided hook fails Merkle proof validation
error HOOK_VALIDATION_FAILED();
```

### MANAGER_NOT_FOUND (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when manager is not found
error MANAGER_NOT_FOUND();
```

### NO_PENDING_MANAGER_CHANGE (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when there is no pending manager change proposal
error NO_PENDING_MANAGER_CHANGE();
```

### UNAUTHORIZED_CALLER (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when caller is not authorized to update settings
error UNAUTHORIZED_CALLER();
```

### TIMELOCK_NOT_EXPIRED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when the timelock for a proposed change has not expired
error TIMELOCK_NOT_EXPIRED();
```

### INVALID_ARRAY_LENGTH (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when an array length is invalid
error INVALID_ARRAY_LENGTH();
```

### MAX_STALENESS_TOO_LOW (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when the provided maxStaleness is less than the minimum required staleness
error MAX_STALENESS_TOO_LOW();
```

### MISMATCHED_ARRAY_LENGTHS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when arrays have mismatched lengths
error MISMATCHED_ARRAY_LENGTHS();
```

### INVALID_TIMESTAMP (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when timestamp is invalid
error INVALID_TIMESTAMP(uint256 index);
```

### TOO_MANY_SECONDARY_MANAGERS (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when too many secondary managers are added
error TOO_MANY_SECONDARY_MANAGERS();
```

### UPKEEP_WITHDRAWAL_NOT_READY (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when upkeep withdrawal timelock has not passed yet
error UPKEEP_WITHDRAWAL_NOT_READY();
```

### UPKEEP_WITHDRAWAL_NOT_FOUND (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when no pending upkeep withdrawal request exists
error UPKEEP_WITHDRAWAL_NOT_FOUND();
```

### PPS_MUST_DECREASE_AFTER_SKIM (inherited from ISuperVaultAggregator)

```solidity
/// @notice PPS must decrease after skimming fees
error PPS_MUST_DECREASE_AFTER_SKIM();
```

### PPS_DEDUCTION_TOO_LARGE (inherited from ISuperVaultAggregator)

```solidity
/// @notice PPS deduction is larger than the maximum allowed fee rate
error PPS_DEDUCTION_TOO_LARGE();
```

### NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when no minUpdateInterval change proposal is pending
error NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE();
```

### MIN_UPDATE_INTERVAL_TOO_HIGH (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when minUpdateInterval >= maxStaleness
error MIN_UPDATE_INTERVAL_TOO_HIGH();
```

### STRATEGY_PAUSED (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when trying to update PPS while strategy is paused
error STRATEGY_PAUSED();
```

### PPS_STALE (inherited from ISuperVaultAggregator)

```solidity
/// @notice Thrown when trying to update PPS while PPS is stale
error PPS_STALE();
```

## Events

### VaultDeployed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a new vault trio is created
///  @param vault Address of the created SuperVault
///  @param strategy Address of the created SuperVaultStrategy
///  @param escrow Address of the created SuperVaultEscrow
///  @param asset Address of the underlying asset
///  @param name Name of the vault token
///  @param symbol Symbol of the vault token
///  @param nonce The nonce used for vault creation
event VaultDeployed(address indexed vault, address indexed strategy, address escrow, address asset, string name, string symbol, uint256 indexed nonce);
```

### PPSUpdated (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a PPS value is updated
///  @param strategy Address of the strategy
///  @param pps New price-per-share value
///  @param timestamp Timestamp of the update
event PPSUpdated(address indexed strategy, uint256 pps, uint256 timestamp);
```

### StrategyPaused (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy is paused due to missed updates
///  @param strategy Address of the paused strategy
event StrategyPaused(address indexed strategy);
```

### StrategyUnpaused (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy is unpaused
///  @param strategy Address of the unpaused strategy
event StrategyUnpaused(address indexed strategy);
```

### StrategyCheckFailed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy validation check fails but execution continues
///  @param strategy Address of the strategy that failed the check
///  @param reason String description of which check failed
event StrategyCheckFailed(address indexed strategy, string reason);
```

### UpkeepDeposited (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when upkeep tokens are deposited
///  @param strategy Address of the strategy
///  @param depositor Address of the depositor
///  @param amount Amount of upkeep tokens deposited
event UpkeepDeposited(address indexed strategy, address indexed depositor, uint256 amount);
```

### UpkeepWithdrawn (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when upkeep tokens are withdrawn
///  @param strategy Address of the strategy
///  @param withdrawer Address of the withdrawer (main manager of the strategy)
///  @param amount Amount of upkeep tokens withdrawn
event UpkeepWithdrawn(address indexed strategy, address indexed withdrawer, uint256 amount);
```

### UpkeepWithdrawalProposed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when an upkeep withdrawal is proposed (start of 24h timelock)
///  @param strategy Address of the strategy
///  @param mainManager Address of the main manager who proposed the withdrawal
///  @param amount Amount of upkeep tokens to withdraw
///  @param effectiveTime Timestamp when withdrawal can be executed
event UpkeepWithdrawalProposed(address indexed strategy, address indexed mainManager, uint256 amount, uint256 effectiveTime);
```

### UpkeepWithdrawalCancelled (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a pending upkeep withdrawal is cancelled (e.g., during governance takeover)
///  @param strategy Address of the strategy
event UpkeepWithdrawalCancelled(address indexed strategy);
```

### UpkeepSpent (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when upkeep tokens are spent for validation
///  @param strategy Address of the strategy
///  @param amount Amount of upkeep tokens spent
///  @param balance Current balance of the strategy
///  @param claimableUpkeep Amount of upkeep tokens claimable
event UpkeepSpent(address indexed strategy, uint256 amount, uint256 balance, uint256 claimableUpkeep);
```

### SecondaryManagerAdded (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a secondary manager is added to a strategy
///  @param strategy Address of the strategy
///  @param manager Address of the manager added
event SecondaryManagerAdded(address indexed strategy, address indexed manager);
```

### SecondaryManagerRemoved (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a secondary manager is removed from a strategy
///  @param strategy Address of the strategy
///  @param manager Address of the manager removed
event SecondaryManagerRemoved(address indexed strategy, address indexed manager);
```

### PrimaryManagerChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a primary manager is changed
///  @param strategy Address of the strategy
///  @param oldManager Address of the old primary manager
///  @param newManager Address of the new primary manager
///  @param feeRecipient Address of the new fee recipient
event PrimaryManagerChanged(address indexed strategy, address indexed oldManager, address indexed newManager, address feeRecipient);
```

### PrimaryManagerChangeProposed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a change to primary manager is proposed by a secondary manager
///  @param strategy Address of the strategy
///  @param proposer Address of the secondary manager who made the proposal
///  @param newManager Address of the proposed new primary manager
///  @param effectiveTime Timestamp when the proposal can be executed
event PrimaryManagerChangeProposed(address indexed strategy, address indexed proposer, address indexed newManager, address feeRecipient, uint256 effectiveTime);
```

### PrimaryManagerChangeCancelled (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a primary manager change proposal is cancelled
///  @param strategy Address of the strategy
///  @param cancelledManager Address of the manager that was proposed
event PrimaryManagerChangeCancelled(address indexed strategy, address indexed cancelledManager);
```

### HighWaterMarkReset (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the High Water Mark for a strategy is reset to PPS
///  @param strategy Address of the strategy
///  @param newHWM The new High Water Mark (PPS)
event HighWaterMarkReset(address indexed strategy, uint256 indexed newHWM);
```

### StaleUpdate (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a PPS update is stale (Validators could get slashed for innactivity)
///  @param strategy Address of the strategy
///  @param updateAuthority Address of the update authority
///  @param timestamp Timestamp of the stale update
event StaleUpdate(address indexed strategy, address indexed updateAuthority, uint256 timestamp);
```

### GlobalHooksRootUpdateProposed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the global hooks Merkle root is being updated
///  @param root New root value
///  @param effectiveTime Timestamp when the root becomes effective
event GlobalHooksRootUpdateProposed(bytes32 indexed root, uint256 effectiveTime);
```

### GlobalHooksRootUpdated (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the global hooks Merkle root is updated
///  @param oldRoot Previous root value
///  @param newRoot New root value
event GlobalHooksRootUpdated(bytes32 indexed oldRoot, bytes32 newRoot);
```

### StrategyHooksRootUpdated (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy-specific hooks Merkle root is updated
///  @param strategy Address of the strategy
///  @param oldRoot Previous root value (may be zero)
///  @param newRoot New root value
event StrategyHooksRootUpdated(address indexed strategy, bytes32 oldRoot, bytes32 newRoot);
```

### StrategyHooksRootUpdateProposed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy-specific hooks Merkle root is proposed
///  @param strategy Address of the strategy
///  @param proposer Address of the account proposing the new root
///  @param root New root value
///  @param effectiveTime Timestamp when the root becomes effective
event StrategyHooksRootUpdateProposed(address indexed strategy, address indexed proposer, bytes32 root, uint256 effectiveTime);
```

### GlobalHooksRootVetoStatusChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a proposed global hooks root update is vetoed by SuperGovernor
///  @param vetoed Whether the root is being vetoed (true) or unvetoed (false)
///  @param root The root value affected
event GlobalHooksRootVetoStatusChanged(bool vetoed, bytes32 indexed root);
```

### StrategyHooksRootVetoStatusChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy's hooks Merkle root veto status changes
///  @param strategy Address of the strategy
///  @param vetoed Whether the root is being vetoed (true) or unvetoed (false)
///  @param root The root value affected
event StrategyHooksRootVetoStatusChanged(address indexed strategy, bool vetoed, bytes32 indexed root);
```

### DeviationThresholdUpdated (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy's deviation threshold is updated
///  @param strategy Address of the strategy
///  @param deviationThreshold New deviation threshold (abs diff/current)
event DeviationThresholdUpdated(address indexed strategy, uint256 deviationThreshold);
```

### HooksRootUpdateTimelockChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the hooks root update timelock is changed
///  @param newTimelock New timelock duration in seconds
event HooksRootUpdateTimelockChanged(uint256 newTimelock);
```

### GlobalLeavesStatusChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when global leaves status is changed for a strategy
///  @param strategy Address of the strategy
///  @param leaves Array of leaf hashes that had their status changed
///  @param statuses Array of new banned statuses (true = banned, false = allowed)
event GlobalLeavesStatusChanged(address indexed strategy, bytes32[] leaves, bool[] statuses);
```

### UpkeepClaimed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when upkeep is claimed
///  @param superBank Address of the superBank
///  @param amount Amount of upkeep claimed
event UpkeepClaimed(address indexed superBank, uint256 amount);
```

### UpdateTooFrequent (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when PPS update is too frequent (before minUpdateInterval)
event UpdateTooFrequent();
```

### TimestampNotMonotonic (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when PPS update timestamp is not monotonically increasing
event TimestampNotMonotonic();
```

### StaleSignatureAfterUnpause (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when PPS update is rejected due to stale signature after unpause
event StaleSignatureAfterUnpause(address indexed strategy, uint256 signatureTimestamp, uint256 lastUnpauseTimestamp);
```

### InsufficientUpkeep (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy does not have enough upkeep balance
event InsufficientUpkeep(address indexed strategy, address indexed strategyAddr, uint256 balance, uint256 cost);
```

### ProvidedTimestampExceedsBlockTimestamp (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the provided timestamp is too large
event ProvidedTimestampExceedsBlockTimestamp(address indexed strategy, uint256 argsTimestamp, uint256 blockTimestamp);
```

### UnknownStrategy (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy is unknown
event UnknownStrategy(address indexed strategy);
```

### OldPrimaryManagerRemoved (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when the old primary manager is removed from the strategy
///  @dev This can happen because of reaching the max number of secondary managers
event OldPrimaryManagerRemoved(address indexed strategy, address indexed oldManager);
```

### StrategyPPSStale (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy's PPS is stale
event StrategyPPSStale(address indexed strategy);
```

### StrategyPPSStaleReset (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a strategy's PPS is reset
event StrategyPPSStaleReset(address indexed strategy);
```

### PPSUpdatedAfterSkim (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when PPS is updated after performance fee skimming
///  @param strategy Address of the strategy
///  @param oldPPS Previous price-per-share value
///  @param newPPS New price-per-share value after fee deduction
///  @param feeAmount Amount of fee skimmed that caused the PPS update
///  @param timestamp Timestamp of the update
event PPSUpdatedAfterSkim(address indexed strategy, uint256 oldPPS, uint256 newPPS, uint256 feeAmount, uint256 timestamp);
```

### MinUpdateIntervalChangeProposed (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a change to minUpdateInterval is proposed
///  @param strategy Address of the strategy
///  @param proposer Address of the manager who made the proposal
///  @param newMinUpdateInterval The proposed new minimum update interval
///  @param effectiveTime Timestamp when the proposal can be executed
event MinUpdateIntervalChangeProposed(address indexed strategy, address indexed proposer, uint256 newMinUpdateInterval, uint256 effectiveTime);
```

### MinUpdateIntervalChanged (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a minUpdateInterval change is executed
///  @param strategy Address of the strategy
///  @param oldMinUpdateInterval Previous minimum update interval
///  @param newMinUpdateInterval New minimum update interval
event MinUpdateIntervalChanged(address indexed strategy, uint256 oldMinUpdateInterval, uint256 newMinUpdateInterval);
```

### MinUpdateIntervalChangeRejected (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a minUpdateInterval change proposal is rejected due to validation failure
///  @param strategy Address of the strategy
///  @param proposedInterval The proposed interval that was rejected
///  @param currentMaxStaleness The current maxStaleness value that caused rejection
event MinUpdateIntervalChangeRejected(address indexed strategy, uint256 proposedInterval, uint256 currentMaxStaleness);
```

### MinUpdateIntervalChangeCancelled (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a minUpdateInterval change proposal is cancelled
///  @param strategy Address of the strategy
///  @param cancelledInterval The proposed interval that was cancelled
event MinUpdateIntervalChangeCancelled(address indexed strategy, uint256 cancelledInterval);
```

### PPSUpdateRejectedStrategyPaused (inherited from ISuperVaultAggregator)

```solidity
/// @notice Emitted when a PPS update is rejected because strategy is paused
///  @param strategy Address of the paused strategy
event PPSUpdateRejectedStrategyPaused(address indexed strategy);
```

## Public/External Functions

### constructor(address,address,address,address)

- **Signature**: `constructor(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 5167:554:511
- **Details**: [function_constructor_address_address_address_address.md](./function_constructor_address_address_address_address.md)

**Signature:**
```solidity
/// @notice Initializes the SuperVaultAggregator
///  @param superGovernor_ Address of the SuperGovernor contract
///  @param vaultImpl_ Address of the pre-deployed SuperVault implementation
///  @param strategyImpl_ Address of the pre-deployed SuperVaultStrategy implementation
///  @param escrowImpl_ Address of the pre-deployed SuperVaultEscrow implementation
constructor(address superGovernor_, address vaultImpl_, address strategyImpl_, address escrowImpl_);
```

### createVault(struct ISuperVaultAggregator.VaultCreationParams)

- **Signature**: `createVault(struct ISuperVaultAggregator.VaultCreationParams)`
- **Visibility**: external
- **Source Range**: 5950:4141:511
- **Details**: [function_createVault_struct_ISuperVaultAggregator_VaultCreationParams.md](./function_createVault_struct_ISuperVaultAggregator_VaultCreationParams.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function createVault(VaultCreationParams calldata params) external returns (address superVault, address strategy, address escrow);
```

### forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)

- **Signature**: `forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)`
- **Visibility**: external
- **Source Range**: 10324:3045:511
- **Details**: [function_forwardPPS_struct_ISuperVaultAggregator_ForwardPPSArgs.md](./function_forwardPPS_struct_ISuperVaultAggregator_ForwardPPSArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function forwardPPS(ForwardPPSArgs calldata args) external onlyPPSOracle();
```

### updatePPSAfterSkim(uint256,uint256)

- **Signature**: `updatePPSAfterSkim(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 13417:2023:511
- **Details**: [function_updatePPSAfterSkim_uint256_uint256.md](./function_updatePPSAfterSkim_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function updatePPSAfterSkim(uint256 newPPS, uint256 feeAmount) external validStrategy(msg.sender);
```

### depositUpkeep(address,uint256)

- **Signature**: `depositUpkeep(address,uint256)`
- **Visibility**: external
- **Source Range**: 15668:606:511
- **Details**: [function_depositUpkeep_address_uint256.md](./function_depositUpkeep_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function depositUpkeep(address strategy, uint256 amount) external validStrategy(strategy);
```

### claimUpkeep(uint256)

- **Signature**: `claimUpkeep(uint256)`
- **Visibility**: external
- **Source Range**: 16322:666:511
- **Details**: [function_claimUpkeep_uint256.md](./function_claimUpkeep_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function claimUpkeep(uint256 amount) external;
```

### proposeWithdrawUpkeep(address)

- **Signature**: `proposeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 17036:849:511
- **Details**: [function_proposeWithdrawUpkeep_address.md](./function_proposeWithdrawUpkeep_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeWithdrawUpkeep(address strategy) external validStrategy(strategy);
```

### executeWithdrawUpkeep(address)

- **Signature**: `executeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 17933:1415:511
- **Details**: [function_executeWithdrawUpkeep_address.md](./function_executeWithdrawUpkeep_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function executeWithdrawUpkeep(address strategy) external validStrategy(strategy);
```

### pauseStrategy(address)

- **Signature**: `pauseStrategy(address)`
- **Visibility**: external
- **Source Range**: 19710:571:511
- **Details**: [function_pauseStrategy_address.md](./function_pauseStrategy_address.md)

**Signature:**
```solidity
/// @notice Manually pauses a strategy
///  @param strategy Address of the strategy to pause
///  @dev Only the main or secondary manager of the strategy can pause it
function pauseStrategy(address strategy) external validStrategy(strategy);
```

### unpauseStrategy(address)

- **Signature**: `unpauseStrategy(address)`
- **Visibility**: external
- **Source Range**: 20458:679:511
- **Details**: [function_unpauseStrategy_address.md](./function_unpauseStrategy_address.md)

**Signature:**
```solidity
/// @notice Manually unpauses a strategy
///  @param strategy Address of the strategy to unpause
///  @dev unpausing marks PPS stale until a fresh oracle update
function unpauseStrategy(address strategy) external validStrategy(strategy);
```

### addSecondaryManager(address,address)

- **Signature**: `addSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 21375:960:511
- **Details**: [function_addSecondaryManager_address_address.md](./function_addSecondaryManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function addSecondaryManager(address strategy, address manager) external validStrategy(strategy);
```

### removeSecondaryManager(address,address)

- **Signature**: `removeSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 22383:485:511
- **Details**: [function_removeSecondaryManager_address_address.md](./function_removeSecondaryManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function removeSecondaryManager(address strategy, address manager) external validStrategy(strategy);
```

### updateDeviationThreshold(address,uint256)

- **Signature**: `updateDeviationThreshold(address,uint256)`
- **Visibility**: external
- **Source Range**: 22916:531:511
- **Details**: [function_updateDeviationThreshold_address_uint256.md](./function_updateDeviationThreshold_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function updateDeviationThreshold(address strategy, uint256 deviationThreshold_) external validStrategy(strategy);
```

### changeGlobalLeavesStatus(bytes32[],bool[],address)

- **Signature**: `changeGlobalLeavesStatus(bytes32[],bool[],address)`
- **Visibility**: external
- **Source Range**: 23495:836:511
- **Details**: [function_changeGlobalLeavesStatus_bytes32[]_bool[]_address.md](./function_changeGlobalLeavesStatus_bytes32[]_bool[]_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function changeGlobalLeavesStatus(bytes32[] memory leaves, bool[] memory statuses, address strategy) external validStrategy(strategy);
```

### changePrimaryManager(address,address,address)

- **Signature**: `changePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 24933:2647:511
- **Details**: [function_changePrimaryManager_address_address_address.md](./function_changePrimaryManager_address_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
///  @dev SECURITY: This is the emergency governance override function
///  @dev Clears ALL pending proposals and secondary managers to prevent malicious manager attacks:
///       - Pending manager change proposals
///       - Pending hooks root proposals
///       - Pending minUpdateInterval proposals
///       - ALL secondary managers (they may be controlled by malicious manager)
///  @dev This ensures clean slate for new manager without inherited vulnerabilities
///  @dev This function is only callable by SUPER_GOVERNOR
function changePrimaryManager(address strategy, address newManager, address feeRecipient) external validStrategy(strategy);
```

### proposeChangePrimaryManager(address,address,address)

- **Signature**: `proposeChangePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 27628:1189:511
- **Details**: [function_proposeChangePrimaryManager_address_address_address.md](./function_proposeChangePrimaryManager_address_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeChangePrimaryManager(address strategy, address newManager, address feeRecipient) external validStrategy(strategy);
```

### cancelChangePrimaryManager(address)

- **Signature**: `cancelChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 28865:836:511
- **Details**: [function_cancelChangePrimaryManager_address.md](./function_cancelChangePrimaryManager_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function cancelChangePrimaryManager(address strategy) external validStrategy(strategy);
```

### executeChangePrimaryManager(address)

- **Signature**: `executeChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 29749:1973:511
- **Details**: [function_executeChangePrimaryManager_address.md](./function_executeChangePrimaryManager_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function executeChangePrimaryManager(address strategy) external validStrategy(strategy);
```

### resetHighWaterMark(address)

- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 32394:484:511
- **Details**: [function_resetHighWaterMark_address.md](./function_resetHighWaterMark_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
///  @dev SECURITY: This function is intended to be used by governance to onboard a new manager without penalizing
///  them for the previous manager's performance.
///  @dev If a manager is replaced while the strategy is below its
///  previous HWM, the new manager would otherwise inherit a "loss" state and be unable to earn performance fees
///  until the fee config are updated after the week timelock.
///  @dev Calling this function resets the HWM to the current PPS, allowing a newly appointed manager to start from a
///  neutral baseline. @dev This function is only callable by SUPER_GOVERNOR
function resetHighWaterMark(address strategy) external validStrategy(strategy);
```

### setHooksRootUpdateTimelock(uint256)

- **Signature**: `setHooksRootUpdateTimelock(uint256)`
- **Visibility**: external
- **Source Range**: 33114:382:511
- **Details**: [function_setHooksRootUpdateTimelock_uint256.md](./function_setHooksRootUpdateTimelock_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function setHooksRootUpdateTimelock(uint256 newTimelock) external;
```

### proposeGlobalHooksRoot(bytes32)

- **Signature**: `proposeGlobalHooksRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 33544:527:511
- **Details**: [function_proposeGlobalHooksRoot_bytes32.md](./function_proposeGlobalHooksRoot_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeGlobalHooksRoot(bytes32 newRoot) external;
```

### executeGlobalHooksRootUpdate()

- **Signature**: `executeGlobalHooksRootUpdate()`
- **Visibility**: external
- **Source Range**: 34119:706:511
- **Details**: [function_executeGlobalHooksRootUpdate.md](./function_executeGlobalHooksRootUpdate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function executeGlobalHooksRootUpdate() external;
```

### setGlobalHooksRootVetoStatus(bool)

- **Signature**: `setGlobalHooksRootVetoStatus(bool)`
- **Visibility**: external
- **Source Range**: 34873:504:511
- **Details**: [function_setGlobalHooksRootVetoStatus_bool.md](./function_setGlobalHooksRootVetoStatus_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function setGlobalHooksRootVetoStatus(bool vetoed) external;
```

### proposeStrategyHooksRoot(address,bytes32)

- **Signature**: `proposeStrategyHooksRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 35425:656:511
- **Details**: [function_proposeStrategyHooksRoot_address_bytes32.md](./function_proposeStrategyHooksRoot_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeStrategyHooksRoot(address strategy, bytes32 newRoot) external validStrategy(strategy);
```

### executeStrategyHooksRootUpdate(address)

- **Signature**: `executeStrategyHooksRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 36129:941:511
- **Details**: [function_executeStrategyHooksRootUpdate_address.md](./function_executeStrategyHooksRootUpdate_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function executeStrategyHooksRootUpdate(address strategy) external validStrategy(strategy);
```

### setStrategyHooksRootVetoStatus(address,bool)

- **Signature**: `setStrategyHooksRootVetoStatus(address,bool)`
- **Visibility**: external
- **Source Range**: 37118:618:511
- **Details**: [function_setStrategyHooksRootVetoStatus_address_bool.md](./function_setStrategyHooksRootVetoStatus_address_bool.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function setStrategyHooksRootVetoStatus(address strategy, bool vetoed) external validStrategy(strategy);
```

### proposeMinUpdateIntervalChange(address,uint256)

- **Signature**: `proposeMinUpdateIntervalChange(address,uint256)`
- **Visibility**: external
- **Source Range**: 37971:1023:511
- **Details**: [function_proposeMinUpdateIntervalChange_address_uint256.md](./function_proposeMinUpdateIntervalChange_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function proposeMinUpdateIntervalChange(address strategy, uint256 newMinUpdateInterval) external validStrategy(strategy);
```

### executeMinUpdateIntervalChange(address)

- **Signature**: `executeMinUpdateIntervalChange(address)`
- **Visibility**: external
- **Source Range**: 39042:989:511
- **Details**: [function_executeMinUpdateIntervalChange_address.md](./function_executeMinUpdateIntervalChange_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function executeMinUpdateIntervalChange(address strategy) external validStrategy(strategy);
```

### cancelMinUpdateIntervalChange(address)

- **Signature**: `cancelMinUpdateIntervalChange(address)`
- **Visibility**: external
- **Source Range**: 40079:789:511
- **Details**: [function_cancelMinUpdateIntervalChange_address.md](./function_cancelMinUpdateIntervalChange_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function cancelMinUpdateIntervalChange(address strategy) external validStrategy(strategy);
```

### getProposedMinUpdateInterval(address)

- **Signature**: `getProposedMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 40916:309:511
- **Details**: [function_getProposedMinUpdateInterval_address.md](./function_getProposedMinUpdateInterval_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedMinUpdateInterval(address strategy) external view returns (uint256 proposedInterval, uint256 effectiveTime);
```

### isGlobalHooksRootVetoed()

- **Signature**: `isGlobalHooksRootVetoed()`
- **Visibility**: external
- **Source Range**: 41273:117:511
- **Details**: [function_isGlobalHooksRootVetoed.md](./function_isGlobalHooksRootVetoed.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isGlobalHooksRootVetoed() external view returns (bool vetoed);
```

### isStrategyHooksRootVetoed(address)

- **Signature**: `isStrategyHooksRootVetoed(address)`
- **Visibility**: external
- **Source Range**: 41438:152:511
- **Details**: [function_isStrategyHooksRootVetoed_address.md](./function_isStrategyHooksRootVetoed_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isStrategyHooksRootVetoed(address strategy) external view returns (bool vetoed);
```

### getSuperVaultsCount()

- **Signature**: `getSuperVaultsCount()`
- **Visibility**: external
- **Source Range**: 41821:108:511
- **Details**: [function_getSuperVaultsCount.md](./function_getSuperVaultsCount.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getSuperVaultsCount() external view returns (uint256);
```

### getSuperVaultStrategiesCount()

- **Signature**: `getSuperVaultStrategiesCount()`
- **Visibility**: external
- **Source Range**: 41977:126:511
- **Details**: [function_getSuperVaultStrategiesCount.md](./function_getSuperVaultStrategiesCount.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getSuperVaultStrategiesCount() external view returns (uint256);
```

### getSuperVaultEscrowsCount()

- **Signature**: `getSuperVaultEscrowsCount()`
- **Visibility**: external
- **Source Range**: 42151:120:511
- **Details**: [function_getSuperVaultEscrowsCount.md](./function_getSuperVaultEscrowsCount.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getSuperVaultEscrowsCount() external view returns (uint256);
```

### getCurrentNonce()

- **Signature**: `getCurrentNonce()`
- **Visibility**: external
- **Source Range**: 42319:102:511
- **Details**: [function_getCurrentNonce.md](./function_getCurrentNonce.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getCurrentNonce() external view returns (uint256);
```

### getHooksRootUpdateTimelock()

- **Signature**: `getHooksRootUpdateTimelock()`
- **Visibility**: external
- **Source Range**: 42469:118:511
- **Details**: [function_getHooksRootUpdateTimelock.md](./function_getHooksRootUpdateTimelock.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getHooksRootUpdateTimelock() external view returns (uint256);
```

### getPPS(address)

- **Signature**: `getPPS(address)`
- **Visibility**: external
- **Source Range**: 42635:145:511
- **Details**: [function_getPPS_address.md](./function_getPPS_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getPPS(address strategy) external view validStrategy(strategy) returns (uint256 pps);
```

### getLastUpdateTimestamp(address)

- **Signature**: `getLastUpdateTimestamp(address)`
- **Visibility**: external
- **Source Range**: 42828:159:511
- **Details**: [function_getLastUpdateTimestamp_address.md](./function_getLastUpdateTimestamp_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getLastUpdateTimestamp(address strategy) external view returns (uint256 timestamp);
```

### getMinUpdateInterval(address)

- **Signature**: `getMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 43035:154:511
- **Details**: [function_getMinUpdateInterval_address.md](./function_getMinUpdateInterval_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getMinUpdateInterval(address strategy) external view returns (uint256 interval);
```

### getMaxStaleness(address)

- **Signature**: `getMaxStaleness(address)`
- **Visibility**: external
- **Source Range**: 43237:145:511
- **Details**: [function_getMaxStaleness_address.md](./function_getMaxStaleness_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getMaxStaleness(address strategy) external view returns (uint256 staleness);
```

### getDeviationThreshold(address)

- **Signature**: `getDeviationThreshold(address)`
- **Visibility**: external
- **Source Range**: 43430:226:511
- **Details**: [function_getDeviationThreshold_address.md](./function_getDeviationThreshold_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getDeviationThreshold(address strategy) external view validStrategy(strategy) returns (uint256 deviationThreshold);
```

### isStrategyPaused(address)

- **Signature**: `isStrategyPaused(address)`
- **Visibility**: external
- **Source Range**: 43704:138:511
- **Details**: [function_isStrategyPaused_address.md](./function_isStrategyPaused_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isStrategyPaused(address strategy) external view returns (bool isPaused);
```

### isPPSStale(address)

- **Signature**: `isPPSStale(address)`
- **Visibility**: external
- **Source Range**: 43890:131:511
- **Details**: [function_isPPSStale_address.md](./function_isPPSStale_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isPPSStale(address strategy) external view returns (bool isStale);
```

### getLastUnpauseTimestamp(address)

- **Signature**: `getLastUnpauseTimestamp(address)`
- **Visibility**: external
- **Source Range**: 44069:161:511
- **Details**: [function_getLastUnpauseTimestamp_address.md](./function_getLastUnpauseTimestamp_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getLastUnpauseTimestamp(address strategy) external view returns (uint256 timestamp);
```

### getUpkeepBalance(address)

- **Signature**: `getUpkeepBalance(address)`
- **Visibility**: external
- **Source Range**: 44278:140:511
- **Details**: [function_getUpkeepBalance_address.md](./function_getUpkeepBalance_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getUpkeepBalance(address strategy) external view returns (uint256 balance);
```

### getMainManager(address)

- **Signature**: `getMainManager(address)`
- **Visibility**: external
- **Source Range**: 44466:141:511
- **Details**: [function_getMainManager_address.md](./function_getMainManager_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getMainManager(address strategy) external view returns (address manager);
```

### getPendingManagerChange(address)

- **Signature**: `getPendingManagerChange(address)`
- **Visibility**: external
- **Source Range**: 44655:267:511
- **Details**: [function_getPendingManagerChange_address.md](./function_getPendingManagerChange_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getPendingManagerChange(address strategy) external view returns (address proposedManager, uint256 effectiveTime);
```

### isMainManager(address,address)

- **Signature**: `isMainManager(address,address)`
- **Visibility**: public
- **Source Range**: 44970:155:511
- **Details**: [function_isMainManager_address_address.md](./function_isMainManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isMainManager(address manager, address strategy) public view returns (bool);
```

### getSecondaryManagers(address)

- **Signature**: `getSecondaryManagers(address)`
- **Visibility**: external
- **Source Range**: 45173:163:511
- **Details**: [function_getSecondaryManagers_address.md](./function_getSecondaryManagers_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getSecondaryManagers(address strategy) external view returns (address[] memory);
```

### isSecondaryManager(address,address)

- **Signature**: `isSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 45384:175:511
- **Details**: [function_isSecondaryManager_address_address.md](./function_isSecondaryManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isSecondaryManager(address manager, address strategy) external view returns (bool);
```

### isAnyManager(address,address)

- **Signature**: `isAnyManager(address,address)`
- **Visibility**: public
- **Source Range**: 45607:301:511
- **Details**: [function_isAnyManager_address_address.md](./function_isAnyManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function isAnyManager(address manager, address strategy) public view returns (bool);
```

### getAllSuperVaults()

- **Signature**: `getAllSuperVaults()`
- **Visibility**: external
- **Source Range**: 45956:115:511
- **Details**: [function_getAllSuperVaults.md](./function_getAllSuperVaults.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getAllSuperVaults() external view returns (address[] memory);
```

### superVaults(uint256)

- **Signature**: `superVaults(uint256)`
- **Visibility**: external
- **Source Range**: 46119:188:511
- **Details**: [function_superVaults_uint256.md](./function_superVaults_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function superVaults(uint256 index) external view returns (address);
```

### getAllSuperVaultStrategies()

- **Signature**: `getAllSuperVaultStrategies()`
- **Visibility**: external
- **Source Range**: 46355:133:511
- **Details**: [function_getAllSuperVaultStrategies.md](./function_getAllSuperVaultStrategies.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getAllSuperVaultStrategies() external view returns (address[] memory);
```

### superVaultStrategies(uint256)

- **Signature**: `superVaultStrategies(uint256)`
- **Visibility**: external
- **Source Range**: 46536:215:511
- **Details**: [function_superVaultStrategies_uint256.md](./function_superVaultStrategies_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function superVaultStrategies(uint256 index) external view returns (address);
```

### getAllSuperVaultEscrows()

- **Signature**: `getAllSuperVaultEscrows()`
- **Visibility**: external
- **Source Range**: 46799:127:511
- **Details**: [function_getAllSuperVaultEscrows.md](./function_getAllSuperVaultEscrows.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getAllSuperVaultEscrows() external view returns (address[] memory);
```

### superVaultEscrows(uint256)

- **Signature**: `superVaultEscrows(uint256)`
- **Visibility**: external
- **Source Range**: 46974:206:511
- **Details**: [function_superVaultEscrows_uint256.md](./function_superVaultEscrows_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function superVaultEscrows(uint256 index) external view returns (address);
```

### validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)

- **Signature**: `validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)`
- **Visibility**: external
- **Source Range**: 47228:1053:511
- **Details**: [function_validateHook_address_struct_ISuperVaultAggregator_ValidateHookArgs.md](./function_validateHook_address_struct_ISuperVaultAggregator_ValidateHookArgs.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function validateHook(address strategy, ValidateHookArgs calldata args) external view returns (bool isValid);
```

### validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])

- **Signature**: `validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])`
- **Visibility**: external
- **Source Range**: 48329:1609:511
- **Details**: [function_validateHooks_address_struct_ISuperVaultAggregator_ValidateHookArgs[].md](./function_validateHooks_address_struct_ISuperVaultAggregator_ValidateHookArgs[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function validateHooks(address strategy, ValidateHookArgs[] calldata argsArray) external view returns (bool[] memory validHooks);
```

### getGlobalHooksRoot()

- **Signature**: `getGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 49986:107:511
- **Details**: [function_getGlobalHooksRoot.md](./function_getGlobalHooksRoot.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getGlobalHooksRoot() external view returns (bytes32 root);
```

### getProposedGlobalHooksRoot()

- **Signature**: `getProposedGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 50141:179:511
- **Details**: [function_getProposedGlobalHooksRoot.md](./function_getProposedGlobalHooksRoot.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedGlobalHooksRoot() external view returns (bytes32 root, uint256 effectiveTime);
```

### isGlobalHooksRootActive()

- **Signature**: `isGlobalHooksRootActive()`
- **Visibility**: external
- **Source Range**: 50478:170:511
- **Details**: [function_isGlobalHooksRootActive.md](./function_isGlobalHooksRootActive.md)

**Signature:**
```solidity
/// @notice Checks if the global hooks root is active (timelock period has passed)
///  @return isActive True if the global hooks root is active
function isGlobalHooksRootActive() external view returns (bool);
```

### getStrategyHooksRoot(address)

- **Signature**: `getStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 50696:149:511
- **Details**: [function_getStrategyHooksRoot_address.md](./function_getStrategyHooksRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getStrategyHooksRoot(address strategy) external view returns (bytes32 root);
```

### getProposedStrategyHooksRoot(address)

- **Signature**: `getProposedStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 50893:259:511
- **Details**: [function_getProposedStrategyHooksRoot_address.md](./function_getProposedStrategyHooksRoot_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperVaultAggregator
function getProposedStrategyHooksRoot(address strategy) external view returns (bytes32 root, uint256 effectiveTime);
```
