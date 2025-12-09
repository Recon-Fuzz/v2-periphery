# Function: excludeSenders()

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol/contract_DebridgeDlnHelper.md]

## Metadata

- **Contract**: DebridgeDlnHelper
- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_) {
    excludedSenders_ = _excludedSenders;
}
```

## State Variable Reads

- **_excludedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
