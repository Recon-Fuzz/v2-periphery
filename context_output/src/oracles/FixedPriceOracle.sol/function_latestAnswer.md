# Function: latestAnswer()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `latestAnswer()`
- **Visibility**: external
- **Source Range**: 5478:237:533

## Implementation

```solidity
/// @notice Returns the latest answer
///  @return The fixed price as uint256
function latestAnswer() external view returns (uint256) {
    return uint256(_answer);
}
```

## State Variable Reads

- **_answer** (`int256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.latestAnswer() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the latest answer
 @return The fixed price as uint256
