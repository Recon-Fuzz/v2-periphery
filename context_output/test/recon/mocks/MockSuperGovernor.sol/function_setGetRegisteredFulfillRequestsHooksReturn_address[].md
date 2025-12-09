# Function: setGetRegisteredFulfillRequestsHooksReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetRegisteredFulfillRequestsHooksReturn(address[])`
- **Visibility**: public
- **Source Range**: 14294:289:642

## Implementation

```solidity
function setGetRegisteredFulfillRequestsHooksReturn(address[] memory _value0) public {
    delete _getRegisteredFulfillRequestsHooksReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getRegisteredFulfillRequestsHooksReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getRegisteredFulfillRequestsHooksReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetRegisteredFulfillRequestsHooksReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
