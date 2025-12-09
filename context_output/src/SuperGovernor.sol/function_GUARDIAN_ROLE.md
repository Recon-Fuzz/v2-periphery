# Function: GUARDIAN_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `GUARDIAN_ROLE()`
- **Visibility**: external
- **Source Range**: 28042:95:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function GUARDIAN_ROLE() external pure returns (bytes32) {
    return _GUARDIAN_ROLE;
}
```

## State Variable Reads

- **_GUARDIAN_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.GUARDIAN_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to guardian functions
