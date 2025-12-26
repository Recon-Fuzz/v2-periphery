# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHybridValidator.sol/contract_MockHybridValidator.md]

## Metadata

- **Contract**: MockHybridValidator
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1184:148:223

## Implementation

```solidity
function isInitialized(address) external pure returns (bool) {
    return false;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHybridValidator.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
