# Function: setGetProposedActivePPSOracleReturn(address,uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetProposedActivePPSOracleReturn(address,uint256)`
- **Visibility**: public
- **Source Range**: 12166:203:642

## Implementation

```solidity
function setGetProposedActivePPSOracleReturn(address _value0, uint256 _value1) public {
    _getProposedActivePPSOracleReturn_0 = _value0;
    _getProposedActivePPSOracleReturn_1 = _value1;
}
```

## State Variable Writes

- **_getProposedActivePPSOracleReturn_0** (`address`)
- **_getProposedActivePPSOracleReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetProposedActivePPSOracleReturn(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
