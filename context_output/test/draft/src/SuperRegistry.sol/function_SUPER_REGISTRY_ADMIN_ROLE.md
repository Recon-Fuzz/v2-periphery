# Function: SUPER_REGISTRY_ADMIN_ROLE()

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `SUPER_REGISTRY_ADMIN_ROLE()`
- **Visibility**: external
- **Source Range**: 15467:119:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function SUPER_REGISTRY_ADMIN_ROLE() external pure returns (bytes32) {
    return _SUPER_REGISTRY_ADMIN_ROLE;
}
```

## State Variable Reads

- **_SUPER_REGISTRY_ADMIN_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.SUPER_REGISTRY_ADMIN_ROLE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Returns the super registry admin role identifier
 @return The keccak256 hash of "SUPER_REGISTRY_ADMIN_ROLE"
