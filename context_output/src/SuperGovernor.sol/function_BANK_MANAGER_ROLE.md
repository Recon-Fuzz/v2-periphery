# Function: BANK_MANAGER_ROLE()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `BANK_MANAGER_ROLE()`
- **Visibility**: external
- **Source Range**: 27608:103:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function BANK_MANAGER_ROLE() external pure returns (bytes32) {
    return _BANK_MANAGER_ROLE;
}
```

## State Variable Reads

- **_BANK_MANAGER_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.BANK_MANAGER_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice The identifier of the role that grants access to bank management functions
