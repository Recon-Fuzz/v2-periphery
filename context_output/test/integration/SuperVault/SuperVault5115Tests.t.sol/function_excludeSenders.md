# Function: excludeSenders()

**Contract**: [test/integration/SuperVault/SuperVault5115Tests.t.sol/contract_SuperVault5115Tests.md]

## Metadata

- **Contract**: SuperVault5115Tests
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
