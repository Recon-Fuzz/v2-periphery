# Function: setGetProposedUpkeepPaymentsStatusReturn(bool,uint256)

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `setGetProposedUpkeepPaymentsStatusReturn(bool,uint256)`
- **Visibility**: public
- **Source Range**: 13022:215:642

## Implementation

```solidity
function setGetProposedUpkeepPaymentsStatusReturn(bool _value0, uint256 _value1) public {
    _getProposedUpkeepPaymentsStatusReturn_0 = _value0;
    _getProposedUpkeepPaymentsStatusReturn_1 = _value1;
}
```

## State Variable Writes

- **_getProposedUpkeepPaymentsStatusReturn_0** (`bool`)
- **_getProposedUpkeepPaymentsStatusReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.setGetProposedUpkeepPaymentsStatusReturn(bool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
