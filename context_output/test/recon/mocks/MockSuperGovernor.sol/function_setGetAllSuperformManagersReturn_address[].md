# Function: setGetAllSuperformManagersReturn(address[])

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetAllSuperformManagersReturn(address[])`
- **Visibility**: public
- **Source Range**: 10486:259:642

## Implementation

```solidity
function setGetAllSuperformManagersReturn(address[] memory _value0) public {
    delete _getAllSuperformManagersReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getAllSuperformManagersReturn_0.push(_value0[i]);
    }
}
```

## State Variable Writes

- **_getAllSuperformManagersReturn_0** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetAllSuperformManagersReturn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
