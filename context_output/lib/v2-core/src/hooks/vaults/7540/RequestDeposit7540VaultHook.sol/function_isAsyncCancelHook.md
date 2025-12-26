# Function: isAsyncCancelHook()

**Contract**: [lib/v2-core/src/hooks/vaults/7540/RequestDeposit7540VaultHook.sol/contract_RequestDeposit7540VaultHook.md]

## Metadata

- **Contract**: RequestDeposit7540VaultHook
- **Signature**: `isAsyncCancelHook()`
- **Visibility**: external
- **Source Range**: 2696:113:412

## Implementation

```solidity
/// @inheritdoc ISuperHookAsyncCancelations
function isAsyncCancelHook() external pure returns (CancelationType) {
    return CancelationType.NONE;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RequestDeposit7540VaultHook.isAsyncCancelHook() (NodeID: 0)
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
