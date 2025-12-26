# Function: isAsyncCancelHook()

**Contract**: [lib/v2-core/src/hooks/vaults/7540/ClaimCancelRedeemRequest7540Hook.sol/contract_ClaimCancelRedeemRequest7540Hook.md]

## Metadata

- **Contract**: ClaimCancelRedeemRequest7540Hook
- **Signature**: `isAsyncCancelHook()`
- **Visibility**: external
- **Source Range**: 2539:116:409

## Implementation

```solidity
/// @inheritdoc ISuperHookAsyncCancelations
function isAsyncCancelHook() external pure returns (CancelationType) {
    return CancelationType.OUTFLOW;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ClaimCancelRedeemRequest7540Hook.isAsyncCancelHook() (NodeID: 0)
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
