# Function: setDefaultStaleness(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `setDefaultStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 133804:114:659

## Implementation

```solidity
function setDefaultStaleness(uint256 newMaxStaleness) external {
    lastMaxStaleness = newMaxStaleness;
}
```

## State Variable Writes

- **lastMaxStaleness** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.setDefaultStaleness(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
