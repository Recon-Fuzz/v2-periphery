# Function: getLastFeedsLength()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastFeedsLength()`
- **Visibility**: external
- **Source Range**: 135125:102:659

## Implementation

```solidity
function getLastFeedsLength() external view returns (uint256) {
    return lastFeeds.length;
}
```

## State Variable Reads

- **lastFeeds** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastFeedsLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
