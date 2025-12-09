# Function: getLastQuote(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastQuote(uint256)`
- **Visibility**: external
- **Source Range**: 135347:110:659

## Implementation

```solidity
function getLastQuote(uint256 index) external view returns (address) {
    return lastQuotes[index];
}
```

## State Variable Reads

- **lastQuotes** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastQuote(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
