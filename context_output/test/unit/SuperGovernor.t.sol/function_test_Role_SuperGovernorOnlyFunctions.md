# Function: test_Role_SuperGovernorOnlyFunctions()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_Role_SuperGovernorOnlyFunctions()`
- **Visibility**: public
- **Source Range**: 13206:482:659

## Implementation

```solidity
/// @notice Tests that only SUPER_GOVERNOR_ROLE can call SUPER_GOVERNOR_ROLE functions.
function test_Role_SuperGovernorOnlyFunctions() public {
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, SUPER_GOVERNOR_ROLE));
    superGovernor.setAddress(TEST_KEY, user);
    vm.prank(sGovernor);
    superGovernor.setAddress(TEST_KEY, user);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setAddress(bytes32,address)**

## State Variable Reads

- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TEST_KEY** (`bytes32`)
- **user** (`address`)
- **sGovernor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_Role_SuperGovernorOnlyFunctions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that only SUPER_GOVERNOR_ROLE can call SUPER_GOVERNOR_ROLE functions.
