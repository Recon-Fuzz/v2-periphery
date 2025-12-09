# Function: setFeedMaxStalenessBatch(address[],uint256[])

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `setFeedMaxStalenessBatch(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 134084:118:659

## Implementation

```solidity
function setFeedMaxStalenessBatch(address[] calldata, uint256[] calldata) external {
    batchCalled = true;
}
```

## State Variable Writes

- **batchCalled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.setFeedMaxStalenessBatch(address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
