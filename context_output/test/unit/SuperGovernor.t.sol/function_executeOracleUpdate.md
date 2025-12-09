# Function: executeOracleUpdate()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `executeOracleUpdate()`
- **Visibility**: external
- **Source Range**: 134569:84:659

## Implementation

```solidity
function executeOracleUpdate() external {
    oracleUpdateExecuted = true;
}
```

## State Variable Writes

- **oracleUpdateExecuted** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.executeOracleUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
