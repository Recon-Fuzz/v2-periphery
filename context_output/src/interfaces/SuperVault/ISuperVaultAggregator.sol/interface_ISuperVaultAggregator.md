# Interface: ISuperVaultAggregator

## Metadata

- **Name**: ISuperVaultAggregator
- **Type**: Interface
- **Path**: src/interfaces/SuperVault/ISuperVaultAggregator.sol
- **Documentation**: @title ISuperVaultAggregator
   @author Superform Labs
   @notice Interface for the SuperVaultAggregator contract
   @dev Registry and PPS oracle for all SuperVaults

## Structs

### PPSUpdateData

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

### VaultCreationLocalVars

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

### StrategyData

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

### VaultCreationParams

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

### HookValidationCache

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

### ValidateHookArgs

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

### UpkeepWithdrawalRequest

```solidity
/// @notice Two-step upkeep withdrawal request
///  @param amount Amount to withdraw (full balance at time of request)
///  @param effectiveTime When withdrawal can be executed (timestamp + 24h)
struct UpkeepWithdrawalRequest {
    uint256 amount;
    uint256 effectiveTime;
}
```

### ForwardPPSArgs

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

### ZERO_ADDRESS

```solidity
/// @notice Thrown when address provided is zero
error ZERO_ADDRESS();
```

### ZERO_AMOUNT

```solidity
/// @notice Thrown when amount provided is zero
error ZERO_AMOUNT();
```

### INVALID_VAULT_PARAMS

```solidity
/// @notice Thrown when vault creation parameters are invalid (empty name or symbol)
error INVALID_VAULT_PARAMS();
```

### ZERO_ARRAY_LENGTH

```solidity
/// @notice Thrown when array length is zero
error ZERO_ARRAY_LENGTH();
```

### ARRAY_LENGTH_MISMATCH

```solidity
/// @notice Thrown when array length is zero
error ARRAY_LENGTH_MISMATCH();
```

### INVALID_ASSET

```solidity
/// @notice Thrown when asset is invalid
error INVALID_ASSET();
```

### INSUFFICIENT_UPKEEP

```solidity
/// @notice Thrown when insufficient upkeep balance for operation
error INSUFFICIENT_UPKEEP();
```

### CALLER_NOT_AUTHORIZED

```solidity
/// @notice Thrown when caller is not authorized
error CALLER_NOT_AUTHORIZED();
```

### UNAUTHORIZED_PPS_ORACLE

```solidity
/// @notice Thrown when caller is not an approved PPS oracle
error UNAUTHORIZED_PPS_ORACLE();
```

### UNAUTHORIZED_UPDATE_AUTHORITY

```solidity
/// @notice Thrown when caller is not authorized for update
error UNAUTHORIZED_UPDATE_AUTHORITY();
```

### UNKNOWN_STRATEGY

```solidity
/// @notice Thrown when strategy address is not a known SuperVault strategy
error UNKNOWN_STRATEGY();
```

### STRATEGY_NOT_PAUSED

```solidity
/// @notice Thrown when trying to unpause a strategy that is not paused
error STRATEGY_NOT_PAUSED();
```

### STRATEGY_ALREADY_PAUSED

```solidity
/// @notice Thrown when trying to pause a strategy that is already paused
error STRATEGY_ALREADY_PAUSED();
```

### INDEX_OUT_OF_BOUNDS

```solidity
/// @notice Thrown when array index is out of bounds
error INDEX_OUT_OF_BOUNDS();
```

### MANAGER_ALREADY_EXISTS

```solidity
/// @notice Thrown when attempting to add a manager that already exists
error MANAGER_ALREADY_EXISTS();
```

### SECONDARY_MANAGER_CANNOT_BE_PRIMARY

```solidity
/// @notice Thrown when attempting to add a manager that is the primary manager
error SECONDARY_MANAGER_CANNOT_BE_PRIMARY();
```

### NO_PENDING_GLOBAL_ROOT_CHANGE

```solidity
/// @notice Thrown when there is no pending global hooks root change
error NO_PENDING_GLOBAL_ROOT_CHANGE();
```

### ROOT_UPDATE_NOT_READY

```solidity
/// @notice Thrown when attempting to execute a hooks root change before timelock has elapsed
error ROOT_UPDATE_NOT_READY();
```

### HOOK_VALIDATION_FAILED

```solidity
/// @notice Thrown when a provided hook fails Merkle proof validation
error HOOK_VALIDATION_FAILED();
```

### MANAGER_NOT_FOUND

```solidity
/// @notice Thrown when manager is not found
error MANAGER_NOT_FOUND();
```

### NO_PENDING_MANAGER_CHANGE

```solidity
/// @notice Thrown when there is no pending manager change proposal
error NO_PENDING_MANAGER_CHANGE();
```

### UNAUTHORIZED_CALLER

```solidity
/// @notice Thrown when caller is not authorized to update settings
error UNAUTHORIZED_CALLER();
```

### TIMELOCK_NOT_EXPIRED

```solidity
/// @notice Thrown when the timelock for a proposed change has not expired
error TIMELOCK_NOT_EXPIRED();
```

### INVALID_ARRAY_LENGTH

```solidity
/// @notice Thrown when an array length is invalid
error INVALID_ARRAY_LENGTH();
```

### MAX_STALENESS_TOO_LOW

```solidity
/// @notice Thrown when the provided maxStaleness is less than the minimum required staleness
error MAX_STALENESS_TOO_LOW();
```

### MISMATCHED_ARRAY_LENGTHS

```solidity
/// @notice Thrown when arrays have mismatched lengths
error MISMATCHED_ARRAY_LENGTHS();
```

### INVALID_TIMESTAMP

```solidity
/// @notice Thrown when timestamp is invalid
error INVALID_TIMESTAMP(uint256 index);
```

### TOO_MANY_SECONDARY_MANAGERS

```solidity
/// @notice Thrown when too many secondary managers are added
error TOO_MANY_SECONDARY_MANAGERS();
```

### UPKEEP_WITHDRAWAL_NOT_READY

```solidity
/// @notice Thrown when upkeep withdrawal timelock has not passed yet
error UPKEEP_WITHDRAWAL_NOT_READY();
```

### UPKEEP_WITHDRAWAL_NOT_FOUND

```solidity
/// @notice Thrown when no pending upkeep withdrawal request exists
error UPKEEP_WITHDRAWAL_NOT_FOUND();
```

### PPS_MUST_DECREASE_AFTER_SKIM

```solidity
/// @notice PPS must decrease after skimming fees
error PPS_MUST_DECREASE_AFTER_SKIM();
```

### PPS_DEDUCTION_TOO_LARGE

```solidity
/// @notice PPS deduction is larger than the maximum allowed fee rate
error PPS_DEDUCTION_TOO_LARGE();
```

### NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE

```solidity
/// @notice Thrown when no minUpdateInterval change proposal is pending
error NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE();
```

### MIN_UPDATE_INTERVAL_TOO_HIGH

```solidity
/// @notice Thrown when minUpdateInterval >= maxStaleness
error MIN_UPDATE_INTERVAL_TOO_HIGH();
```

### STRATEGY_PAUSED

```solidity
/// @notice Thrown when trying to update PPS while strategy is paused
error STRATEGY_PAUSED();
```

### PPS_STALE

```solidity
/// @notice Thrown when trying to update PPS while PPS is stale
error PPS_STALE();
```

## Events

### VaultDeployed

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

### PPSUpdated

```solidity
/// @notice Emitted when a PPS value is updated
///  @param strategy Address of the strategy
///  @param pps New price-per-share value
///  @param timestamp Timestamp of the update
event PPSUpdated(address indexed strategy, uint256 pps, uint256 timestamp);
```

### StrategyPaused

```solidity
/// @notice Emitted when a strategy is paused due to missed updates
///  @param strategy Address of the paused strategy
event StrategyPaused(address indexed strategy);
```

### StrategyUnpaused

```solidity
/// @notice Emitted when a strategy is unpaused
///  @param strategy Address of the unpaused strategy
event StrategyUnpaused(address indexed strategy);
```

### StrategyCheckFailed

```solidity
/// @notice Emitted when a strategy validation check fails but execution continues
///  @param strategy Address of the strategy that failed the check
///  @param reason String description of which check failed
event StrategyCheckFailed(address indexed strategy, string reason);
```

### UpkeepDeposited

```solidity
/// @notice Emitted when upkeep tokens are deposited
///  @param strategy Address of the strategy
///  @param depositor Address of the depositor
///  @param amount Amount of upkeep tokens deposited
event UpkeepDeposited(address indexed strategy, address indexed depositor, uint256 amount);
```

### UpkeepWithdrawn

```solidity
/// @notice Emitted when upkeep tokens are withdrawn
///  @param strategy Address of the strategy
///  @param withdrawer Address of the withdrawer (main manager of the strategy)
///  @param amount Amount of upkeep tokens withdrawn
event UpkeepWithdrawn(address indexed strategy, address indexed withdrawer, uint256 amount);
```

### UpkeepWithdrawalProposed

```solidity
/// @notice Emitted when an upkeep withdrawal is proposed (start of 24h timelock)
///  @param strategy Address of the strategy
///  @param mainManager Address of the main manager who proposed the withdrawal
///  @param amount Amount of upkeep tokens to withdraw
///  @param effectiveTime Timestamp when withdrawal can be executed
event UpkeepWithdrawalProposed(address indexed strategy, address indexed mainManager, uint256 amount, uint256 effectiveTime);
```

### UpkeepWithdrawalCancelled

```solidity
/// @notice Emitted when a pending upkeep withdrawal is cancelled (e.g., during governance takeover)
///  @param strategy Address of the strategy
event UpkeepWithdrawalCancelled(address indexed strategy);
```

### UpkeepSpent

```solidity
/// @notice Emitted when upkeep tokens are spent for validation
///  @param strategy Address of the strategy
///  @param amount Amount of upkeep tokens spent
///  @param balance Current balance of the strategy
///  @param claimableUpkeep Amount of upkeep tokens claimable
event UpkeepSpent(address indexed strategy, uint256 amount, uint256 balance, uint256 claimableUpkeep);
```

### SecondaryManagerAdded

```solidity
/// @notice Emitted when a secondary manager is added to a strategy
///  @param strategy Address of the strategy
///  @param manager Address of the manager added
event SecondaryManagerAdded(address indexed strategy, address indexed manager);
```

### SecondaryManagerRemoved

```solidity
/// @notice Emitted when a secondary manager is removed from a strategy
///  @param strategy Address of the strategy
///  @param manager Address of the manager removed
event SecondaryManagerRemoved(address indexed strategy, address indexed manager);
```

### PrimaryManagerChanged

```solidity
/// @notice Emitted when a primary manager is changed
///  @param strategy Address of the strategy
///  @param oldManager Address of the old primary manager
///  @param newManager Address of the new primary manager
///  @param feeRecipient Address of the new fee recipient
event PrimaryManagerChanged(address indexed strategy, address indexed oldManager, address indexed newManager, address feeRecipient);
```

### PrimaryManagerChangeProposed

```solidity
/// @notice Emitted when a change to primary manager is proposed by a secondary manager
///  @param strategy Address of the strategy
///  @param proposer Address of the secondary manager who made the proposal
///  @param newManager Address of the proposed new primary manager
///  @param effectiveTime Timestamp when the proposal can be executed
event PrimaryManagerChangeProposed(address indexed strategy, address indexed proposer, address indexed newManager, address feeRecipient, uint256 effectiveTime);
```

### PrimaryManagerChangeCancelled

```solidity
/// @notice Emitted when a primary manager change proposal is cancelled
///  @param strategy Address of the strategy
///  @param cancelledManager Address of the manager that was proposed
event PrimaryManagerChangeCancelled(address indexed strategy, address indexed cancelledManager);
```

### HighWaterMarkReset

```solidity
/// @notice Emitted when the High Water Mark for a strategy is reset to PPS
///  @param strategy Address of the strategy
///  @param newHWM The new High Water Mark (PPS)
event HighWaterMarkReset(address indexed strategy, uint256 indexed newHWM);
```

### StaleUpdate

```solidity
/// @notice Emitted when a PPS update is stale (Validators could get slashed for innactivity)
///  @param strategy Address of the strategy
///  @param updateAuthority Address of the update authority
///  @param timestamp Timestamp of the stale update
event StaleUpdate(address indexed strategy, address indexed updateAuthority, uint256 timestamp);
```

### GlobalHooksRootUpdateProposed

```solidity
/// @notice Emitted when the global hooks Merkle root is being updated
///  @param root New root value
///  @param effectiveTime Timestamp when the root becomes effective
event GlobalHooksRootUpdateProposed(bytes32 indexed root, uint256 effectiveTime);
```

### GlobalHooksRootUpdated

```solidity
/// @notice Emitted when the global hooks Merkle root is updated
///  @param oldRoot Previous root value
///  @param newRoot New root value
event GlobalHooksRootUpdated(bytes32 indexed oldRoot, bytes32 newRoot);
```

### StrategyHooksRootUpdated

```solidity
/// @notice Emitted when a strategy-specific hooks Merkle root is updated
///  @param strategy Address of the strategy
///  @param oldRoot Previous root value (may be zero)
///  @param newRoot New root value
event StrategyHooksRootUpdated(address indexed strategy, bytes32 oldRoot, bytes32 newRoot);
```

### StrategyHooksRootUpdateProposed

```solidity
/// @notice Emitted when a strategy-specific hooks Merkle root is proposed
///  @param strategy Address of the strategy
///  @param proposer Address of the account proposing the new root
///  @param root New root value
///  @param effectiveTime Timestamp when the root becomes effective
event StrategyHooksRootUpdateProposed(address indexed strategy, address indexed proposer, bytes32 root, uint256 effectiveTime);
```

### GlobalHooksRootVetoStatusChanged

```solidity
/// @notice Emitted when a proposed global hooks root update is vetoed by SuperGovernor
///  @param vetoed Whether the root is being vetoed (true) or unvetoed (false)
///  @param root The root value affected
event GlobalHooksRootVetoStatusChanged(bool vetoed, bytes32 indexed root);
```

### StrategyHooksRootVetoStatusChanged

```solidity
/// @notice Emitted when a strategy's hooks Merkle root veto status changes
///  @param strategy Address of the strategy
///  @param vetoed Whether the root is being vetoed (true) or unvetoed (false)
///  @param root The root value affected
event StrategyHooksRootVetoStatusChanged(address indexed strategy, bool vetoed, bytes32 indexed root);
```

### DeviationThresholdUpdated

```solidity
/// @notice Emitted when a strategy's deviation threshold is updated
///  @param strategy Address of the strategy
///  @param deviationThreshold New deviation threshold (abs diff/current)
event DeviationThresholdUpdated(address indexed strategy, uint256 deviationThreshold);
```

### HooksRootUpdateTimelockChanged

```solidity
/// @notice Emitted when the hooks root update timelock is changed
///  @param newTimelock New timelock duration in seconds
event HooksRootUpdateTimelockChanged(uint256 newTimelock);
```

### GlobalLeavesStatusChanged

```solidity
/// @notice Emitted when global leaves status is changed for a strategy
///  @param strategy Address of the strategy
///  @param leaves Array of leaf hashes that had their status changed
///  @param statuses Array of new banned statuses (true = banned, false = allowed)
event GlobalLeavesStatusChanged(address indexed strategy, bytes32[] leaves, bool[] statuses);
```

### UpkeepClaimed

```solidity
/// @notice Emitted when upkeep is claimed
///  @param superBank Address of the superBank
///  @param amount Amount of upkeep claimed
event UpkeepClaimed(address indexed superBank, uint256 amount);
```

### UpdateTooFrequent

```solidity
/// @notice Emitted when PPS update is too frequent (before minUpdateInterval)
event UpdateTooFrequent();
```

### TimestampNotMonotonic

```solidity
/// @notice Emitted when PPS update timestamp is not monotonically increasing
event TimestampNotMonotonic();
```

### StaleSignatureAfterUnpause

```solidity
/// @notice Emitted when PPS update is rejected due to stale signature after unpause
event StaleSignatureAfterUnpause(address indexed strategy, uint256 signatureTimestamp, uint256 lastUnpauseTimestamp);
```

### InsufficientUpkeep

```solidity
/// @notice Emitted when a strategy does not have enough upkeep balance
event InsufficientUpkeep(address indexed strategy, address indexed strategyAddr, uint256 balance, uint256 cost);
```

### ProvidedTimestampExceedsBlockTimestamp

```solidity
/// @notice Emitted when the provided timestamp is too large
event ProvidedTimestampExceedsBlockTimestamp(address indexed strategy, uint256 argsTimestamp, uint256 blockTimestamp);
```

### UnknownStrategy

```solidity
/// @notice Emitted when a strategy is unknown
event UnknownStrategy(address indexed strategy);
```

### OldPrimaryManagerRemoved

```solidity
/// @notice Emitted when the old primary manager is removed from the strategy
///  @dev This can happen because of reaching the max number of secondary managers
event OldPrimaryManagerRemoved(address indexed strategy, address indexed oldManager);
```

### StrategyPPSStale

```solidity
/// @notice Emitted when a strategy's PPS is stale
event StrategyPPSStale(address indexed strategy);
```

### StrategyPPSStaleReset

```solidity
/// @notice Emitted when a strategy's PPS is reset
event StrategyPPSStaleReset(address indexed strategy);
```

### PPSUpdatedAfterSkim

```solidity
/// @notice Emitted when PPS is updated after performance fee skimming
///  @param strategy Address of the strategy
///  @param oldPPS Previous price-per-share value
///  @param newPPS New price-per-share value after fee deduction
///  @param feeAmount Amount of fee skimmed that caused the PPS update
///  @param timestamp Timestamp of the update
event PPSUpdatedAfterSkim(address indexed strategy, uint256 oldPPS, uint256 newPPS, uint256 feeAmount, uint256 timestamp);
```

### MinUpdateIntervalChangeProposed

```solidity
/// @notice Emitted when a change to minUpdateInterval is proposed
///  @param strategy Address of the strategy
///  @param proposer Address of the manager who made the proposal
///  @param newMinUpdateInterval The proposed new minimum update interval
///  @param effectiveTime Timestamp when the proposal can be executed
event MinUpdateIntervalChangeProposed(address indexed strategy, address indexed proposer, uint256 newMinUpdateInterval, uint256 effectiveTime);
```

### MinUpdateIntervalChanged

```solidity
/// @notice Emitted when a minUpdateInterval change is executed
///  @param strategy Address of the strategy
///  @param oldMinUpdateInterval Previous minimum update interval
///  @param newMinUpdateInterval New minimum update interval
event MinUpdateIntervalChanged(address indexed strategy, uint256 oldMinUpdateInterval, uint256 newMinUpdateInterval);
```

### MinUpdateIntervalChangeRejected

```solidity
/// @notice Emitted when a minUpdateInterval change proposal is rejected due to validation failure
///  @param strategy Address of the strategy
///  @param proposedInterval The proposed interval that was rejected
///  @param currentMaxStaleness The current maxStaleness value that caused rejection
event MinUpdateIntervalChangeRejected(address indexed strategy, uint256 proposedInterval, uint256 currentMaxStaleness);
```

### MinUpdateIntervalChangeCancelled

```solidity
/// @notice Emitted when a minUpdateInterval change proposal is cancelled
///  @param strategy Address of the strategy
///  @param cancelledInterval The proposed interval that was cancelled
event MinUpdateIntervalChangeCancelled(address indexed strategy, uint256 cancelledInterval);
```

### PPSUpdateRejectedStrategyPaused

```solidity
/// @notice Emitted when a PPS update is rejected because strategy is paused
///  @param strategy Address of the paused strategy
event PPSUpdateRejectedStrategyPaused(address indexed strategy);
```

## Public/External Functions

### createVault(struct ISuperVaultAggregator.VaultCreationParams)

- **Signature**: `createVault(struct ISuperVaultAggregator.VaultCreationParams)`
- **Visibility**: external
- **Source Range**: 22751:146:520

**Signature:**
```solidity
/// @notice Creates a new SuperVault trio (SuperVault, SuperVaultStrategy, SuperVaultEscrow)
///  @param params Parameters for the new vault creation
///  @return superVault Address of the created SuperVault
///  @return strategy Address of the created SuperVaultStrategy
///  @return escrow Address of the created SuperVaultEscrow
function createVault(VaultCreationParams calldata params) external returns (address superVault, address strategy, address escrow);;
```

### forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)

- **Signature**: `forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)`
- **Visibility**: external
- **Source Range**: 23687:59:520

**Signature:**
```solidity
/// @notice Batch forwards validated PPS updates to multiple strategies
///  @param args Struct containing all batch PPS update parameters
function forwardPPS(ForwardPPSArgs calldata args) external;;
```

### updatePPSAfterSkim(uint256,uint256)

- **Signature**: `updatePPSAfterSkim(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 24066:72:520

**Signature:**
```solidity
/// @notice Updates PPS directly after performance fee skimming
///  @dev Only callable by the strategy contract itself (msg.sender must be a registered strategy)
///  @param newPPS New price-per-share value after fee deduction
///  @param feeAmount Amount of fee that was skimmed (for event logging)
function updatePPSAfterSkim(uint256 newPPS, uint256 feeAmount) external;;
```

### depositUpkeep(address,uint256)

- **Signature**: `depositUpkeep(address,uint256)`
- **Visibility**: external
- **Source Range**: 24595:66:520

**Signature:**
```solidity
/// @notice Deposits upkeep tokens for strategy upkeep
///  @dev The upkeep token is configurable per chain (UP on mainnet, WETH on L2s, etc.)
///  @param strategy Address of the strategy to deposit for
///  @param amount Amount of upkeep tokens to deposit
function depositUpkeep(address strategy, uint256 amount) external;;
```

### proposeWithdrawUpkeep(address)

- **Signature**: `proposeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 24928:58:520

**Signature:**
```solidity
/// @notice Proposes withdrawal of upkeep tokens from strategy upkeep balance (starts 24h timelock)
///  @dev Only the main manager can propose. Withdraws full balance at time of proposal.
///  @param strategy Address of the strategy to withdraw from
function proposeWithdrawUpkeep(address strategy) external;;
```

### executeWithdrawUpkeep(address)

- **Signature**: `executeWithdrawUpkeep(address)`
- **Visibility**: external
- **Source Range**: 25211:58:520

**Signature:**
```solidity
/// @notice Executes a pending upkeep withdrawal after 24h timelock
///  @dev Anyone can execute, but funds go to the main manager of the strategy
///  @param strategy Address of the strategy to withdraw from
function executeWithdrawUpkeep(address strategy) external;;
```

### claimUpkeep(uint256)

- **Signature**: `claimUpkeep(uint256)`
- **Visibility**: external
- **Source Range**: 25385:46:520

**Signature:**
```solidity
/// @notice Claims upkeep tokens from the contract
///  @param amount Amount of upkeep tokens to claim
function claimUpkeep(uint256 amount) external;;
```

### pauseStrategy(address)

- **Signature**: `pauseStrategy(address)`
- **Visibility**: external
- **Source Range**: 25717:50:520

**Signature:**
```solidity
/// @notice Manually pauses a strategy
///  @param strategy Address of the strategy to pause
function pauseStrategy(address strategy) external;;
```

### unpauseStrategy(address)

- **Signature**: `unpauseStrategy(address)`
- **Visibility**: external
- **Source Range**: 25877:52:520

**Signature:**
```solidity
/// @notice Manually unpauses a strategy
///  @param strategy Address of the strategy to unpause
function unpauseStrategy(address strategy) external;;
```

### addSecondaryManager(address,address)

- **Signature**: `addSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 26343:73:520

**Signature:**
```solidity
/// @notice Adds a secondary manager to a strategy
///  @notice A manager can either be secondary or primary
///  @param strategy Address of the strategy
///  @param manager Address of the manager to add
function addSecondaryManager(address strategy, address manager) external;;
```

### removeSecondaryManager(address,address)

- **Signature**: `removeSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 26586:76:520

**Signature:**
```solidity
/// @notice Removes a secondary manager from a strategy
///  @param strategy Address of the strategy
///  @param manager Address of the manager to remove
function removeSecondaryManager(address strategy, address manager) external;;
```

### changePrimaryManager(address,address,address)

- **Signature**: `changePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 27002:99:520

**Signature:**
```solidity
/// @notice Changes the primary manager of a strategy immediately (only callable by SuperGovernor)
///  @notice A manager can either be secondary or primary
///  @param strategy Address of the strategy
///  @param newManager Address of the new primary manager
///  @param feeRecipient Address of the new fee recipient
function changePrimaryManager(address strategy, address newManager, address feeRecipient) external;;
```

### proposeChangePrimaryManager(address,address,address)

- **Signature**: `proposeChangePrimaryManager(address,address,address)`
- **Visibility**: external
- **Source Range**: 27437:106:520

**Signature:**
```solidity
/// @notice Proposes a change to the primary manager (callable by secondary managers)
///  @notice A manager can either be secondary or primary
///  @param strategy Address of the strategy
///  @param newManager Address of the proposed new primary manager
///  @param feeRecipient Address of the new fee recipient
function proposeChangePrimaryManager(address strategy, address newManager, address feeRecipient) external;;
```

### cancelChangePrimaryManager(address)

- **Signature**: `cancelChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 27733:63:520

**Signature:**
```solidity
/// @notice Cancels a pending primary manager change proposal
///  @dev Only the current primary manager can cancel the proposal
///  @param strategy Address of the strategy
function cancelChangePrimaryManager(address strategy) external;;
```

### executeChangePrimaryManager(address)

- **Signature**: `executeChangePrimaryManager(address)`
- **Visibility**: external
- **Source Range**: 27942:64:520

**Signature:**
```solidity
/// @notice Executes a previously proposed change to the primary manager after timelock
///  @param strategy Address of the strategy
function executeChangePrimaryManager(address strategy) external;;
```

### resetHighWaterMark(address)

- **Signature**: `resetHighWaterMark(address)`
- **Visibility**: external
- **Source Range**: 28181:55:520

**Signature:**
```solidity
/// @notice Resets the strategy's performance-fee high-water mark to PPS
///  @dev Only callable by SuperGovernor
///  @param strategy Address of the strategy
function resetHighWaterMark(address strategy) external;;
```

### setHooksRootUpdateTimelock(uint256)

- **Signature**: `setHooksRootUpdateTimelock(uint256)`
- **Visibility**: external
- **Source Range**: 28557:66:520

**Signature:**
```solidity
/// @notice Sets a new hooks root update timelock duration
///  @param newTimelock The new timelock duration in seconds
function setHooksRootUpdateTimelock(uint256 newTimelock) external;;
```

### proposeGlobalHooksRoot(bytes32)

- **Signature**: `proposeGlobalHooksRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 28808:58:520

**Signature:**
```solidity
/// @notice Proposes an update to the global hooks Merkle root
///  @dev Only callable by SUPER_GOVERNOR
///  @param newRoot New Merkle root for global hooks validation
function proposeGlobalHooksRoot(bytes32 newRoot) external;;
```

### executeGlobalHooksRootUpdate()

- **Signature**: `executeGlobalHooksRootUpdate()`
- **Visibility**: external
- **Source Range**: 29041:49:520

**Signature:**
```solidity
/// @notice Executes a previously proposed global hooks root update after timelock period
///  @dev Can be called by anyone after the timelock period has elapsed
function executeGlobalHooksRootUpdate() external;;
```

### proposeStrategyHooksRoot(address,bytes32)

- **Signature**: `proposeStrategyHooksRoot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 29351:78:520

**Signature:**
```solidity
/// @notice Proposes an update to a strategy-specific hooks Merkle root
///  @dev Only callable by the main manager for the strategy
///  @param strategy Address of the strategy
///  @param newRoot New Merkle root for strategy-specific hooks
function proposeStrategyHooksRoot(address strategy, bytes32 newRoot) external;;
```

### executeStrategyHooksRootUpdate(address)

- **Signature**: `executeStrategyHooksRootUpdate(address)`
- **Visibility**: external
- **Source Range**: 29683:67:520

**Signature:**
```solidity
/// @notice Executes a previously proposed strategy hooks root update after timelock period
///  @dev Can be called by anyone after the timelock period has elapsed
///  @param strategy Address of the strategy whose root update to execute
function executeStrategyHooksRootUpdate(address strategy) external;;
```

### setGlobalHooksRootVetoStatus(bool)

- **Signature**: `setGlobalHooksRootVetoStatus(bool)`
- **Visibility**: external
- **Source Range**: 29943:60:520

**Signature:**
```solidity
/// @notice Set veto status for the global hooks root
///  @dev Only callable by SuperGovernor
///  @param vetoed Whether to veto (true) or unveto (false) the global hooks root
function setGlobalHooksRootVetoStatus(bool vetoed) external;;
```

### setStrategyHooksRootVetoStatus(address,bool)

- **Signature**: `setStrategyHooksRootVetoStatus(address,bool)`
- **Visibility**: external
- **Source Range**: 30258:80:520

**Signature:**
```solidity
/// @notice Set veto status for a strategy-specific hooks root
///  @notice Sets the veto status of a strategy's hooks Merkle root
///  @param strategy Address of the strategy
///  @param vetoed Whether to veto (true) or unveto (false)
function setStrategyHooksRootVetoStatus(address strategy, bool vetoed) external;;
```

### updateDeviationThreshold(address,uint256)

- **Signature**: `updateDeviationThreshold(address,uint256)`
- **Visibility**: external
- **Source Range**: 30555:90:520

**Signature:**
```solidity
/// @notice Updates the deviation threshold for a strategy
///  @param strategy Address of the strategy
///  @param deviationThreshold_ New deviation threshold (abs diff/current ratio, scaled by 1e18)
function updateDeviationThreshold(address strategy, uint256 deviationThreshold_) external;;
```

### changeGlobalLeavesStatus(bytes32[],bool[],address)

- **Signature**: `changeGlobalLeavesStatus(bytes32[],bool[],address)`
- **Visibility**: external
- **Source Range**: 31022:110:520

**Signature:**
```solidity
/// @notice Changes the banned status of global leaves for a specific strategy
///  @dev Only callable by the primary manager of the strategy
///  @param leaves Array of leaf hashes to change status for
///  @param statuses Array of banned statuses (true = banned, false = allowed)
///  @param strategy Address of the strategy to change banned leaves for
function changeGlobalLeavesStatus(bytes32[] memory leaves, bool[] memory statuses, address strategy) external;;
```

### proposeMinUpdateIntervalChange(address,uint256)

- **Signature**: `proposeMinUpdateIntervalChange(address,uint256)`
- **Visibility**: external
- **Source Range**: 31622:97:520

**Signature:**
```solidity
/// @notice Proposes a change to the minimum update interval for a strategy
///  @param strategy Address of the strategy
///  @param newMinUpdateInterval The proposed new minimum update interval (in seconds)
///  @dev Only the main manager can propose. Must be less than maxStaleness
function proposeMinUpdateIntervalChange(address strategy, uint256 newMinUpdateInterval) external;;
```

### executeMinUpdateIntervalChange(address)

- **Signature**: `executeMinUpdateIntervalChange(address)`
- **Visibility**: external
- **Source Range**: 31969:67:520

**Signature:**
```solidity
/// @notice Executes a previously proposed minUpdateInterval change after timelock
///  @param strategy Address of the strategy whose minUpdateInterval to update
///  @dev Can be called by anyone after the timelock period has elapsed
function executeMinUpdateIntervalChange(address strategy) external;;
```

### cancelMinUpdateIntervalChange(address)

- **Signature**: `cancelMinUpdateIntervalChange(address)`
- **Visibility**: external
- **Source Range**: 32204:66:520

**Signature:**
```solidity
/// @notice Cancels a pending minUpdateInterval change proposal
///  @param strategy Address of the strategy
///  @dev Only the main manager can cancel
function cancelMinUpdateIntervalChange(address strategy) external;;
```

### getProposedMinUpdateInterval(address)

- **Signature**: `getProposedMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 32554:152:520

**Signature:**
```solidity
/// @notice Gets the proposed minUpdateInterval and effective time
///  @param strategy Address of the strategy
///  @return proposedInterval The proposed minimum update interval
///  @return effectiveTime The timestamp when the proposed interval becomes effective
function getProposedMinUpdateInterval(address strategy) external view returns (uint256 proposedInterval, uint256 effectiveTime);;
```

### getCurrentNonce()

- **Signature**: `getCurrentNonce()`
- **Visibility**: external
- **Source Range**: 33071:59:520

**Signature:**
```solidity
/// @notice Returns the current vault creation nonce
///  @dev This nonce is incremented every time a new vault is created
///  @return Current vault creation nonce
function getCurrentNonce() external view returns (uint256);;
```

### isGlobalHooksRootVetoed()

- **Signature**: `isGlobalHooksRootVetoed()`
- **Visibility**: external
- **Source Range**: 33266:71:520

**Signature:**
```solidity
/// @notice Check if the global hooks root is currently vetoed
///  @return vetoed True if the global hooks root is vetoed
function isGlobalHooksRootVetoed() external view returns (bool vetoed);;
```

### isStrategyHooksRootVetoed(address)

- **Signature**: `isStrategyHooksRootVetoed(address)`
- **Visibility**: external
- **Source Range**: 33532:89:520

**Signature:**
```solidity
/// @notice Check if a strategy hooks root is currently vetoed
///  @param strategy Address of the strategy to check
///  @return vetoed True if the strategy hooks root is vetoed
function isStrategyHooksRootVetoed(address strategy) external view returns (bool vetoed);;
```

### getHooksRootUpdateTimelock()

- **Signature**: `getHooksRootUpdateTimelock()`
- **Visibility**: external
- **Source Range**: 33753:70:520

**Signature:**
```solidity
/// @notice Gets the current hooks root update timelock duration
///  @return The current timelock duration in seconds
function getHooksRootUpdateTimelock() external view returns (uint256);;
```

### getPPS(address)

- **Signature**: `getPPS(address)`
- **Visibility**: external
- **Source Range**: 33997:70:520

**Signature:**
```solidity
/// @notice Gets the current PPS (price-per-share) for a strategy
///  @param strategy Address of the strategy
///  @return pps Current price-per-share value
function getPPS(address strategy) external view returns (uint256 pps);;
```

### getLastUpdateTimestamp(address)

- **Signature**: `getLastUpdateTimestamp(address)`
- **Visibility**: external
- **Source Range**: 34237:92:520

**Signature:**
```solidity
/// @notice Gets the last update timestamp for a strategy's PPS
///  @param strategy Address of the strategy
///  @return timestamp Last update timestamp
function getLastUpdateTimestamp(address strategy) external view returns (uint256 timestamp);;
```

### getMinUpdateInterval(address)

- **Signature**: `getMinUpdateInterval(address)`
- **Visibility**: external
- **Source Range**: 34501:89:520

**Signature:**
```solidity
/// @notice Gets the minimum update interval for a strategy
///  @param strategy Address of the strategy
///  @return interval Minimum time between updates
function getMinUpdateInterval(address strategy) external view returns (uint256 interval);;
```

### getMaxStaleness(address)

- **Signature**: `getMaxStaleness(address)`
- **Visibility**: external
- **Source Range**: 34772:85:520

**Signature:**
```solidity
/// @notice Gets the maximum staleness period for a strategy
///  @param strategy Address of the strategy
///  @return staleness Maximum time allowed between updates
function getMaxStaleness(address strategy) external view returns (uint256 staleness);;
```

### getDeviationThreshold(address)

- **Signature**: `getDeviationThreshold(address)`
- **Visibility**: external
- **Source Range**: 35079:100:520

**Signature:**
```solidity
/// @notice Gets the deviation threshold for a strategy
///  @param strategy Address of the strategy
///  @return deviationThreshold The current deviation threshold (abs diff/current ratio, scaled by 1e18)
function getDeviationThreshold(address strategy) external view returns (uint256 deviationThreshold);;
```

### isStrategyPaused(address)

- **Signature**: `isStrategyPaused(address)`
- **Visibility**: external
- **Source Range**: 35347:82:520

**Signature:**
```solidity
/// @notice Checks if a strategy is currently paused
///  @param strategy Address of the strategy
///  @return isPaused True if paused, false otherwise
function isStrategyPaused(address strategy) external view returns (bool isPaused);;
```

### isPPSStale(address)

- **Signature**: `isPPSStale(address)`
- **Visibility**: external
- **Source Range**: 35734:75:520

**Signature:**
```solidity
/// @notice Checks if a strategy's PPS is stale
///  @dev PPS is automatically set to stale when the strategy is paused due to
///       lack of upkeep payment in `SuperVaultAggregator`
///  @param strategy Address of the strategy
///  @return isStale True if stale, false otherwise
function isPPSStale(address strategy) external view returns (bool isStale);;
```

### getLastUnpauseTimestamp(address)

- **Signature**: `getLastUnpauseTimestamp(address)`
- **Visibility**: external
- **Source Range**: 35997:93:520

**Signature:**
```solidity
/// @notice Gets the last unpause timestamp for a strategy
///  @param strategy Address of the strategy
///  @return timestamp Last unpause timestamp (0 if never unpaused)
function getLastUnpauseTimestamp(address strategy) external view returns (uint256 timestamp);;
```

### getUpkeepBalance(address)

- **Signature**: `getUpkeepBalance(address)`
- **Visibility**: external
- **Source Range**: 36271:84:520

**Signature:**
```solidity
/// @notice Gets the current upkeep balance for a strategy
///  @param strategy Address of the strategy
///  @return balance Current upkeep balance in upkeep tokens
function getUpkeepBalance(address strategy) external view returns (uint256 balance);;
```

### getMainManager(address)

- **Signature**: `getMainManager(address)`
- **Visibility**: external
- **Source Range**: 36514:82:520

**Signature:**
```solidity
/// @notice Gets the main manager for a strategy
///  @param strategy Address of the strategy
///  @return manager Address of the main manager
function getMainManager(address strategy) external view returns (address manager);;
```

### getPendingManagerChange(address)

- **Signature**: `getPendingManagerChange(address)`
- **Visibility**: external
- **Source Range**: 36909:146:520

**Signature:**
```solidity
/// @notice Gets pending primary manager change details
///  @param strategy Address of the strategy
///  @return proposedManager Address of the proposed new manager (address(0) if no pending change)
///  @return effectiveTime Timestamp when the change can be executed (0 if no pending change)
function getPendingManagerChange(address strategy) external view returns (address proposedManager, uint256 effectiveTime);;
```

### isMainManager(address,address)

- **Signature**: `isMainManager(address,address)`
- **Visibility**: external
- **Source Range**: 37314:101:520

**Signature:**
```solidity
/// @notice Checks if an address is the main manager for a strategy
///  @param manager Address of the manager
///  @param strategy Address of the strategy
///  @return isMainManager True if the address is the main manager, false otherwise
function isMainManager(address manager, address strategy) external view returns (bool isMainManager);;
```

### getSecondaryManagers(address)

- **Signature**: `getSecondaryManagers(address)`
- **Visibility**: external
- **Source Range**: 37599:107:520

**Signature:**
```solidity
/// @notice Gets all secondary managers for a strategy
///  @param strategy Address of the strategy
///  @return secondaryManagers Array of secondary manager addresses
function getSecondaryManagers(address strategy) external view returns (address[] memory secondaryManagers);;
```

### isSecondaryManager(address,address)

- **Signature**: `isSecondaryManager(address,address)`
- **Visibility**: external
- **Source Range**: 37976:111:520

**Signature:**
```solidity
/// @notice Checks if an address is a secondary manager for a strategy
///  @param manager Address of the manager
///  @param strategy Address of the strategy
///  @return isSecondaryManager True if the address is a secondary manager, false otherwise
function isSecondaryManager(address manager, address strategy) external view returns (bool isSecondaryManager);;
```

### isAnyManager(address,address)

- **Signature**: `isAnyManager(address,address)`
- **Visibility**: external
- **Source Range**: 38383:86:520

**Signature:**
```solidity
/// @dev Internal helper function to check if an address is any kind of manager (primary or secondary)
///  @param manager Address to check
///  @param strategy The strategy to check against
///  @return True if the address is either the primary manager or a secondary manager
function isAnyManager(address manager, address strategy) external view returns (bool);;
```

### getAllSuperVaults()

- **Signature**: `getAllSuperVaults()`
- **Visibility**: external
- **Source Range**: 38566:70:520

**Signature:**
```solidity
/// @notice Gets all created SuperVaults
///  @return Array of SuperVault addresses
function getAllSuperVaults() external view returns (address[] memory);;
```

### superVaults(uint256)

- **Signature**: `superVaults(uint256)`
- **Visibility**: external
- **Source Range**: 38792:68:520

**Signature:**
```solidity
/// @notice Gets a SuperVault by index
///  @param index The index of the SuperVault
///  @return The SuperVault address at the given index
function superVaults(uint256 index) external view returns (address);;
```

### getAllSuperVaultStrategies()

- **Signature**: `getAllSuperVaultStrategies()`
- **Visibility**: external
- **Source Range**: 38974:79:520

**Signature:**
```solidity
/// @notice Gets all created SuperVaultStrategies
///  @return Array of SuperVaultStrategy addresses
function getAllSuperVaultStrategies() external view returns (address[] memory);;
```

### superVaultStrategies(uint256)

- **Signature**: `superVaultStrategies(uint256)`
- **Visibility**: external
- **Source Range**: 39233:77:520

**Signature:**
```solidity
/// @notice Gets a SuperVaultStrategy by index
///  @param index The index of the SuperVaultStrategy
///  @return The SuperVaultStrategy address at the given index
function superVaultStrategies(uint256 index) external view returns (address);;
```

### getAllSuperVaultEscrows()

- **Signature**: `getAllSuperVaultEscrows()`
- **Visibility**: external
- **Source Range**: 39419:76:520

**Signature:**
```solidity
/// @notice Gets all created SuperVaultEscrows
///  @return Array of SuperVaultEscrow addresses
function getAllSuperVaultEscrows() external view returns (address[] memory);;
```

### superVaultEscrows(uint256)

- **Signature**: `superVaultEscrows(uint256)`
- **Visibility**: external
- **Source Range**: 39669:74:520

**Signature:**
```solidity
/// @notice Gets a SuperVaultEscrow by index
///  @param index The index of the SuperVaultEscrow
///  @return The SuperVaultEscrow address at the given index
function superVaultEscrows(uint256 index) external view returns (address);;
```

### validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)

- **Signature**: `validateHook(address,struct ISuperVaultAggregator.ValidateHookArgs)`
- **Visibility**: external
- **Source Range**: 40005:109:520

**Signature:**
```solidity
/// @notice Validates a hook against both global and strategy-specific Merkle roots
///  @param strategy Address of the strategy
///  @param args Arguments for hook validation
///  @return isValid True if the hook is valid against either root
function validateHook(address strategy, ValidateHookArgs calldata args) external view returns (bool isValid);;
```

### validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])

- **Signature**: `validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])`
- **Visibility**: external
- **Source Range**: 40374:175:520

**Signature:**
```solidity
/// @notice Batch validates multiple hooks against Merkle roots
///  @param strategy Address of the strategy
///  @param argsArray Array of hook validation arguments
///  @return validHooks Array of booleans indicating which hooks are valid
function validateHooks(address strategy, ValidateHookArgs[] calldata argsArray) external view returns (bool[] memory validHooks);;
```

### getGlobalHooksRoot()

- **Signature**: `getGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 40671:67:520

**Signature:**
```solidity
/// @notice Gets the current global hooks Merkle root
///  @return root The current global hooks Merkle root
function getGlobalHooksRoot() external view returns (bytes32 root);;
```

### getProposedGlobalHooksRoot()

- **Signature**: `getProposedGlobalHooksRoot()`
- **Visibility**: external
- **Source Range**: 40959:98:520

**Signature:**
```solidity
/// @notice Gets the proposed global hooks root and effective time
///  @return root The proposed global hooks Merkle root
///  @return effectiveTime The timestamp when the proposed root becomes effective
function getProposedGlobalHooksRoot() external view returns (bytes32 root, uint256 effectiveTime);;
```

### isGlobalHooksRootActive()

- **Signature**: `isGlobalHooksRootActive()`
- **Visibility**: external
- **Source Range**: 41215:64:520

**Signature:**
```solidity
/// @notice Checks if the global hooks root is active (timelock period has passed)
///  @return isActive True if the global hooks root is active
function isGlobalHooksRootActive() external view returns (bool);;
```

### getStrategyHooksRoot(address)

- **Signature**: `getStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 41461:85:520

**Signature:**
```solidity
/// @notice Gets the hooks Merkle root for a specific strategy
///  @param strategy Address of the strategy
///  @return root The strategy-specific hooks Merkle root
function getStrategyHooksRoot(address strategy) external view returns (bytes32 root);;
```

### getProposedStrategyHooksRoot(address)

- **Signature**: `getProposedStrategyHooksRoot(address)`
- **Visibility**: external
- **Source Range**: 41819:116:520

**Signature:**
```solidity
/// @notice Gets the proposed strategy hooks root and effective time
///  @param strategy Address of the strategy
///  @return root The proposed strategy hooks Merkle root
///  @return effectiveTime The timestamp when the proposed root becomes effective
function getProposedStrategyHooksRoot(address strategy) external view returns (bytes32 root, uint256 effectiveTime);;
```

### getSuperVaultsCount()

- **Signature**: `getSuperVaultsCount()`
- **Visibility**: external
- **Source Range**: 42048:63:520

**Signature:**
```solidity
/// @notice Gets the total number of SuperVaults
///  @return count The total number of SuperVaults
function getSuperVaultsCount() external view returns (uint256);;
```

### getSuperVaultStrategiesCount()

- **Signature**: `getSuperVaultStrategiesCount()`
- **Visibility**: external
- **Source Range**: 42242:72:520

**Signature:**
```solidity
/// @notice Gets the total number of SuperVaultStrategies
///  @return count The total number of SuperVaultStrategies
function getSuperVaultStrategiesCount() external view returns (uint256);;
```

### getSuperVaultEscrowsCount()

- **Signature**: `getSuperVaultEscrowsCount()`
- **Visibility**: external
- **Source Range**: 42439:69:520

**Signature:**
```solidity
/// @notice Gets the total number of SuperVaultEscrows
///  @return count The total number of SuperVaultEscrows
function getSuperVaultEscrowsCount() external view returns (uint256);;
```
