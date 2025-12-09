# Function: setAnswer(int256)

**Contract**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Metadata

- **Contract**: MockAggregator
- **Signature**: `setAnswer(int256)`
- **Visibility**: external
- **Source Range**: 462:78:586

## Implementation

```solidity
function setAnswer(int256 answer_) external {
    _answer = answer_;
}
```

## State Variable Writes

- **_answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregator.setAnswer(int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
