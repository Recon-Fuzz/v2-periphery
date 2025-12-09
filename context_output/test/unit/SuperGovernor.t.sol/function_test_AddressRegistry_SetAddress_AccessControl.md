# Function: test_AddressRegistry_SetAddress_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_AddressRegistry_SetAddress_AccessControl()`
- **Visibility**: public
- **Source Range**: 19099:585:659

## Implementation

```solidity
/// @notice Tests setting an address with SUPER_GOVERNOR_ROLE.
function test_AddressRegistry_SetAddress_AccessControl() public {
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, SUPER_GOVERNOR_ROLE));
    superGovernor.setAddress(TEST_KEY, user);
    vm.prank(sGovernor);
    superGovernor.setAddress(TEST_KEY, user);
    assertEq(superGovernor.getAddress(TEST_KEY), user);
}
```

## Related Implementations

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::getAddress(bytes32)**

## State Variable Reads

- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TEST_KEY** (`bytes32`)
- **user** (`address`)
- **sGovernor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_AddressRegistry_SetAddress_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [superGovernor.getAddress(TEST_KEY), user]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setting an address with SUPER_GOVERNOR_ROLE.
