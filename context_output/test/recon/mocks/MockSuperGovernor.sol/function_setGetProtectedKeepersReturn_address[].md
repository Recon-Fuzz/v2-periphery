# Function: setGetProtectedKeepersReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetProtectedKeepersReturn(address[])`
- **Visibility**: public
- **Source Range**: 13613:247:642

## Implementation

```solidity
function setGetProtectedKeepersReturn(address[] memory _value0) public {
    delete _getProtectedKeepersReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getProtectedKeepersReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getProtectedKeepersReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetProtectedKeepersReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
