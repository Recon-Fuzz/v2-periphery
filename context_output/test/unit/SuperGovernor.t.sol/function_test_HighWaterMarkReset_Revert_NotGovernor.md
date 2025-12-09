# Function: test_HighWaterMarkReset_Revert_NotGovernor()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HighWaterMarkReset_Revert_NotGovernor()`
- **Visibility**: public
- **Source Range**: 28235:301:659

## Implementation

```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the caller is not the SuperGovernor
function test_HighWaterMarkReset_Revert_NotGovernor() public {
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, SUPER_GOVERNOR_ROLE));
    superGovernor.resetHighWaterMark(strategy1);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **user** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HighWaterMarkReset_Revert_NotGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests resetting the high-water mark PPS to the current PPS when the caller is not the SuperGovernor
