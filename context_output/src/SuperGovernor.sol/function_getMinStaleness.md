# Function: getMinStaleness()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getMinStaleness()`
- **Visibility**: external
- **Source Range**: 31446:96:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getMinStaleness() external view returns (uint256) {
    return _minStaleness;
}
```

## State Variable Reads

- **_minStaleness** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getMinStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the proposed upkeep cost per update and its effective time
 @notice Gets the current minimum staleness value
 @return The current minimum staleness value in seconds
