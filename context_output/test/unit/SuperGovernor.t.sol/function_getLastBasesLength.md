# Function: getLastBasesLength()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastBasesLength()`
- **Visibility**: external
- **Source Range**: 134791:102:659

## Implementation

```solidity
function getLastBasesLength() external view returns (uint256) {
    return lastBases.length;
}
```

## State Variable Reads

- **lastBases** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastBasesLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
