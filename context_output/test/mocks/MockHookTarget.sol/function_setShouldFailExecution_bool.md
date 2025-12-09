# Function: setShouldFailExecution(bool)

**Contract**: [test/mocks/MockHookTarget.sol/contract_MockHookTarget.md]

## Metadata

- **Contract**: MockHookTarget
- **Signature**: `setShouldFailExecution(bool)`
- **Visibility**: external
- **Source Range**: 316:109:594

## Implementation

```solidity
function setShouldFailExecution(bool _shouldFail) external {
    shouldFailExecution = _shouldFail;
}
```

## State Variable Writes

- **shouldFailExecution** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookTarget.setShouldFailExecution(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
