# Function: replaceCalldataAmount(bytes,uint256)

**Contract**: [lib/v2-core/src/hooks/claim/fluid/FluidClaimRewardHook.sol/contract_FluidClaimRewardHook.md]

## Metadata

- **Contract**: FluidClaimRewardHook
- **Signature**: `replaceCalldataAmount(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 2391:124:371

## Implementation

```solidity
/// @inheritdoc ISuperHookOutflow
function replaceCalldataAmount(bytes memory data, uint256) external pure returns (bytes memory) {
    return data;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FluidClaimRewardHook.replaceCalldataAmount(bytes,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookOutflow

### Interface Documentation

@notice Replace the amount in the calldata
 @param data The data to replace the amount in
 @param amount The amount to replace
 @return data The data with the replaced amount
