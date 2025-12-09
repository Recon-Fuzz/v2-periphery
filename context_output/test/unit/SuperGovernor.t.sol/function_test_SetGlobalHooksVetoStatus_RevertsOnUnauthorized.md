# Function: test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 41738:737:659

## Implementation

```solidity
/// @notice Tests setGlobalHooksRootVetoStatus reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:228 - onlyRole(_GUARDIAN_ROLE) modifier
function test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized() public {
    bytes32 guardianRole = superGovernor.GUARDIAN_ROLE();
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, guardianRole));
    superGovernor.setGlobalHooksRootVetoStatus(true);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, guardianRole));
    superGovernor.setGlobalHooksRootVetoStatus(true);
}
```

## External Calls

- **SuperGovernor::GUARDIAN_ROLE()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setGlobalHooksRootVetoStatus(bool)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **user** (`address`)
- **sGovernor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setGlobalHooksRootVetoStatus reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:228 - onlyRole(_GUARDIAN_ROLE) modifier
