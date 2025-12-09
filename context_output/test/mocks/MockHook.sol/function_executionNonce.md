# Function: executionNonce()

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `executionNonce()`
- **Visibility**: external
- **Source Range**: 3875:83:593

## Implementation

```solidity
function executionNonce() external pure returns (uint256) {
    return 1;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.executionNonce() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the execution nonce for the current execution context
 @dev Used to ensure unique execution contexts and prevent replay attacks
 @return The execution nonce
