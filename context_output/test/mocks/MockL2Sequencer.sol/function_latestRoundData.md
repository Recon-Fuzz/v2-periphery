# Function: latestRoundData()

**Contract**: [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]

## Metadata

- **Contract**: MockL2Sequencer
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 610:160:596

## Implementation

```solidity
function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80) {
    return (0, _answer, _startedAt, block.timestamp, 0);
}
```

## State Variable Reads

- **_answer** (`int256`)
- **_startedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockL2Sequencer.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
