# Function: version()

**Contract**: [lib/v2-core/src/executors/SuperDestinationExecutor.sol/contract_SuperDestinationExecutor.md]

## Metadata

- **Contract**: SuperDestinationExecutor
- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 4036:97:360

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function version() override external pure returns (string memory) {
    return "0.0.1";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationExecutor.version() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Returns the version of the executor implementation
 @dev Used for tracking implementation version for upgrades and compatibility
 @return The version string of the specific executor implementation
