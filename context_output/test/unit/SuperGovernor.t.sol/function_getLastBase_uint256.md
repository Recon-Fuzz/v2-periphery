# Function: getLastBase(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastBase(uint256)`
- **Visibility**: external
- **Source Range**: 135233:108:659

## Implementation

```solidity
function getLastBase(uint256 index) external view returns (address) {
    return lastBases[index];
}
```

## State Variable Reads

- **lastBases** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastBase(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
