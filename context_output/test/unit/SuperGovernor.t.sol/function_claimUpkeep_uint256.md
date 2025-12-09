# Function: claimUpkeep(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperVaultAggregator.md]

## Metadata

- **Contract**: MockSuperVaultAggregator
- **Signature**: `claimUpkeep(uint256)`
- **Visibility**: external
- **Source Range**: 136710:123:659

## Implementation

```solidity
function claimUpkeep(uint256 amount) external {
    _claimUpkeepCalled = true;
    _lastClaimAmount = amount;
}
```

## State Variable Writes

- **_claimUpkeepCalled** (`bool`)
- **_lastClaimAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperVaultAggregator.claimUpkeep(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
