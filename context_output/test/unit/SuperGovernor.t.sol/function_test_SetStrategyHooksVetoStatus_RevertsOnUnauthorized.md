# Function: test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 44367:765:659

## Implementation

```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:236 - onlyRole(_GUARDIAN_ROLE) modifier
function test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized() public {
    bytes32 guardianRole = superGovernor.GUARDIAN_ROLE();
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, guardianRole));
    superGovernor.setStrategyHooksRootVetoStatus(strategy1, true);
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, guardianRole));
    superGovernor.setStrategyHooksRootVetoStatus(strategy1, true);
}
```

## External Calls

- **SuperGovernor::GUARDIAN_ROLE()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setStrategyHooksRootVetoStatus(address,bool)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **user** (`address`)
- **strategy1** (`address`)
- **sGovernor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setStrategyHooksRootVetoStatus reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:236 - onlyRole(_GUARDIAN_ROLE) modifier
