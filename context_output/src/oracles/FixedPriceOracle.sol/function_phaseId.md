# Function: phaseId()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `phaseId()`
- **Visibility**: external
- **Source Range**: 6171:75:533

## Implementation

```solidity
/// @notice Returns the current phase ID
///  @return Always returns 1
function phaseId() external pure returns (uint16) {
    return 1;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.phaseId() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the current phase ID
 @return Always returns 1
