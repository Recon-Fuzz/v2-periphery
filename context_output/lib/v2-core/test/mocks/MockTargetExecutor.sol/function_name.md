# Function: name()

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 2306:93:487

## Implementation

```solidity
function name() external pure returns (string memory) {
    return "SuperExecutor";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the name of the executor implementation
 @dev Must be implemented by each executor to identify its type
 @return The name string of the specific executor implementation
