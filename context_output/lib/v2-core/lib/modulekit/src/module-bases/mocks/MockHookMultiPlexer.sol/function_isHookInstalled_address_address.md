# Function: isHookInstalled(address,address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `isHookInstalled(address,address)`
- **Visibility**: external
- **Source Range**: 1312:278:222

## Implementation

```solidity
function isHookInstalled(address account, address hook) external view returns (bool) {
    Hook[] memory _hooks = hooks[account];
    for (uint256 i = 0; i < _hooks.length; i++) {
        if (_hooks[i].hook == hook) return true;
    }
    return false;
}
```

## State Variable Reads

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookMultiPlexer.isHookInstalled(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
