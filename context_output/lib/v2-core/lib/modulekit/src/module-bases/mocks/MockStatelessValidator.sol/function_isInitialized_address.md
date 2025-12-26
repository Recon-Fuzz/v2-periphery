# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

## Metadata

- **Contract**: MockStatelessValidator
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 465:89:226

## Implementation

```solidity
function isInitialized(address) external pure returns (bool) {
    return true;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStatelessValidator.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
