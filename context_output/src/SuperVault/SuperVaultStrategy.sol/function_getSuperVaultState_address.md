# Function: getSuperVaultState(address)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `getSuperVaultState(address)`
- **Visibility**: external
- **Source Range**: 24759:152:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function getSuperVaultState(address controller) external view returns (SuperVaultState memory state) {
    return superVaultState[controller];
}
```

## State Variable Reads

- **superVaultState** (`mapping(address => struct ISuperVaultStrategy.SuperVaultState)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.getSuperVaultState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the super vault state for a controller
 @param controller The controller address
 @return state The super vault state
