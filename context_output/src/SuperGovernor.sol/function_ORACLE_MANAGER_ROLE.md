# Function: ORACLE_MANAGER_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `ORACLE_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27894:107:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function ORACLE_MANAGER_ROLE() external pure returns (bytes32) {
    return _ORACLE_MANAGER_ROLE;
}
```

## State Variable Reads

- **_ORACLE_MANAGER_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.ORACLE_MANAGER_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to oracle management functions
