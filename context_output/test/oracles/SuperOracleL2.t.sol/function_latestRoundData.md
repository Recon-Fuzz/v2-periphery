# Function: latestRoundData()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_MockAggregatorGasConsumerOnDecimals.md]

## Metadata

- **Contract**: MockAggregatorGasConsumerOnDecimals
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 81866:239:625

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer_, uint256 startedAt, uint256 updatedAt_, uint80 answeredInRound) {
    return (0, answer, block.timestamp, updatedAt, 0);
}
```

## State Variable Reads

- **answer** (`int256`)
- **updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregatorGasConsumerOnDecimals.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
