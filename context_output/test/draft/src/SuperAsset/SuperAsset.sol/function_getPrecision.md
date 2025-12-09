# Function: getPrecision()

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `getPrecision()`
- **Visibility**: external
- **Source Range**: 28071:89:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function getPrecision() external pure returns (uint256) {
    return PRECISION;
}
```

## State Variable Reads

- **PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.getPrecision() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Gets the precision constant used for percentage calculations
 @return The precision constant (e.g., 10000 for 4 decimal places)
