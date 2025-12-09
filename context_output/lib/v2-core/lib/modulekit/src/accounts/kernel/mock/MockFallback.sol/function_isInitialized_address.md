# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 1275:136:165

## Implementation

```solidity
function isInitialized(address smartAccount) override external view returns (bool) {
    return data[smartAccount].length > 0;
}
```

## State Variable Reads

- **data** (`mapping(address => bytes)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
