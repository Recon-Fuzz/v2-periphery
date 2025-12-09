# Function: onUninstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

## Metadata

- **Contract**: MockStatelessValidator
- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 289:62:226

## Implementation

```solidity
function onUninstall(bytes calldata data) virtual external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStatelessValidator.onUninstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during uninstallation of the module
 @param data arbitrary data that may be required on the module during `onUninstall`
 de-initialization
 MUST revert on error
