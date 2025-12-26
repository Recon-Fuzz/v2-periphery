# Function: decodeAmount(bytes)

**Contract**: [lib/v2-core/src/hooks/claim/yearn/YearnClaimOneRewardHook.sol/contract_YearnClaimOneRewardHook.md]

## Metadata

- **Contract**: YearnClaimOneRewardHook
- **Signature**: `decodeAmount(bytes)`
- **Visibility**: external
- **Source Range**: 2191:93:374

## Implementation

```solidity
/// @inheritdoc ISuperHookInflowOutflow
function decodeAmount(bytes memory) external pure returns (uint256) {
    return 0;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: YearnClaimOneRewardHook.decodeAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInflowOutflow

### Interface Documentation

@notice Extracts the amount from the hook's calldata
 @dev Used to determine the quantity of assets or shares being processed
 @param data The hook-specific calldata containing the amount
 @return The amount of tokens to process
