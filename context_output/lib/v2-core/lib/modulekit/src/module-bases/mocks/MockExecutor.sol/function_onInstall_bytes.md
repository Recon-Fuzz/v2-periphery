# Function: onInstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockExecutor.sol/contract_MockExecutor.md]

## Metadata

- **Contract**: MockExecutor
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 317:61:219

## Implementation

```solidity
function onInstall(bytes calldata data) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockExecutor.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
