# Function: getLastProvider(uint256)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastProvider(uint256)`
- **Visibility**: external
- **Source Range**: 135463:116:659

## Implementation

```solidity
function getLastProvider(uint256 index) external view returns (bytes32) {
    return lastProviders[index];
}
```

## State Variable Reads

- **lastProviders** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastProvider(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
