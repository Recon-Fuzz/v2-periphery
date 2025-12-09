# Function: claimUpkeepCalled()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperVaultAggregator.md]

## Metadata

- **Contract**: MockSuperVaultAggregator
- **Signature**: `claimUpkeepCalled()`
- **Visibility**: external
- **Source Range**: 136839:100:659

## Implementation

```solidity
function claimUpkeepCalled() external view returns (bool) {
    return _claimUpkeepCalled;
}
```

## State Variable Reads

- **_claimUpkeepCalled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultAggregator.claimUpkeepCalled() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
