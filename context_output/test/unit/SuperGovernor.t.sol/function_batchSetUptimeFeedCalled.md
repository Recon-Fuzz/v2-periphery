# Function: batchSetUptimeFeedCalled()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleL2.md]

## Metadata

- **Contract**: MockSuperOracleL2
- **Signature**: `batchSetUptimeFeedCalled()`
- **Visibility**: external
- **Source Range**: 136396:114:659

## Implementation

```solidity
function batchSetUptimeFeedCalled() external view returns (bool) {
    return _batchSetUptimeFeedCalled;
}
```

## State Variable Reads

- **_batchSetUptimeFeedCalled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleL2.batchSetUptimeFeedCalled() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
