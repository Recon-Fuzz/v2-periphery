# Function: constructor(int256)

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_MockAggregatorGasConsumerOnDecimals.md]

## Metadata

- **Contract**: MockAggregatorGasConsumerOnDecimals
- **Signature**: `constructor(int256)`
- **Visibility**: public
- **Source Range**: 81762:98:625

## Implementation

```solidity
constructor(int256 answer_) {
    answer = answer_;
    updatedAt = block.timestamp;
}
```

## State Variable Writes

- **answer** (`int256`)
- **updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockAggregatorGasConsumerOnDecimals.constructor(int256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockAggregatorGasConsumerOnDecimals
```
