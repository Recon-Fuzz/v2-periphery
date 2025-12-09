# Function: setGetManagersPaginatedReturn(address[],uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetManagersPaginatedReturn(address[],uint256)`
- **Visibility**: public
- **Source Range**: 11423:316:642

## Implementation

```solidity
function setGetManagersPaginatedReturn(address[] memory _value0, uint256 _value1) public {
    delete _getManagersPaginatedReturn_0;
    for (uint256 i = 0; i < _value0.length; i++) {
        _getManagersPaginatedReturn_0.push(_value0[i]);
    }
    _getManagersPaginatedReturn_1 = _value1;
}
```

## State Variable Writes

- **_getManagersPaginatedReturn_0** (`address[]`)
- **_getManagersPaginatedReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetManagersPaginatedReturn(address[],uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
