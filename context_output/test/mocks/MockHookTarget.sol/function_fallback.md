# Function: fallback()

**Contract**: [test/mocks/MockHookTarget.sol/contract_MockHookTarget.md]

## Metadata

- **Contract**: MockHookTarget
- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 849:162:594

## Implementation

```solidity
fallback() external {
    if (shouldFailExecution) {
        revert("MockHookTarget: fallback execution failed");
    }
    emit Executed();
}
```

## State Variable Reads

- **shouldFailExecution** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookTarget.fallback() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
