# Function: test_FeeManagement_Revert_ExecuteBeforeTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_FeeManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 80705:458:659

## Implementation

```solidity
/// @notice Tests reverting when executing a fee update before timelock expiry
function test_FeeManagement_Revert_ExecuteBeforeTimelock() public {
    FeeType feeType = FeeType.REVENUE_SHARE;
    uint256 feeValue = 50;
    vm.prank(sGovernor);
    superGovernor.proposeFee(feeType, feeValue);
    vm.expectRevert(abi.encodeWithSelector(ISuperGovernor.TIMELOCK_NOT_EXPIRED.selector));
    superGovernor.executeFeeUpdate(feeType);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeFee(enum FeeType,uint256)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::executeFeeUpdate(enum FeeType)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_FeeManagement_Revert_ExecuteBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing a fee update before timelock expiry
