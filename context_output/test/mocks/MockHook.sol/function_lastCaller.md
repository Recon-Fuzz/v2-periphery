# Function: lastCaller()

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `lastCaller()`
- **Visibility**: external
- **Source Range**: 3964:88:593

## Implementation

```solidity
function lastCaller() external view returns (address) {
    return msg.sender;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.lastCaller() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the last caller registered by `setExecutionContext`
 @return The last caller address
