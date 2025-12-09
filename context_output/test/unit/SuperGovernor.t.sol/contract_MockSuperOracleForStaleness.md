# Contract: MockSuperOracleForStaleness

## Metadata

- **Name**: MockSuperOracleForStaleness
- **Type**: Contract
- **Path**: test/unit/SuperGovernor.t.sol
- **Documentation**: @notice Mock SuperOracle contract that implements the staleness functions for testing

## State Variables

### lastMaxStaleness

```solidity
uint256 public lastMaxStaleness
```

### lastFeed

```solidity
address public lastFeed
```

### lastFeedStaleness

```solidity
uint256 public lastFeedStaleness
```

### batchCalled

```solidity
bool public batchCalled
```

### lastBases

```solidity
address[] public lastBases
```

### lastQuotes

```solidity
address[] public lastQuotes
```

### lastProviders

```solidity
bytes32[] public lastProviders
```

### lastFeeds

```solidity
address[] public lastFeeds
```

### oracleUpdateQueued

```solidity
bool public oracleUpdateQueued
```

### oracleUpdateExecuted

```solidity
bool public oracleUpdateExecuted
```

### providerRemovalExecuted

```solidity
bool public providerRemovalExecuted
```

## Public/External Functions

### setDefaultStaleness(uint256)

- **Signature**: `setDefaultStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 133804:114:659
- **Details**: [function_setDefaultStaleness_uint256.md](./function_setDefaultStaleness_uint256.md)

**Signature:**
```solidity
function setDefaultStaleness(uint256 newMaxStaleness) external;
```

### setFeedMaxStaleness(address,uint256)

- **Signature**: `setFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 133924:154:659
- **Details**: [function_setFeedMaxStaleness_address_uint256.md](./function_setFeedMaxStaleness_address_uint256.md)

**Signature:**
```solidity
function setFeedMaxStaleness(address feed, uint256 newMaxStaleness) external;
```

### setFeedMaxStalenessBatch(address[],uint256[])

- **Signature**: `setFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 134084:118:659
- **Details**: [function_setFeedMaxStalenessBatch_address[]_uint256[].md](./function_setFeedMaxStalenessBatch_address[]_uint256[].md)

**Signature:**
```solidity
function setFeedMaxStalenessBatch(address[] calldata, uint256[] calldata) external;
```

### queueOracleUpdate(address[],address[],bytes32[],address[])

- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 134208:355:659
- **Details**: [function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md](./function_queueOracleUpdate_address[]_address[]_bytes32[]_address[].md)

**Signature:**
```solidity
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external;
```

### executeOracleUpdate()

- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 134569:84:659
- **Details**: [function_executeOracleUpdate.md](./function_executeOracleUpdate.md)

**Signature:**
```solidity
function executeOracleUpdate() external;
```

### executeProviderRemoval()

- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 134659:90:659
- **Details**: [function_executeProviderRemoval.md](./function_executeProviderRemoval.md)

**Signature:**
```solidity
function executeProviderRemoval() external;
```

### getLastBasesLength()

- **Signature**: `getLastBasesLength()`
- **Visibility**: external
- **Source Range**: 134791:102:659
- **Details**: [function_getLastBasesLength.md](./function_getLastBasesLength.md)

**Signature:**
```solidity
function getLastBasesLength() external view returns (uint256);
```

### getLastQuotesLength()

- **Signature**: `getLastQuotesLength()`
- **Visibility**: external
- **Source Range**: 134899:104:659
- **Details**: [function_getLastQuotesLength.md](./function_getLastQuotesLength.md)

**Signature:**
```solidity
function getLastQuotesLength() external view returns (uint256);
```

### getLastProvidersLength()

- **Signature**: `getLastProvidersLength()`
- **Visibility**: external
- **Source Range**: 135009:110:659
- **Details**: [function_getLastProvidersLength.md](./function_getLastProvidersLength.md)

**Signature:**
```solidity
function getLastProvidersLength() external view returns (uint256);
```

### getLastFeedsLength()

- **Signature**: `getLastFeedsLength()`
- **Visibility**: external
- **Source Range**: 135125:102:659
- **Details**: [function_getLastFeedsLength.md](./function_getLastFeedsLength.md)

**Signature:**
```solidity
function getLastFeedsLength() external view returns (uint256);
```

### getLastBase(uint256)

- **Signature**: `getLastBase(uint256)`
- **Visibility**: external
- **Source Range**: 135233:108:659
- **Details**: [function_getLastBase_uint256.md](./function_getLastBase_uint256.md)

**Signature:**
```solidity
function getLastBase(uint256 index) external view returns (address);
```

### getLastQuote(uint256)

- **Signature**: `getLastQuote(uint256)`
- **Visibility**: external
- **Source Range**: 135347:110:659
- **Details**: [function_getLastQuote_uint256.md](./function_getLastQuote_uint256.md)

**Signature:**
```solidity
function getLastQuote(uint256 index) external view returns (address);
```

### getLastProvider(uint256)

- **Signature**: `getLastProvider(uint256)`
- **Visibility**: external
- **Source Range**: 135463:116:659
- **Details**: [function_getLastProvider_uint256.md](./function_getLastProvider_uint256.md)

**Signature:**
```solidity
function getLastProvider(uint256 index) external view returns (bytes32);
```

### getLastFeed(uint256)

- **Signature**: `getLastFeed(uint256)`
- **Visibility**: external
- **Source Range**: 135585:108:659
- **Details**: [function_getLastFeed_uint256.md](./function_getLastFeed_uint256.md)

**Signature:**
```solidity
function getLastFeed(uint256 index) external view returns (address);
```

### getQuoteFromProvider(uint256,address,address,bytes32)

- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 135787:296:659
- **Details**: [function_getQuoteFromProvider_uint256_address_address_bytes32.md](./function_getQuoteFromProvider_uint256_address_address_bytes32.md)

**Signature:**
```solidity
/// @notice Mock implementation of getQuoteFromProvider for _convertGasToUp testing
function getQuoteFromProvider(uint256 amount, address, address, bytes32) external pure returns (uint256, uint256, uint256, uint256);
```
