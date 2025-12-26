# Function: latestRoundData()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `latestRoundData()`
- **Visibility**: external
- **Source Range**: 5143:244:533

## Implementation

```solidity
/// @notice Returns the latest round data
///  @dev Always returns block.timestamp for updatedAt to avoid staleness issues
///  @return roundId The round ID (always 1)
///  @return answer The fixed price
///  @return startedAt The current block timestamp
///  @return updatedAt The current block timestamp (prevents staleness issues)
///  @return answeredInRound The round ID (always 1)
function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    return (1, _answer, block.timestamp, block.timestamp, 1);
}
```

## State Variable Reads

- **_answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.latestRoundData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the latest round data
 @dev Always returns block.timestamp for updatedAt to avoid staleness issues
 @return roundId The round ID (always 1)
 @return answer The fixed price
 @return startedAt The current block timestamp
 @return updatedAt The current block timestamp (prevents staleness issues)
 @return answeredInRound The round ID (always 1)
