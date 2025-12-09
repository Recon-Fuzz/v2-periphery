# Function: setGetExecutorsReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetExecutorsReturn(address[])`
- **Visibility**: public
- **Source Range**: 10805:226:642

## Implementation

```solidity
function setGetExecutorsReturn(address[] memory _value0) public {
    delete _getExecutorsReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getExecutorsReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getExecutorsReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetExecutorsReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
