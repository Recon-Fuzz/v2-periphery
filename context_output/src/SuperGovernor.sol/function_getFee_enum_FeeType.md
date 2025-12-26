# Function: getFee(enum FeeType)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getFee(enum FeeType)`
- **Visibility**: external
- **Source Range**: 30939:112:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getFee(FeeType feeType) external view returns (uint256) {
    return _feeData[feeType].value;
}
```

## State Variable Reads

- **_feeData** (`mapping(enum FeeType => struct SuperGovernor.FeeData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getFee(enum FeeType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the current fee value for a specific fee type
 @param feeType The type of fee to get
 @return The current fee value (in basis points)
