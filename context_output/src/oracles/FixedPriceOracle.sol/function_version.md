# Function: version()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 3890:82:533

## Implementation

```solidity
/// @notice Returns the version of this oracle
///  @return The version number
function version() external pure returns (uint256) {
    return VERSION;
}
```

## State Variable Reads

- **VERSION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.version() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the version of this oracle
 @return The version number
