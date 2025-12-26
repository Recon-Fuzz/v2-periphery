# Function: name()

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 3858:137:360

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function name() override external pure returns (string memory) {
    return "SuperDestinationExecutor";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationExecutor.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Returns the name of the executor implementation
 @dev Must be implemented by each executor to identify its type
 @return The name string of the specific executor implementation
