# Contract: MockAggregator

## Metadata

- **Name**: MockAggregator
- **Type**: Contract
- **Path**: test/mocks/MockAggregator.sol

## Implements Interfaces

- **AggregatorV3Interface** [src/vendor/chainlink/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## State Variables

### _answer

```solidity
int256 private _answer
```

### _updatedAt

```solidity
uint256 private _updatedAt
```

### _decimals

```solidity
uint8 private immutable _decimals
```

## Public/External Functions

### constructor(int256,uint8)

- **Signature**: `constructor(int256,uint8)`
- **Visibility**: public
- **Source Range**: 308:148:586
- **Details**: [function_constructor_int256_uint8.md](./function_constructor_int256_uint8.md)

**Signature:**
```solidity
constructor(int256 answer_, uint8 decimals_);
```

### setAnswer(int256)

- **Signature**: `setAnswer(int256)`
- **Visibility**: external
- **Source Range**: 462:78:586
- **Details**: [function_setAnswer_int256.md](./function_setAnswer_int256.md)

**Signature:**
```solidity
function setAnswer(int256 answer_) external;
```

### setUpdatedAt(uint256)

- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 546:91:586
- **Details**: [function_setUpdatedAt_uint256.md](./function_setUpdatedAt_uint256.md)

**Signature:**
```solidity
function setUpdatedAt(uint256 updatedAt_) external;
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 643:83:586
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external view returns (uint8);
```

### description()

- **Signature**: `description()`
- **Visibility**: external
- **Source Range**: 732:102:586
- **Details**: [function_description.md](./function_description.md)

**Signature:**
```solidity
function description() external pure returns (string memory);
```

### version()

- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 840:76:586
- **Details**: [function_version.md](./function_version.md)

**Signature:**
```solidity
function version() external pure returns (uint256);
```

### getRoundData(uint80)

- **Signature**: `getRoundData(uint80)`
- **Visibility**: external
- **Source Range**: 922:242:586
- **Details**: [function_getRoundData_uint80.md](./function_getRoundData_uint80.md)

**Signature:**
```solidity
function getRoundData(uint80) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 1170:239:586
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```
