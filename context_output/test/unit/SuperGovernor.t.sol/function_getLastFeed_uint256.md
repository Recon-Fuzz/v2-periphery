# Function: getLastFeed(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastFeed(uint256)`
- **Visibility**: external
- **Source Range**: 135585:108:659

## Implementation

```solidity
function getLastFeed(uint256 index) external view returns (address) {
    return lastFeeds[index];
}
```

## State Variable Reads

- **lastFeeds** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastFeed(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
