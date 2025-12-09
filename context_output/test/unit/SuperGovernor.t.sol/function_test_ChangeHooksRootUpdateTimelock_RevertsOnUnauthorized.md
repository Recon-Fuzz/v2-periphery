# Function: test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 36590:696:659

## Implementation

```solidity
/// @notice Tests changeHooksRootUpdateTimelock reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:209 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
function test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized() public {
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, SUPER_GOVERNOR_ROLE));
    superGovernor.changeHooksRootUpdateTimelock(100);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, SUPER_GOVERNOR_ROLE));
    superGovernor.changeHooksRootUpdateTimelock(100);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::changeHooksRootUpdateTimelock(uint256)**

## State Variable Reads

- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests changeHooksRootUpdateTimelock reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:209 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
