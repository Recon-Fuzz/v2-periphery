# Function: version()

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 1050:97:361

## Implementation

```solidity
function version() override external pure returns (string memory) {
    return "0.0.1";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutor.version() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the version of the executor implementation
 @dev Used for tracking implementation version for upgrades and compatibility
 @return The version string of the specific executor implementation
