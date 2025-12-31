# Function: onInstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

## Metadata

- **Contract**: MockValidator
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 290:69:228

## Implementation

```solidity
function onInstall(bytes calldata data) virtual override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockValidator.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
