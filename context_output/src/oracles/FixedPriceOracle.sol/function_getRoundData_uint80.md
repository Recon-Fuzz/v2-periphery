# Function: getRoundData(uint80)

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `getRoundData(uint80)`
- **Visibility**: external
- **Source Range**: 4458:270:533

## Implementation

```solidity
/// @notice Returns data for a specific round
///  @dev Always returns the current fixed price with current timestamp
///  @param _roundId The round ID (ignored, always returns current data)
///  @return roundId The round ID (always 1)
///  @return answer The fixed price
///  @return startedAt The current block timestamp
///  @return updatedAt The current block timestamp (prevents staleness issues)
///  @return answeredInRound The round ID (always 1)
function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
    return (_roundId, _answer, block.timestamp, block.timestamp, _roundId);
}
```

## State Variable Reads

- **_answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.getRoundData(uint80) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns data for a specific round
 @dev Always returns the current fixed price with current timestamp
 @param _roundId The round ID (ignored, always returns current data)
 @return roundId The round ID (always 1)
 @return answer The fixed price
 @return startedAt The current block timestamp
 @return updatedAt The current block timestamp (prevents staleness issues)
 @return answeredInRound The round ID (always 1)
