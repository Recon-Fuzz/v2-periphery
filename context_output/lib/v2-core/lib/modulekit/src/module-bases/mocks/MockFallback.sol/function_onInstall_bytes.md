# Function: onInstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 183:61:220

## Implementation

```solidity
function onInstall(bytes calldata data) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
