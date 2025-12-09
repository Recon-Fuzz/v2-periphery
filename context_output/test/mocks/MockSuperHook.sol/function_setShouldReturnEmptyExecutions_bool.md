# Function: setShouldReturnEmptyExecutions(bool)

**Contract**: [test/mocks/MockSuperHook.sol/contract_MockSuperHook.md]

## Metadata

- **Contract**: MockSuperHook
- **Signature**: `setShouldReturnEmptyExecutions(bool)`
- **Visibility**: external
- **Source Range**: 1074:139:604

## Implementation

```solidity
function setShouldReturnEmptyExecutions(bool _shouldReturnEmpty) external {
    shouldReturnEmptyExecutions = _shouldReturnEmpty;
}
```

## State Variable Writes

- **shouldReturnEmptyExecutions** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperHook.setShouldReturnEmptyExecutions(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
