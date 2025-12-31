# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockExecutor.sol/contract_MockExecutor.md]

## Metadata

- **Contract**: MockExecutor
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 823:148:219

## Implementation

```solidity
function isInitialized(address) external pure returns (bool) {
    return false;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockExecutor.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
