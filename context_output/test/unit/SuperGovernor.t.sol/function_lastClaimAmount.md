# Function: lastClaimAmount()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperVaultAggregator.md]

## Metadata

- **Contract**: MockSuperVaultAggregator
- **Signature**: `lastClaimAmount()`
- **Visibility**: external
- **Source Range**: 136945:99:659

## Implementation

```solidity
function lastClaimAmount() external view returns (uint256) {
    return _lastClaimAmount;
}
```

## State Variable Reads

- **_lastClaimAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultAggregator.lastClaimAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
