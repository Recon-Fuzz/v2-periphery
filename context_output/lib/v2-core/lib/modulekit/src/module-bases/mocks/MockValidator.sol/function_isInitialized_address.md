# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

## Metadata

- **Contract**: MockValidator
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1159:148:228

## Implementation

```solidity
function isInitialized(address) external pure returns (bool) {
    return false;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockValidator.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
