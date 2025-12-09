# Function: name()

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 942:102:361

## Implementation

```solidity
function name() override external pure returns (string memory) {
    return "SuperExecutor";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutor.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the name of the executor implementation
 @dev Must be implemented by each executor to identify its type
 @return The name string of the specific executor implementation
