# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockExecutor.sol/contract_MockExecutor.md]

## Metadata

- **Contract**: MockExecutor
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 384:63:219

## Implementation

```solidity
function onUninstall(bytes calldata data) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockExecutor.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
