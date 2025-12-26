# Interface: ISuperOracle

## Metadata

- **Name**: ISuperOracle
- **Type**: Interface
- **Path**: src/interfaces/oracles/ISuperOracle.sol
- **Documentation**: @title ISuperOracle
   @author Superform Labs
   @notice Interface for SuperOracle

## Structs

### PendingUpdate

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

### PendingRemoval

```solidity
/// @notice Struct for pending provider removal
struct PendingRemoval {
    bytes32[] providers;
    uint256 timestamp;
}
```

## Errors

### ZERO_ADDRESS

```solidity
/// @notice Error when address is zero
error ZERO_ADDRESS();
```

### ZERO_ARRAY_LENGTH

```solidity
/// @notice Error when array length is zero
error ZERO_ARRAY_LENGTH();
```

### INVALID_ORACLE_PROVIDER

```solidity
/// @notice Error when oracle provider index is invalid
error INVALID_ORACLE_PROVIDER();
```

### NO_ORACLES_CONFIGURED

```solidity
/// @notice Error when no oracles are configured for base asset
error NO_ORACLES_CONFIGURED();
```

### NO_VALID_REPORTED_PRICES

```solidity
/// @notice Error when no valid reported prices are found
error NO_VALID_REPORTED_PRICES();
```

### ARRAY_LENGTH_MISMATCH

```solidity
/// @notice Error when arrays have mismatched lengths
error ARRAY_LENGTH_MISMATCH();
```

### TIMELOCK_NOT_ELAPSED

```solidity
/// @notice Error when timelock period has not elapsed
error TIMELOCK_NOT_ELAPSED();
```

### PENDING_UPDATE_EXISTS

```solidity
/// @notice Error when there is already a pending update
error PENDING_UPDATE_EXISTS();
```

### ORACLE_UNTRUSTED_DATA

```solidity
/// @notice Error when oracle data is untrusted
error ORACLE_UNTRUSTED_DATA();
```

### NO_PENDING_UPDATE

```solidity
/// @notice Error when provider max staleness period is not set
error NO_PENDING_UPDATE();
```

### MAX_STALENESS_EXCEEDED

```solidity
/// @notice Error when provider max staleness period is exceeded
error MAX_STALENESS_EXCEEDED();
```

### AVERAGE_PROVIDER_NOT_ALLOWED

```solidity
/// @notice Error when average provider is not allowed
error AVERAGE_PROVIDER_NOT_ALLOWED();
```

### ZERO_PROVIDER

```solidity
/// @notice Error when provider is zero
error ZERO_PROVIDER();
```

### TOO_MANY_PROVIDERS

```solidity
/// @notice Error when too many providers are being iterated through
error TOO_MANY_PROVIDERS();
```

### UNAUTHORIZED_UPDATE_AUTHORITY

```solidity
/// @notice Error when caller is not authorized to update
error UNAUTHORIZED_UPDATE_AUTHORITY();
```

### ORACLE_DECIMALS_CALL_FAIL

```solidity
/// @notice Error when oracle decimals call fails
error ORACLE_DECIMALS_CALL_FAIL(address oracle);
```

### ORACLE_ROUND_DATA_CALL_FAIL

```solidity
/// @notice Error when oracle round data call fails
error ORACLE_ROUND_DATA_CALL_FAIL(address oracle);
```

### INSUFFICIENT_GAS_FOR_EXTERNAL_CALL

```solidity
/// @notice Error when external call gas is insufficient
error INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
```

## Events

### OraclesConfigured

```solidity
/// @notice Emitted when oracles are configured
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
event OraclesConfigured(address[] bases, address[] quotes, bytes32[] providers, address[] feeds);
```

### OracleUpdateQueued

```solidity
/// @notice Emitted when oracle update is queued
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
///  @param timestamp Timestamp when update was queued
event OracleUpdateQueued(address[] bases, address[] quotes, bytes32[] providers, address[] feeds, uint256 timestamp);
```

### OracleUpdateExecuted

```solidity
/// @notice Emitted when oracle update is executed
///  @param bases Array of base assets
///  @param quotes Array of quote assets
///  @param providers Array of provider indexes
///  @param feeds Array of oracle addresses
event OracleUpdateExecuted(address[] bases, address[] quotes, bytes32[] providers, address[] feeds);
```

### FeedMaxStalenessUpdated

```solidity
/// @notice Emitted when provider max staleness period is updated
///  @param feed Feed address
///  @param newMaxStaleness New maximum staleness period in seconds
event FeedMaxStalenessUpdated(address feed, uint256 newMaxStaleness);
```

### MaxStalenessUpdated

```solidity
/// @notice Emitted when max staleness period is updated
///  @param newMaxStaleness New maximum staleness period in seconds
event MaxStalenessUpdated(uint256 newMaxStaleness);
```

### ProviderRemovalQueued

```solidity
/// @notice Emitted when provider removal is queued
///  @param providers Array of provider ids to remove
///  @param timestamp Timestamp when removal was queued
event ProviderRemovalQueued(bytes32[] providers, uint256 timestamp);
```

### ProviderRemovalExecuted

```solidity
/// @notice Emitted when provider removal is executed
///  @param providers Array of provider ids that were removed
event ProviderRemovalExecuted(bytes32[] providers);
```

### ProviderRemovalCancelled

```solidity
/// @notice Emitted when provider removal is cancelled
///  @param providers Array of provider ids that were queued for removal
event ProviderRemovalCancelled(bytes32[] providers);
```

## Public/External Functions

### getOracleAddress(address,address,bytes32)

- **Signature**: `getOracleAddress(address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 5397:112:524

**Signature:**
```solidity
/// @notice Get oracle address for a base asset and provider
///  @param base Base asset address
///  @param quote Quote asset address
///  @param provider Provider id
///  @return oracle Oracle address
function getOracleAddress(address base, address quote, bytes32 provider) external view returns (address oracle);;
```

### getQuoteFromProvider(uint256,address,address,bytes32)

- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 6107:280:524

**Signature:**
```solidity
/// @notice Get quote from specified oracle provider
///  @param baseAmount Amount of base asset
///  @param base Base asset address
///  @param quote Quote asset address
///  @param oracleProvider Id of oracle provider to use
///  @return quoteAmount The quote amount
///  @return deviation Standard deviation of oracle quotes in quote asset units (0 for single provider)
///  @return totalProviders Total number of providers that have a configured oracle for this pair
///  @return availableProviders Number of providers that successfully returned a valid quote
function getQuoteFromProvider(uint256 baseAmount, address base, address quote, bytes32 oracleProvider) external view returns (uint256 quoteAmount, uint256 deviation, uint256 totalProviders, uint256 availableProviders);;
```

### queueOracleUpdate(address[],address[],bytes32[],address[])

- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 6622:191:524

**Signature:**
```solidity
/// @notice Queue oracle update for timelock
///  @param bases Array of base assets
///  @param providers Array of provider ids
///  @param quotes Array of quote assets
///  @param feeds Array of oracle addresses
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external;;
```

### executeOracleUpdate()

- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 6886:40:524

**Signature:**
```solidity
/// @notice Execute queued oracle update after timelock period
function executeOracleUpdate() external;;
```

### queueProviderRemoval(bytes32[])

- **Signature**: `queueProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 7041:69:524

**Signature:**
```solidity
/// @notice Queue provider removal for timelock
///  @param providers Array of provider ids to remove
function queueProviderRemoval(bytes32[] calldata providers) external;;
```

### executeProviderRemoval()

- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 7186:43:524

**Signature:**
```solidity
/// @notice Execute queued provider removal after timelock period
function executeProviderRemoval() external;;
```

### cancelProviderRemoval()

- **Signature**: `cancelProviderRemoval()`
- **Visibility**: external
- **Source Range**: 7282:42:524

**Signature:**
```solidity
/// @notice Cancel queued provider removal
function cancelProviderRemoval() external;;
```

### setFeedMaxStaleness(address,uint256)

- **Signature**: `setFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 7507:77:524

**Signature:**
```solidity
/// @notice Set the maximum staleness period for a specific provider
///  @param feed Feed address
///  @param newMaxStaleness New maximum staleness period in seconds
function setFeedMaxStaleness(address feed, uint256 newMaxStaleness) external;;
```

### setDefaultStaleness(uint256)

- **Signature**: `setDefaultStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 7728:63:524

**Signature:**
```solidity
/// @notice Set the maximum staleness period for all providers
///  @param newMaxStaleness New maximum staleness period in seconds
function setDefaultStaleness(uint256 newMaxStaleness) external;;
```

### setFeedMaxStalenessBatch(address[],uint256[])

- **Signature**: `setFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 7999:109:524

**Signature:**
```solidity
/// @notice Set the maximum staleness period for multiple providers
///  @param feeds Array of feed addresses
///  @param newMaxStalenessList Array of new maximum staleness periods in seconds
function setFeedMaxStalenessBatch(address[] calldata feeds, uint256[] calldata newMaxStalenessList) external;;
```

### getActiveProviders()

- **Signature**: `getActiveProviders()`
- **Visibility**: external
- **Source Range**: 8203:71:524

**Signature:**
```solidity
/// @notice Get all active provider ids
///  @return Array of active provider ids
function getActiveProviders() external view returns (bytes32[] memory);;
```
