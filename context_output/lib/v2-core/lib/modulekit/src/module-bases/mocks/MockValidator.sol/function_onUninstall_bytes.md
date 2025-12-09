# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

## Metadata

- **Contract**: MockValidator
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 365:71:228

## Implementation

```solidity
function onUninstall(bytes calldata data) virtual override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockValidator.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
