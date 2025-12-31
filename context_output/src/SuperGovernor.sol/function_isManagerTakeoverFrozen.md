# Function: isManagerTakeoverFrozen()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `isManagerTakeoverFrozen()`
- **Visibility**: external
- **Source Range**: 28422:111:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function isManagerTakeoverFrozen() external view returns (bool) {
    return _managerTakeoversFrozen;
}
```

## State Variable Reads

- **_managerTakeoversFrozen** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.isManagerTakeoverFrozen() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Checks if manager takeovers are frozen
 @return True if manager takeovers are frozen, false otherwise
