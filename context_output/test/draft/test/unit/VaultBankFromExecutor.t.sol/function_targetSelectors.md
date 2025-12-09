# Function: targetSelectors()

**Contract**: [test/draft/test/unit/VaultBankFromExecutor.t.sol/contract_VaultBankFromExecutor.md]

## Metadata

- **Contract**: VaultBankFromExecutor
- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_) {
    targetedSelectors_ = _targetedSelectors;
}
```

## State Variable Reads

- **_targetedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
