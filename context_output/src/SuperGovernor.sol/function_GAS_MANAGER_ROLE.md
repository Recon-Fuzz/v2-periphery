# Function: GAS_MANAGER_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `GAS_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27752:101:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function GAS_MANAGER_ROLE() external pure returns (bytes32) {
    return _GAS_MANAGER_ROLE;
}
```

## State Variable Reads

- **_GAS_MANAGER_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.GAS_MANAGER_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to gas management functions
