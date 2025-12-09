# Function: inspect(bytes)

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MockHookInspectReverts.md]

## Metadata

- **Contract**: MockHookInspectReverts
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 32231:123:657

## Implementation

```solidity
function inspect(bytes memory) external pure returns (bytes memory) {
    revert("Inspect intentionally failed");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookInspectReverts.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
