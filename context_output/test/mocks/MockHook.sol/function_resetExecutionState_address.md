# Function: resetExecutionState(address)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `resetExecutionState(address)`
- **Visibility**: external
- **Source Range**: 3624:151:593

## Implementation

```solidity
/// @notice Resets execution state - ONLY callable by executor after accounting
function resetExecutionState(address) external {
    preExecuteMutex = false;
    postExecuteMutex = false;
}
```

## State Variable Writes

- **preExecuteMutex** (`bool`)
- **postExecuteMutex** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.resetExecutionState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Resets execution state - ONLY callable by executor after accounting

### Interface Documentation

@notice Resets hook mutexes
 @param caller The caller address for context identification
