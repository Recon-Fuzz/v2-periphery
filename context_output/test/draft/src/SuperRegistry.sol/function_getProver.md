# Function: getProver()

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `getProver()`
- **Visibility**: external
- **Source Range**: 15013:84:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function getProver() external view returns (address) {
    return _prover;
}
```

## State Variable Reads

- **_prover** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.getProver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Gets the prover address
 @return The address of the prover
