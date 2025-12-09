# Function: getRoundData(uint80)

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `getRoundData(uint80)`
- **Visibility**: external
- **Source Range**: 922:242:586

## Implementation

```solidity
function getRoundData(uint80) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    return (1, _answer, block.timestamp, _updatedAt, 1);
}
```

## State Variable Reads

- **_answer** (`int256`)
- **_updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregator.getRoundData(uint80) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
