# Function: queueOracleUpdate(address[],address[],bytes32[],address[])

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `queueOracleUpdate(address[],address[],bytes32[],address[])`
- **Visibility**: external
- **Source Range**: 134208:355:659

## Implementation

```solidity
function queueOracleUpdate(address[] calldata bases, address[] calldata quotes, bytes32[] calldata providers, address[] calldata feeds) external {
    lastBases = bases;
    lastQuotes = quotes;
    lastProviders = providers;
    lastFeeds = feeds;
    oracleUpdateQueued = true;
}
```

## State Variable Writes

- **lastBases** (`address[]`)
- **lastQuotes** (`address[]`)
- **lastProviders** (`bytes32[]`)
- **lastFeeds** (`address[]`)
- **oracleUpdateQueued** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.queueOracleUpdate(address[],address[],bytes32[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
