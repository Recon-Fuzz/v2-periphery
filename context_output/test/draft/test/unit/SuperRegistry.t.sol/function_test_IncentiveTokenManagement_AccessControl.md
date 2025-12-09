# Function: test_IncentiveTokenManagement_AccessControl()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_IncentiveTokenManagement_AccessControl()`
- **Visibility**: public
- **Source Range**: 14476:1476:568

## Implementation

```solidity
/// @notice Tests access control for proposing incentive token changes
function test_IncentiveTokenManagement_AccessControl() public {
    address[] memory tokens = new address[](1);
    tokens[0] = address(0x111);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, REGISTRY_ADMIN_ROLE));
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, REGISTRY_ADMIN_ROLE));
    superRegistry.proposeRemoveIncentiveTokens(tokens);
    vm.prank(superRegistryAdmin);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, superRegistryAdmin, REGISTRY_ADMIN_ROLE));
    superRegistry.proposeAddIncentiveTokens(tokens);
    vm.prank(superRegistryAdmin);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, superRegistryAdmin, REGISTRY_ADMIN_ROLE));
    superRegistry.proposeRemoveIncentiveTokens(tokens);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperRegistry::proposeAddIncentiveTokens(address[])**
- **SuperRegistry::proposeRemoveIncentiveTokens(address[])**

## State Variable Reads

- **user** (`address`)
- **REGISTRY_ADMIN_ROLE** (`bytes32`)
- **superRegistryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_IncentiveTokenManagement_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests access control for proposing incentive token changes
