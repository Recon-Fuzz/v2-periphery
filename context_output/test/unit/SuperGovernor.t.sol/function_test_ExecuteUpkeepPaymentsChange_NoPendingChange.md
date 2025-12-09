# Function: test_ExecuteUpkeepPaymentsChange_NoPendingChange()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepPaymentsChange_NoPendingChange()`
- **Visibility**: public
- **Source Range**: 131660:245:659

## Implementation

```solidity
/// @notice Tests executeUpkeepPaymentsChange reverts when no change is pending
///  @dev Covers SuperGovernor.sol:543 - if (_upkeepPaymentsChangeEffectiveTime == 0) revert NO_PENDING_CHANGE()
function test_ExecuteUpkeepPaymentsChange_NoPendingChange() public {
    vm.expectRevert(ISuperGovernor.NO_PENDING_CHANGE.selector);
    superGovernor.executeUpkeepPaymentsChange();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeUpkeepPaymentsChange()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepPaymentsChange_NoPendingChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepPaymentsChange reverts when no change is pending
 @dev Covers SuperGovernor.sol:543 - if (_upkeepPaymentsChangeEffectiveTime == 0) revert NO_PENDING_CHANGE()
