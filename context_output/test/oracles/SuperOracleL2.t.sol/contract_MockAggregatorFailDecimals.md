# Contract: MockAggregatorFailDecimals

## Metadata

- **Name**: MockAggregatorFailDecimals
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol
- **Documentation**: @notice Mock aggregator that reverts on decimals() call to test catch block

## State Variables

### answer

```solidity
int256 private answer
```

### updatedAt

```solidity
uint256 private updatedAt
```

## Public/External Functions

### constructor(int256)

- **Signature**: `constructor(int256)`
- **Visibility**: public
- **Source Range**: 79365:98:625
- **Details**: [function_constructor_int256.md](./function_constructor_int256.md)

**Signature:**
```solidity
constructor(int256 answer_);
```

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 79469:239:625
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer_, uint256 startedAt, uint256 updatedAt_, uint80 answeredInRound);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 79714:97:625
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```

### setUpdatedAt(uint256)

- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 79817:88:625
- **Details**: [function_setUpdatedAt_uint256.md](./function_setUpdatedAt_uint256.md)

**Signature:**
```solidity
function setUpdatedAt(uint256 timestamp) external;
```

### setAnswer(int256)

- **Signature**: `setAnswer(int256)`
- **Visibility**: external
- **Source Range**: 79911:77:625
- **Details**: [function_setAnswer_int256.md](./function_setAnswer_int256.md)

**Signature:**
```solidity
function setAnswer(int256 answer_) external;
```
