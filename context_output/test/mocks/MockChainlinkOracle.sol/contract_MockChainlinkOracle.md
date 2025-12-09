# Contract: MockChainlinkOracle

## Metadata

- **Name**: MockChainlinkOracle
- **Type**: Contract
- **Path**: test/mocks/MockChainlinkOracle.sol

## Public/External Functions

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 99:324:588
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 429:75:588
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```
