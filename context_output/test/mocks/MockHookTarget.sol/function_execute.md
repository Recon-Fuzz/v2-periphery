# Function: execute()

**Contract**: [test/mocks/MockHookTarget.sol/contract_MockHookTarget.md]

## Metadata

- **Contract**: MockHookTarget
- **Signature**: `execute()`
- **Visibility**: external
- **Source Range**: 431:161:594

## Implementation

```solidity
function execute() external {
    if (shouldFailExecution) {
        revert("MockHookTarget: execution failed");
    }
    emit Executed();
}
```

## State Variable Reads

- **shouldFailExecution** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookTarget.execute() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
