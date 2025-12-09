# Function: inspect(bytes)

**Contract**: [lib/v2-core/test/mocks/unused-hooks/MockSwapOdosHook.sol/contract_MockSwapOdosHook.md]

## Metadata

- **Contract**: MockSwapOdosHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 8682:81:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata) virtual external view returns (bytes memory) {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
