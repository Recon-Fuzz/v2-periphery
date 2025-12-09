# Function: setGetRelayersReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetRelayersReturn(address[])`
- **Visibility**: public
- **Source Range**: 14952:223:642

## Implementation

```solidity
function setGetRelayersReturn(address[] memory _value0) public {
    delete _getRelayersReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getRelayersReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getRelayersReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetRelayersReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
