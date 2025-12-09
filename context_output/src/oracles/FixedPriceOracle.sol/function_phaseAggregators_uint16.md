# Function: phaseAggregators(uint16)

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `phaseAggregators(uint16)`
- **Visibility**: external
- **Source Range**: 6452:158:533

## Implementation

```solidity
/// @notice Returns the aggregator for a phase
///  @dev Returns this contract's address for phase 1, zero otherwise
///  @param _phaseId The phase ID
///  @return The aggregator address
function phaseAggregators(uint16 _phaseId) external view returns (address) {
    if (_phaseId == 1) return address(this);
    return address(0);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.phaseAggregators(uint16) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the aggregator for a phase
 @dev Returns this contract's address for phase 1, zero otherwise
 @param _phaseId The phase ID
 @return The aggregator address
