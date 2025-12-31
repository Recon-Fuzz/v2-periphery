# Function: fallbackFunction(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `fallbackFunction(uint256)`
- **Visibility**: external
- **Source Range**: 1417:98:165

## Implementation

```solidity
function fallbackFunction(uint256 v) external pure returns (uint256) {
    return v * v;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.fallbackFunction(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
