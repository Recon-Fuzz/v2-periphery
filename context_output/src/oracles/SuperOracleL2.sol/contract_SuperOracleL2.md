# Contract: SuperOracleL2

## Metadata

- **Name**: SuperOracleL2
- **Type**: Contract
- **Path**: src/oracles/SuperOracleL2.sol
- **Documentation**: @title SuperOracleL2
   @author Superform Labs
   @notice Layer 2 Oracle for Superform

## Implements Interfaces

- **ISuperOracleL2** [src/interfaces/oracles/ISuperOracleL2.sol/interface_ISuperOracleL2.md]
- **IOracle** [src/vendor/awesome-oracles/IOracle.sol/interface_IOracle.md]
- **ISuperOracle** [src/interfaces/oracles/ISuperOracle.sol/interface_ISuperOracle.md]

## State Variables

### feedMaxStaleness (inherited from SuperOracleBase)

```solidity
/// @notice Mapping of feed to max staleness period
mapping(address => uint256) public feedMaxStaleness
```

### defaultStaleness (inherited from SuperOracleBase)

```solidity
uint256 public defaultStaleness
```

### pendingUpdate (inherited from SuperOracleBase)

```solidity
/// @notice Pending oracle update
PendingUpdate public pendingUpdate
```

### pendingRemoval (inherited from SuperOracleBase)

```solidity
/// @notice Pending provider removal
PendingRemoval public pendingRemoval
```

### oracles (inherited from SuperOracleBase)

```solidity
/// @notice Mapping of base asset to quote asset to oracle provider id to oracle feed address
mapping(address => mapping(address => mapping(bytes32 => address))) internal oracles
```

### activeProviders (inherited from SuperOracleBase)

```solidity
/// @notice Array of active provider ids
bytes32[] public activeProviders
```

### isProviderSet (inherited from SuperOracleBase)

```solidity
mapping(bytes32 => bool) public isProviderSet
```

### TIMELOCK_PERIOD (inherited from SuperOracleBase)

```solidity
/// @notice Timelock period for oracle feed additions (1 week)
///  @dev Long timelock protects against malicious oracle configurations that could manipulate pricing
uint256 internal constant TIMELOCK_PERIOD = 1 weeks
```

### REMOVAL_TIMELOCK_PERIOD (inherited from SuperOracleBase)

```solidity
/// @notice Short timelock period for provider removal (1 hour)
///  @dev Trade-off: Short timelock enables rapid response to corrupted feeds (DoS prevention)
///       but provides limited time to detect malicious governance actions. Removal is safer
///       than addition since it only reduces available oracles rather than introducing new attack vectors.
uint256 internal constant REMOVAL_TIMELOCK_PERIOD = 1 hours
```

### MAX_SAMPLE_PROVIDERS (inherited from SuperOracleBase)

```solidity
/// @notice Maximum number of oracle providers to sample when calculating average price
///  @dev Limits gas costs for getQuoteFromProvider(AVERAGE_PROVIDER).
///       10 providers balances price accuracy against gas costs (~300k gas for 10 oracle calls).
///       See _getAverageQuote() for sampling logic.
uint256 internal constant MAX_SAMPLE_PROVIDERS = 10
```

### MAX_PROVIDER_REMOVALS (inherited from SuperOracleBase)

```solidity
/// @notice Maximum number of providers that can be removed in a single queued removal
///  @dev Prevents excessive gas costs in executeProviderRemoval() loop.
///       Set to 20 (2x MAX_SAMPLE_PROVIDERS) to allow full provider rotation if needed.
uint256 internal constant MAX_PROVIDER_REMOVALS = 20
```

### AVERAGE_PROVIDER (inherited from SuperOracleBase)

```solidity
bytes32 internal constant AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER")
```

### SUPER_GOVERNOR (inherited from SuperOracleBase)

```solidity
address public immutable SUPER_GOVERNOR
```

### uptimeFeeds

```solidity
mapping(address => address) public uptimeFeeds
```

### gracePeriods

```solidity
mapping(address => uint256) public gracePeriods
```

### DEFAULT_GRACE_PERIOD_TIME

```solidity
/// @notice Default grace period after L2 sequencer restart (1 hour)
///  @dev Prevents stale prices from being used immediately after sequencer downtime.
///       Price feeds collected during downtime may be unreliable or manipulated.
uint256 private constant DEFAULT_GRACE_PERIOD_TIME = 3600
```

### MIN_GRACE_PERIOD_TIME

```solidity
/// @notice Minimum allowed grace period (10 minutes)
///  @dev Lower bound to ensure reasonable protection against stale data after sequencer restart
uint256 private constant MIN_GRACE_PERIOD_TIME = 600
```

## Structs

### PendingUpdate (inherited from ISuperOracle)

```solidity
/// @notice Struct for pending oracle update
struct PendingUpdate {
    address[] bases;
    address[] quotes;
    bytes32[] providers;
    address[] feeds;
    uint256 timestamp;
}
```

### PendingRemoval (inherited from ISuperOracle)

```solidity
/// @notice Struct for pending provider removal
struct PendingRemoval {
    bytes32[] providers;
    uint256 timestamp;
}
```

## Errors

### ZERO_ADDRESS (inherited from ISuperOracle)

```solidity
/// @notice Error when address is zero
error ZERO_ADDRESS();
```

### ZERO_ARRAY_LENGTH (inherited from ISuperOracle)

```solidity
/// @notice Error when array length is zero
error ZERO_ARRAY_LENGTH();
```

### INVALID_ORACLE_PROVIDER (inherited from ISuperOracle)

```solidity
/// @notice Error when oracle provider index is invalid
error INVALID_ORACLE_PROVIDER();
```

### NO_ORACLES_CONFIGURED (inherited from ISuperOracle)

```solidity
/// @notice Error when no oracles are configured for base asset
error NO_ORACLES_CONFIGURED();
```

### NO_VALID_REPORTED_PRICES (inherited from ISuperOracle)

```solidity
/// @notice Error when no valid reported prices are found
error NO_VALID_REPORTED_PRICES();
```

### ARRAY_LENGTH_MISMATCH (inherited from ISuperOracle)

```solidity
/// @notice Error when arrays have mismatched lengths
error ARRAY_LENGTH_MISMATCH();
```

### TIMELOCK_NOT_ELAPSED (inherited from ISuperOracle)

```solidity
/// @notice Error when timelock period has not elapsed
error TIMELOCK_NOT_ELAPSED();
```

### PENDING_UPDATE_EXISTS (inherited from ISuperOracle)

```solidity
/// @notice Error when there is already a pending update
error PENDING_UPDATE_EXISTS();
```

### ORACLE_UNTRUSTED_DATA (inherited from ISuperOracle)

```solidity
/// @notice Error when oracle data is untrusted
error ORACLE_UNTRUSTED_DATA();
```

### NO_PENDING_UPDATE (inherited from ISuperOracle)

```solidity
/// @notice Error when provider max staleness period is not set
error NO_PENDING_UPDATE();
```

### MAX_STALENESS_EXCEEDED (inherited from ISuperOracle)

```solidity
/// @notice Error when provider max staleness period is exceeded
error MAX_STALENESS_EXCEEDED();
```

### AVERAGE_PROVIDER_NOT_ALLOWED (inherited from ISuperOracle)

```solidity
/// @notice Error when average provider is not allowed
error AVERAGE_PROVIDER_NOT_ALLOWED();
```

### ZERO_PROVIDER (inherited from ISuperOracle)

```solidity
/// @notice Error when provider is zero
error ZERO_PROVIDER();
```

### TOO_MANY_PROVIDERS (inherited from ISuperOracle)

```solidity
/// @notice Error when too many providers are being iterated through
error TOO_MANY_PROVIDERS();
```

### UNAUTHORIZED_UPDATE_AUTHORITY (inherited from ISuperOracle)

```solidity
/// @notice Error when caller is not authorized to update
error UNAUTHORIZED_UPDATE_AUTHORITY();
```

### ORACLE_DECIMALS_CALL_FAIL (inherited from ISuperOracle)

```solidity
/// @notice Error when oracle decimals call fails
error ORACLE_DECIMALS_CALL_FAIL(address oracle);
```

### ORACLE_ROUND_DATA_CALL_FAIL (inherited from ISuperOracle)

```solidity
/// @notice Error when oracle round data call fails
error ORACLE_ROUND_DATA_CALL_FAIL(address oracle);
```

### INSUFFICIENT_GAS_FOR_EXTERNAL_CALL (inherited from ISuperOracle)

```solidity
/// @notice Error when external call gas is insufficient
error INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
```

### OracleUnsupportedPair (inherited from IOracle)

```solidity
/// @notice The oracle does not support the given base/quote pair.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUnsupportedPair(address base, address quote);
```

### OracleUntrustedData (inherited from IOracle)

```solidity
/// @notice The oracle is not capable to provide data within a degree of confidence.
///  @param base The asset that the user needs to know the value or price for.
///  @param quote The asset in which the user needs to value or price the base.
error OracleUntrustedData(address base, address quote);
```

### NO_UPTIME_FEED (inherited from ISuperOracleL2)

```solidity
/// @notice Error when no uptime feed is configured for the data oracle
error NO_UPTIME_FEED();
```

### SEQUENCER_DOWN (inherited from ISuperOracleL2)

```solidity
/// @notice Error when the L2 sequencer is down
error SEQUENCER_DOWN();
```

### GRACE_PERIOD_NOT_OVER (inherited from ISuperOracleL2)

```solidity
/// @notice Error when the grace period after sequencer restart is not over
error GRACE_PERIOD_NOT_OVER();
```

### GRACE_PERIOD_TOO_LOW (inherited from ISuperOracleL2)

```solidity
/// @notice Error when the grace period after sequencer restart is too low
error GRACE_PERIOD_TOO_LOW();
```

## Events

### OraclesConfigured (inherited from ISuperOracle)

```solidity
/// @notice Emitted when oracles are configured
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
event OraclesConfigured(address[] bases, address[] quotes, bytes32[] providers, address[] feeds);
```

### OracleUpdateQueued (inherited from ISuperOracle)

```solidity
/// @notice Emitted when oracle update is queued
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
///  @param timestamp Timestamp when update was queued
event OracleUpdateQueued(address[] bases, address[] quotes, bytes32[] providers, address[] feeds, uint256 timestamp);
```

### OracleUpdateExecuted (inherited from ISuperOracle)

```solidity
/// @notice Emitted when oracle update is executed
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
event OracleUpdateExecuted(address[] bases, address[] quotes, bytes32[] providers, address[] feeds);
```

### FeedMaxStalenessUpdated (inherited from ISuperOracle)

```solidity
/// @notice Emitted when provider max staleness period is updated
///  @param feed Feed address
///  @param newMaxStaleness New maximum staleness period in seconds
event FeedMaxStalenessUpdated(address feed, uint256 newMaxStaleness);
```

### MaxStalenessUpdated (inherited from ISuperOracle)

```solidity
/// @notice Emitted when max staleness period is updated
///  @param newMaxStaleness New maximum staleness period in seconds
event MaxStalenessUpdated(uint256 newMaxStaleness);
```

### ProviderRemovalQueued (inherited from ISuperOracle)

```solidity
/// @notice Emitted when provider removal is queued
///  @param providers Array of provider ids to remove
///  @param timestamp Timestamp when removal was queued
event ProviderRemovalQueued(bytes32[] providers, uint256 timestamp);
```

### ProviderRemovalExecuted (inherited from ISuperOracle)

```solidity
/// @notice Emitted when provider removal is executed
///  @param providers Array of provider ids that were removed
event ProviderRemovalExecuted(bytes32[] providers);
```

### ProviderRemovalCancelled (inherited from ISuperOracle)

```solidity
/// @notice Emitted when provider removal is cancelled
///  @param providers Array of provider ids that were queued for removal
event ProviderRemovalCancelled(bytes32[] providers);
```

### UptimeFeedSet (inherited from ISuperOracleL2)

```solidity
/// @notice Emitted when an uptime feed is set for a data oracle
///  @param dataOracle The data oracle address
///  @param uptimeOracle The uptime feed address
event UptimeFeedSet(address dataOracle, address uptimeOracle);
```

### GracePeriodSet (inherited from ISuperOracleL2)

```solidity
/// @notice Emitted when a grace period is set for an uptime oracle
///  @param uptimeOracle The uptime oracle address
///  @param gracePeriod The grace period in seconds
event GracePeriodSet(address uptimeOracle, uint256 gracePeriod);
```

## Public/External Functions

### constructor(address,address[],address[],bytes32[],address[])

- **Signature**: `constructor(address,address[],address[],bytes32[],address[])`
- **Visibility**: public
- **Source Range**: 1558:263:536
- **Details**: [function_constructor_address_address[]_address[]_bytes32[]_address[].md](./function_constructor_address_address[]_address[]_bytes32[]_address[].md)

**Signature:**
```solidity
constructor(address superGovernor_, address[] memory bases, address[] memory quotes, bytes32[] memory providers, address[] memory feeds) SuperOracleBase(superGovernor_,bases,quotes,providers,feeds);
```

### batchSetUptimeFeed(address[],address[],uint256[])

- **Signature**: `batchSetUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 2047:1152:536
- **Details**: [function_batchSetUptimeFeed_address[]_address[]_uint256[].md](./function_batchSetUptimeFeed_address[]_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracleL2
function batchSetUptimeFeed(address[] calldata dataOracles, address[] calldata uptimeOracles, uint256[] calldata gracePeriods_) override external;
```

### setDefaultStaleness(uint256) (inherited from SuperOracleBase)

- **Signature**: `setDefaultStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 4654:247:535
- **Details**: [function_setDefaultStaleness_uint256.md](./function_setDefaultStaleness_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function setDefaultStaleness(uint256 newMaxStaleness) external;
```

### setFeedMaxStaleness(address,uint256) (inherited from SuperOracleBase)

- **Signature**: `setFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 4940:219:535
- **Details**: [function_setFeedMaxStaleness_address_uint256.md](./function_setFeedMaxStaleness_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function setFeedMaxStaleness(address feed, uint256 newMaxStaleness) external;
```

### setFeedMaxStalenessBatch(address[],uint256[]) (inherited from SuperOracleBase)

- **Signature**: `setFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 5198:518:535
- **Details**: [function_setFeedMaxStalenessBatch_address[]_uint256[].md](./function_setFeedMaxStalenessBatch_address[]_uint256[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function setFeedMaxStalenessBatch(address[] calldata feeds, uint256[] calldata newMaxStalenessList) external;
```

### queueOracleUpdate(address[],address[],bytes32[],address[]) (inherited from SuperOracleBase)

- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 5755:779:535
- **Details**: [function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md](./function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external;
```

### executeOracleUpdate() (inherited from SuperOracleBase)

- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 6573:598:535
- **Details**: [function_executeOracleUpdate.md](./function_executeOracleUpdate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function executeOracleUpdate() external;
```

### getOracleAddress(address,address,bytes32) (inherited from SuperOracleBase)

- **Signature**: `getOracleAddress(address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 7210:306:535
- **Details**: [function_getOracleAddress_address_address_bytes32.md](./function_getOracleAddress_address_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function getOracleAddress(address base, address quote, bytes32 provider) external view returns (address oracle);
```

### queueProviderRemoval(bytes32[]) (inherited from SuperOracleBase)

- **Signature**: `queueProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 7555:565:535
- **Details**: [function_queueProviderRemoval_bytes32[].md](./function_queueProviderRemoval_bytes32[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function queueProviderRemoval(bytes32[] calldata providers) external;
```

### executeProviderRemoval() (inherited from SuperOracleBase)

- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 8159:1307:535
- **Details**: [function_executeProviderRemoval.md](./function_executeProviderRemoval.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function executeProviderRemoval() external;
```

### cancelProviderRemoval() (inherited from SuperOracleBase)

- **Signature**: `cancelProviderRemoval()`
- **Visibility**: external
- **Source Range**: 9505:368:535
- **Details**: [function_cancelProviderRemoval.md](./function_cancelProviderRemoval.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function cancelProviderRemoval() external;
```

### getActiveProviders() (inherited from SuperOracleBase)

- **Signature**: `getActiveProviders()`
- **Visibility**: external
- **Source Range**: 9912:110:535
- **Details**: [function_getActiveProviders.md](./function_getActiveProviders.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function getActiveProviders() external view returns (bytes32[] memory);
```

### getQuoteFromProvider(uint256,address,address,bytes32) (inherited from SuperOracleBase)

- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: public
- **Source Range**: 10247:1303:535
- **Details**: [function_getQuoteFromProvider_uint256_address_address_bytes32.md](./function_getQuoteFromProvider_uint256_address_address_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperOracle
function getQuoteFromProvider(uint256 baseAmount, address base, address quote, bytes32 oracleProvider) virtual public view returns (uint256 quoteAmount, uint256 deviation, uint256 totalProviders, uint256 availableProviders);
```

### getQuote(uint256,address,address) (inherited from SuperOracleBase)

- **Signature**: `getQuote(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 11584:353:535
- **Details**: [function_getQuote_uint256_address_address.md](./function_getQuote_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IOracle
function getQuote(uint256 baseAmount, address base, address quote) virtual external view returns (uint256 quoteAmount);
```
