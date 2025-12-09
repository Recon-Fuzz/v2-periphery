# Function: targetArtifacts()

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol/contract_DebridgeDlnHelper.md]

## Metadata

- **Contract**: DebridgeDlnHelper
- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_) {
    targetedArtifacts_ = _targetedArtifacts;
}
```

## State Variable Reads

- **_targetedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
