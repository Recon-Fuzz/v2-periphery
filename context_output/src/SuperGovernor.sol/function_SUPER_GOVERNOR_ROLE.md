# Function: SUPER_GOVERNOR_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `SUPER_GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 27324:107:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function SUPER_GOVERNOR_ROLE() external pure returns (bytes32) {
    return _SUPER_GOVERNOR_ROLE;
}
```

## State Variable Reads

- **_SUPER_GOVERNOR_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.SUPER_GOVERNOR_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to critical governance functions
