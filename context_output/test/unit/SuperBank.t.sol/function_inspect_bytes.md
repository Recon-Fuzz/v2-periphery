# Function: inspect(bytes)

**Contract**: [test/unit/SuperBank.t.sol/contract_MockHookInspectFails.md]

## Metadata

- **Contract**: MockHookInspectFails
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 76276:109:658

## Implementation

```solidity
function inspect(bytes memory) external pure returns (bytes memory) {
    revert("Inspect failed");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookInspectFails.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
