# Function: incentivesEnabled()

**Contract**: [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]

## Metadata

- **Contract**: IncentiveFundContract
- **Signature**: `incentivesEnabled()`
- **Visibility**: external
- **Source Range**: 6473:98:547

## Implementation

```solidity
/// @inheritdoc IIncentiveFundContract
function incentivesEnabled() external view returns (bool) {
    return incentivesActive;
}
```

## State Variable Reads

- **incentivesActive** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveFundContract.incentivesEnabled() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveFundContract

### Interface Documentation

@notice Returns whether incentives are enabled
 @return Whether incentives are enabled
