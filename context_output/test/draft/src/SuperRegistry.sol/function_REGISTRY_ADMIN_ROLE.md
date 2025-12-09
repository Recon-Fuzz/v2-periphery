# Function: REGISTRY_ADMIN_ROLE()

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 15627:107:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function REGISTRY_ADMIN_ROLE() external pure returns (bytes32) {
    return _REGISTRY_ADMIN_ROLE;
}
```

## State Variable Reads

- **_REGISTRY_ADMIN_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.REGISTRY_ADMIN_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Returns the registry admin role identifier
 @return The keccak256 hash of "REGISTRY_ADMIN_ROLE"
