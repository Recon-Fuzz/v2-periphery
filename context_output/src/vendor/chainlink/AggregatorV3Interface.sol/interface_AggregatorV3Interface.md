# Interface: AggregatorV3Interface

## Metadata

- **Name**: AggregatorV3Interface
- **Type**: Interface
- **Path**: src/vendor/chainlink/AggregatorV3Interface.sol

## Public/External Functions

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 102:50:539

**Signature:**
```solidity
function decimals() external view returns (uint8);;
```

### description()

- **Signature**: `description()`
- **Visibility**: external
- **Source Range**: 158:61:539

**Signature:**
```solidity
function description() external view returns (string memory);;
```

### version()

- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 225:51:539

**Signature:**
```solidity
function version() external view returns (uint256);;
```

### getRoundData(uint80)

- **Signature**: `getRoundData(uint80)`
- **Visibility**: external
- **Source Range**: 282:179:539

**Signature:**
```solidity
function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);;
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 467:167:539

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);;
```
