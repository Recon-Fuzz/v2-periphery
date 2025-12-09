# Function: setUpdatedAt(uint256)

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_MockAggregatorGasConsumerOnDecimals.md]

## Metadata

- **Contract**: MockAggregatorGasConsumerOnDecimals
- **Signature**: `setUpdatedAt(uint256)`
- **Visibility**: external
- **Source Range**: 82571:88:625

## Implementation

```solidity
function setUpdatedAt(uint256 timestamp) external {
    updatedAt = timestamp;
}
```

## State Variable Writes

- **updatedAt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregatorGasConsumerOnDecimals.setUpdatedAt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
