# Function: batchSetUptimeFeed(address[],address[],uint256[])

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleL2.md]

## Metadata

- **Contract**: MockSuperOracleL2
- **Signature**: `batchSetUptimeFeed(address[],address[],uint256[])`
- **Visibility**: external
- **Source Range**: 136244:146:659

## Implementation

```solidity
function batchSetUptimeFeed(address[] calldata, address[] calldata, uint256[] calldata) external {
    _batchSetUptimeFeedCalled = true;
}
```

## State Variable Writes

- **_batchSetUptimeFeedCalled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleL2.batchSetUptimeFeed(address[],address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
