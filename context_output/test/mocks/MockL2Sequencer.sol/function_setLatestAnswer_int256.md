# Function: setLatestAnswer(int256)

**Contract**: [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]

## Metadata

- **Contract**: MockL2Sequencer
- **Signature**: `setLatestAnswer(int256)`
- **Visibility**: external
- **Source Range**: 427:82:596

## Implementation

```solidity
function setLatestAnswer(int256 answer) external {
    _answer = answer;
}
```

## State Variable Writes

- **_answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockL2Sequencer.setLatestAnswer(int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
