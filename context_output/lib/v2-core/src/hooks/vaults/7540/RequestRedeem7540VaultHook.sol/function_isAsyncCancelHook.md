# Function: isAsyncCancelHook()

**Contract**: [lib/v2-core/src/hooks/vaults/7540/RequestRedeem7540VaultHook.sol/contract_RequestRedeem7540VaultHook.md]

## Metadata

- **Contract**: RequestRedeem7540VaultHook
- **Signature**: `isAsyncCancelHook()`
- **Visibility**: external
- **Source Range**: 2766:113:413

## Implementation

```solidity
/// @inheritdoc ISuperHookAsyncCancelations
function isAsyncCancelHook() external pure returns (CancelationType) {
    return CancelationType.NONE;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RequestRedeem7540VaultHook.isAsyncCancelHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookAsyncCancelations

### Interface Documentation

@notice Identifies the type of async operation this hook can cancel
 @dev Used to verify the hook is appropriate for the operation being canceled
 @return asyncType The type of cancellation this hook performs
