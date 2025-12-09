# Function: test_MinStalenessManagement_Revert_ExecuteNoProposal()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenessManagement_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 94757:205:659

## Implementation

```solidity
/// @notice Tests reverting when executing without a proposal
function test_MinStalenessManagement_Revert_ExecuteNoProposal() public {
    vm.expectRevert(ISuperGovernor.NO_PROPOSED_MIN_STALENESS.selector);
    superGovernor.executeMinStalenessChange();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeMinStalenessChange()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenessManagement_Revert_ExecuteNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing without a proposal
