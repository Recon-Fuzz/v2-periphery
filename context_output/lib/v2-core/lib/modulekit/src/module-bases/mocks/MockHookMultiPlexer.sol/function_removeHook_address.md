# Function: removeHook(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `removeHook(address)`
- **Visibility**: external
- **Source Range**: 977:329:222

## Implementation

```solidity
function removeHook(address hook) external {
    Hook[] storage _hooks = hooks[msg.sender];
    for (uint256 i = 0; i < _hooks.length; i++) {
        if (_hooks[i].hook == hook) {
            _hooks[i] = _hooks[_hooks.length - 1];
            _hooks.pop();
            break;
        }
    }
}
```

## State Variable Reads

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookMultiPlexer.removeHook(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
