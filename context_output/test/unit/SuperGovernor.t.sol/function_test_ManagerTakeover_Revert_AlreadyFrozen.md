# Function: test_ManagerTakeover_Revert_AlreadyFrozen()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ManagerTakeover_Revert_AlreadyFrozen()`
- **Visibility**: public
- **Source Range**: 22235:350:659

## Implementation

```solidity
/// @notice Tests reverting when trying to freeze already frozen manager takeovers
function test_ManagerTakeover_Revert_AlreadyFrozen() public {
    vm.prank(sGovernor);
    superGovernor.freezeManagerTakeover();
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.MANAGER_TAKEOVERS_FROZEN.selector);
    superGovernor.freezeManagerTakeover();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::freezeManagerTakeover()**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ManagerTakeover_Revert_AlreadyFrozen() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when trying to freeze already frozen manager takeovers
