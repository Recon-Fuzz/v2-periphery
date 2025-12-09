# Function: setGetRegisteredHooksReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetRegisteredHooksReturn(address[])`
- **Visibility**: public
- **Source Range**: 14649:244:642

## Implementation

```solidity
function setGetRegisteredHooksReturn(address[] memory _value0) public {
    delete _getRegisteredHooksReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getRegisteredHooksReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getRegisteredHooksReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetRegisteredHooksReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
