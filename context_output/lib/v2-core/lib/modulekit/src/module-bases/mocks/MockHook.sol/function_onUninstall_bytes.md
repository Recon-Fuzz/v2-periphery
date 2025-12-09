# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 234:63:221

## Implementation

```solidity
function onUninstall(bytes calldata data) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
