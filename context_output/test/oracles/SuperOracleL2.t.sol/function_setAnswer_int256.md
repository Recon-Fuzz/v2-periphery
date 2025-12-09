# Function: setAnswer(int256)

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_MockAggregatorGasConsumerOnDecimals.md]

## Metadata

- **Contract**: MockAggregatorGasConsumerOnDecimals
- **Signature**: `setAnswer(int256)`
- **Visibility**: external
- **Source Range**: 82665:77:625

## Implementation

```solidity
function setAnswer(int256 answer_) external {
    answer = answer_;
}
```

## State Variable Writes

- **answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregatorGasConsumerOnDecimals.setAnswer(int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
