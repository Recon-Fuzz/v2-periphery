# Function: getLastProvidersLength()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getLastProvidersLength()`
- **Visibility**: external
- **Source Range**: 135009:110:659

## Implementation

```solidity
function getLastProvidersLength() external view returns (uint256) {
    return lastProviders.length;
}
```

## State Variable Reads

- **lastProviders** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getLastProvidersLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
