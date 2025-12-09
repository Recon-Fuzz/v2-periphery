# Function: getProposedUpkeepPaymentsStatus()

**Contract**: [test/recon/mocks/MockSuperGovernor.sol/contract_MockSuperGovernor.md]

## Metadata

- **Contract**: MockSuperGovernor
- **Signature**: `getProposedUpkeepPaymentsStatus()`
- **Visibility**: public
- **Source Range**: 31568:187:642

## Implementation

```solidity
function getProposedUpkeepPaymentsStatus() public view returns (bool, uint256) {
    return (_getProposedUpkeepPaymentsStatusReturn_0, _getProposedUpkeepPaymentsStatusReturn_1);
}
```

## State Variable Reads

- **_getProposedUpkeepPaymentsStatusReturn_0** (`bool`)
- **_getProposedUpkeepPaymentsStatusReturn_1** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperGovernor.getProposedUpkeepPaymentsStatus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
