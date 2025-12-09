# Function: test_MinStalenessManagement_Revert_ExecuteBeforeTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MinStalenessManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 95038:425:659

## Implementation

```solidity
/// @notice Tests reverting when executing before timelock expiry
function test_MinStalenessManagement_Revert_ExecuteBeforeTimelock() public {
    uint256 newMinStaleness = 600;
    vm.prank(sGovernor);
    superGovernor.proposeMinStaleness(newMinStaleness);
    vm.expectRevert(ISuperGovernor.TIMELOCK_NOT_EXPIRED.selector);
    superGovernor.executeMinStalenessChange();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::proposeMinStaleness(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeMinStalenessChange()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MinStalenessManagement_Revert_ExecuteBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing before timelock expiry
