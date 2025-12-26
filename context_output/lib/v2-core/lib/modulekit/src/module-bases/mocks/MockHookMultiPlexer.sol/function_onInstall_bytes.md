# Function: onInstall(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 398:332:222

## Implementation

```solidity
function onInstall(bytes calldata data) override external {
    if (data.length == 0) return;
    address[] memory _hooks = abi.decode(data, (address[]));
    for (uint256 i = 0; i < _hooks.length; i++) {
        Hook memory _hook = Hook(_hooks[i], true);
        hooks[msg.sender].push(_hook);
    }
}
```

## State Variable Writes

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookMultiPlexer.onInstall(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev This function is called by the smart account during installation of the module
 @param data arbitrary data that may be required on the module during `onInstall`
 initialization
 MUST revert on error (i.e. if module is already enabled)
