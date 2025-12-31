# Function: getCaller()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `getCaller()`
- **Visibility**: external
- **Source Range**: 1623:126:165

## Implementation

```solidity
function getCaller() external pure returns (address) {
    return address(bytes20(msg.data[msg.data.length - 20:]));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.getCaller() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
