# Function: excludeArtifacts()

**Contract**: [test/integration/SuperVault/RedemptionSlippageIssueDemo.t.sol/contract_RedemptionSlippageIssueDemo.md]

## Metadata

- **Contract**: RedemptionSlippageIssueDemo
- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_) {
    excludedArtifacts_ = _excludedArtifacts;
}
```

## State Variable Reads

- **_excludedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
