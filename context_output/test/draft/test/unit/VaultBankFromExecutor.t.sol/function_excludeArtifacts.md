# Function: excludeArtifacts()

**Contract**: [test/draft/test/unit/VaultBankFromExecutor.t.sol/contract_VaultBankFromExecutor.md]

## Metadata

- **Contract**: VaultBankFromExecutor
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
