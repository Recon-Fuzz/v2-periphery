# Contract: MockAggregatorRevertingLatestRoundData

## Metadata

- **Name**: MockAggregatorRevertingLatestRoundData
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol
- **Documentation**: @notice Mock aggregator that reverts on latestRoundData() call

## Public/External Functions

### latestRoundData()

- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 78677:140:625
- **Details**: [function_latestRoundData.md](./function_latestRoundData.md)

**Signature:**
```solidity
function latestRoundData() external pure returns (uint80, int256, uint256, uint256, uint80);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 78823:75:625
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() external pure returns (uint8);
```
