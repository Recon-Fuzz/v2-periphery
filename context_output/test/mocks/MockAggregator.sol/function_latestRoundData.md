# Function: latestRoundData()

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 1170:239:586

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    return (1, _answer, block.timestamp, _updatedAt, 1);
}
```

## State Variable Reads

- **_answer** (`int256`)
- **_updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregator.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
