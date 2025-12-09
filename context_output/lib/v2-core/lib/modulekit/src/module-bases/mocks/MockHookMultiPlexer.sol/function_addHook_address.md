# Function: addHook(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `addHook(address)`
- **Visibility**: external
- **Source Range**: 838:133:222

## Implementation

```solidity
function addHook(address hook) external {
    Hook memory _hook = Hook(hook, false);
    hooks[msg.sender].push(_hook);
}
```

## State Variable Writes

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookMultiPlexer.addHook(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
