# Contract: MockAggregatorGasConsumerOnLatestRoundData

## Metadata

- **Name**: MockAggregatorGasConsumerOnLatestRoundData
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol
- **Documentation**: @notice Mock aggregator that consumes most gas on latestRoundData before reverting

## Public/External Functions

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 80986:499:625
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 81491:75:625
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```
