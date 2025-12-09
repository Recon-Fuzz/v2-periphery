# Function: executeWithData(bytes)

**Contract**: [test/mocks/MockHookTarget.sol/contract_MockHookTarget.md]

## Metadata

- **Contract**: MockHookTarget
- **Signature**: `executeWithData(bytes)`
- **Visibility**: external
- **Source Range**: 598:200:594

## Implementation

```solidity
function executeWithData(bytes calldata data) external {
    if (shouldFailExecution) {
        revert("MockHookTarget: execution failed");
    }
    emit ExecutedWithData(data);
}
```

## State Variable Reads

- **shouldFailExecution** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookTarget.executeWithData(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
