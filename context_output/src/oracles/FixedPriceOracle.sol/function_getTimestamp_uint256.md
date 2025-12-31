# Function: getTimestamp(uint256)

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `getTimestamp(uint256)`
- **Visibility**: external
- **Source Range**: 5914:173:533

## Implementation

```solidity
/// @notice Returns the timestamp for a round
///  @dev Always returns current block timestamp
///  @param _roundId The round ID (ignored)
///  @return The current block timestamp
function getTimestamp(uint256 _roundId) external view returns (uint256) {
    _roundId;
    return block.timestamp;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.getTimestamp(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the timestamp for a round
 @dev Always returns current block timestamp
 @param _roundId The round ID (ignored)
 @return The current block timestamp
