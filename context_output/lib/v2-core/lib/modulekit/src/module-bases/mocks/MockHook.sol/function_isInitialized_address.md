# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 613:148:221

## Implementation

```solidity
function isInitialized(address) external pure returns (bool) {
    return false;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
