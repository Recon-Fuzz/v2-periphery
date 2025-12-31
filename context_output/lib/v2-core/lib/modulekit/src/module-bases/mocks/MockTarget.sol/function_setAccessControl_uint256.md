# Function: setAccessControl(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockTarget.sol/contract_MockTarget.md]

## Metadata

- **Contract**: MockTarget
- **Signature**: `setAccessControl(uint256)`
- **Visibility**: public
- **Source Range**: 267:209:227

## Implementation

```solidity
function setAccessControl(uint256 _value) public returns (uint256) {
    if (msg.sender != address(this)) {
        revert Unauthorized();
    }
    value = _value;
    return _value;
}
```

## State Variable Writes

- **value** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTarget.setAccessControl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
