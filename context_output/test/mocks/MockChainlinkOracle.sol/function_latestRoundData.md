# Function: latestRoundData()

**Contract**: [test/mocks/MockChainlinkOracle.sol/contract_MockChainlinkOracle.md]

## Metadata

- **Contract**: MockChainlinkOracle
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 99:324:588

## Implementation

```solidity
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    roundId = 1;
    answer = 1e8;
    startedAt = block.timestamp;
    updatedAt = block.timestamp;
    answeredInRound = 1;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockChainlinkOracle.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
