# Function: setExecutions(struct Execution[])

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `setExecutions(struct Execution[])`
- **Visibility**: external
- **Source Range**: 1162:212:593

## Implementation

```solidity
function setExecutions(Execution[] memory _executions) external {
    delete executions;
    for (uint256 i = 0; i < _executions.length; i++) {
        executions.push(_executions[i]);
    }
}
```

## State Variable Writes

- **executions** (`struct Execution[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.setExecutions(struct Execution[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
