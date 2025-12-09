# Function: getLastQuotesLength()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastQuotesLength()`
- **Visibility**: external
- **Source Range**: 134899:104:659

## Implementation

```solidity
function getLastQuotesLength() external view returns (uint256) {
    return lastQuotes.length;
}
```

## State Variable Reads

- **lastQuotes** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastQuotesLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
