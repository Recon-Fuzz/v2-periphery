# Function: setExecutorMode(bool)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `setExecutorMode(bool)`
- **Visibility**: external
- **Source Range**: 779:101:165

## Implementation

```solidity
function setExecutorMode(bool _isExecutor) external payable {
    isExecutor = _isExecutor;
}
```

## State Variable Writes

- **isExecutor** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.setExecutorMode(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
