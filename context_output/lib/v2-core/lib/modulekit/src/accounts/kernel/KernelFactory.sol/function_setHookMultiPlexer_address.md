# Function: setHookMultiPlexer(address)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/KernelFactory.sol/contract_KernelFactory.md]

## Metadata

- **Contract**: KernelFactory
- **Signature**: `setHookMultiPlexer(address)`
- **Visibility**: public
- **Source Range**: 6353:109:156

## Implementation

```solidity
function setHookMultiPlexer(address hook) public {
    hookMultiPlexer = MockHookMultiPlexer(hook);
}
```

## State Variable Writes

- **hookMultiPlexer** (`contract MockHookMultiPlexer`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelFactory.setHookMultiPlexer(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
