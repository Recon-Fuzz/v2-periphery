# Function: setGetValidatorsReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetValidatorsReturn(address[])`
- **Visibility**: public
- **Source Range**: 16014:229:642

## Implementation

```solidity
function setGetValidatorsReturn(address[] memory _value0) public {
    delete _getValidatorsReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getValidatorsReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getValidatorsReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetValidatorsReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
