# Function: test_FeeManagement_Revert_ExecuteNoProposal()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_FeeManagement_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 80349:267:659

## Implementation

```solidity
/// @notice Tests reverting when executing a fee update without a proposal
function test_FeeManagement_Revert_ExecuteNoProposal() public {
    FeeType feeType = FeeType.REVENUE_SHARE;
    vm.expectRevert(abi.encodeWithSelector(ISuperGovernor.NO_PROPOSED_FEE.selector, feeType));
    superGovernor.executeFeeUpdate(feeType);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **SuperGovernor::executeFeeUpdate(enum FeeType)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_FeeManagement_Revert_ExecuteNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing a fee update without a proposal
