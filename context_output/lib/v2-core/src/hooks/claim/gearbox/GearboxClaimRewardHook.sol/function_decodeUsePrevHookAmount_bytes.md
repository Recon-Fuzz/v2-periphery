# Function: decodeUsePrevHookAmount(bytes)

**Contract**: [lib/v2-core/src/hooks/claim/gearbox/GearboxClaimRewardHook.sol/contract_GearboxClaimRewardHook.md]

## Metadata

- **Contract**: GearboxClaimRewardHook
- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 2208:105:372

## Implementation

```solidity
/// @inheritdoc ISuperHookContextAware
function decodeUsePrevHookAmount(bytes memory) external pure returns (bool) {
    return false;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GearboxClaimRewardHook.decodeUsePrevHookAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookContextAware

### Interface Documentation

@notice Determines if this hook should use the amount from the previous hook
 @dev Used to create hook chains where output from one hook becomes input to the next
 @param data The hook-specific data containing configuration
 @return True if the hook should use the previous hook's output amount
