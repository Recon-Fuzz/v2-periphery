# Function: test_SetActivePPSOracle_Revert_MustUseTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetActivePPSOracle_Revert_MustUseTimelock()`
- **Visibility**: public
- **Source Range**: 68404:317:659

## Implementation

```solidity
function test_SetActivePPSOracle_Revert_MustUseTimelock() public {
    vm.startPrank(sGovernor);
    superGovernor.setActivePPSOracle(ppsOracle1);
    vm.expectRevert(ISuperGovernor.MUST_USE_TIMELOCK_FOR_CHANGE.selector);
    superGovernor.setActivePPSOracle(ppsOracle1);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **Vm::expectRevert(bytes4)**
- **Vm::stopPrank()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ppsOracle1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetActivePPSOracle_Revert_MustUseTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
