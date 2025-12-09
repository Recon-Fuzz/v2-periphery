# Function: calleeTest()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_Callee.md]

## Metadata

- **Contract**: Callee
- **Signature**: `calleeTest()`
- **Visibility**: external
- **Source Range**: 452:71:165

## Implementation

```solidity
function calleeTest() external {
    lastCaller = msg.sender;
}
```

## State Variable Writes

- **lastCaller** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Callee.calleeTest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
