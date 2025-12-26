# Function: isInitialized(address)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 3474:128:222

## Implementation

```solidity
function isInitialized(address smartAccount) external view returns (bool) {
    return hooks[smartAccount].length > 0;
}
```

## State Variable Reads

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookMultiPlexer.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
