# Function: set(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockTarget.sol/contract_MockTarget.md]

## Metadata

- **Contract**: MockTarget
- **Signature**: `set(uint256)`
- **Visibility**: public
- **Source Range**: 145:116:227

## Implementation

```solidity
function set(uint256 _value) public payable returns (uint256) {
    value = _value;
    return _value;
}
```

## State Variable Writes

- **value** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTarget.set(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
