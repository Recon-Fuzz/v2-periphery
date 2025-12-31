# Function: GOVERNOR_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `GOVERNOR_ROLE()`
- **Visibility**: external
- **Source Range**: 27472:95:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function GOVERNOR_ROLE() external pure returns (bytes32) {
    return _GOVERNOR_ROLE;
}
```

## State Variable Reads

- **_GOVERNOR_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.GOVERNOR_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to daily operations like hooks and validators
