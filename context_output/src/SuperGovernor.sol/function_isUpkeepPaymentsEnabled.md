# Function: isUpkeepPaymentsEnabled()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `isUpkeepPaymentsEnabled()`
- **Visibility**: external
- **Source Range**: 32496:118:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function isUpkeepPaymentsEnabled() external view returns (bool enabled) {
    return _upkeepPaymentsEnabled;
}
```

## State Variable Reads

- **_upkeepPaymentsEnabled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.isUpkeepPaymentsEnabled() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Checks if upkeep payments are currently enabled
 @return enabled True if upkeep payments are enabled
