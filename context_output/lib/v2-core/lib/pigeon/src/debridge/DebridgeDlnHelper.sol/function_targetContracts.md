# Function: targetContracts()

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol/contract_DebridgeDlnHelper.md]

## Metadata

- **Contract**: DebridgeDlnHelper
- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetContracts() public view returns (address[] memory targetedContracts_) {
    targetedContracts_ = _targetedContracts;
}
```

## State Variable Reads

- **_targetedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
