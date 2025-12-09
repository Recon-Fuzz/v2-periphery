# Function: test_PPSOracleManagement_Revert_ExecuteBeforeTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_PPSOracleManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 70770:378:659

## Implementation

```solidity
/// @notice Tests reverting when executing before timelock expiry
function test_PPSOracleManagement_Revert_ExecuteBeforeTimelock() public {
    vm.prank(sGovernor);
    superGovernor.proposeActivePPSOracle(ppsOracle1);
    vm.expectRevert(ISuperGovernor.TIMELOCK_NOT_EXPIRED.selector);
    superGovernor.executeActivePPSOracleChange();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeActivePPSOracle(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeActivePPSOracleChange()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ppsOracle1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_PPSOracleManagement_Revert_ExecuteBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing before timelock expiry
