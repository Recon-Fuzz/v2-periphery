# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 1000:103:165

## Implementation

```solidity
function onUninstall(bytes calldata) override external payable {
    delete data[msg.sender];
}
```

## State Variable Writes

- **data** (`mapping(address => bytes)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
