# Function: setFeedMaxStaleness(address,uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `setFeedMaxStaleness(address,uint256)`
- **Visibility**: external
- **Source Range**: 133924:154:659

## Implementation

```solidity
function setFeedMaxStaleness(address feed, uint256 newMaxStaleness) external {
    lastFeed = feed;
    lastFeedStaleness = newMaxStaleness;
}
```

## State Variable Writes

- **lastFeed** (`address`)
- **lastFeedStaleness** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.setFeedMaxStaleness(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
