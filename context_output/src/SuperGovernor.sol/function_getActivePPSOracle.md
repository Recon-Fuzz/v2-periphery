# Function: getActivePPSOracle()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getActivePPSOracle()`
- **Visibility**: external
- **Source Range**: 30558:177:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getActivePPSOracle() external view returns (address) {
    if (_activePPSOracle == address(0)) revert NO_ACTIVE_PPS_ORACLE();
    return _activePPSOracle;
}
```

## State Variable Reads

- **_activePPSOracle** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getActivePPSOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the active PPS oracle
 @return The active PPS oracle address
