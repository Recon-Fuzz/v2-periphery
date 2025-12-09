# Function: decimals()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 3519:83:533

## Implementation

```solidity
/// @notice Returns the number of decimals
///  @return The decimals value
function decimals() external view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the number of decimals
 @return The decimals value
