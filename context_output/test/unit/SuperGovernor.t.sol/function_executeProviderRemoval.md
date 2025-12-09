# Function: executeProviderRemoval()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 134659:90:659

## Implementation

```solidity
function executeProviderRemoval() external {
    providerRemovalExecuted = true;
}
```

## State Variable Writes

- **providerRemovalExecuted** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.executeProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
