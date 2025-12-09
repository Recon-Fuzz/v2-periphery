# Function: targetSelectors()

**Contract**: [lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol/contract_FoundryAsserts.md]

## Metadata

- **Contract**: FoundryAsserts
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
