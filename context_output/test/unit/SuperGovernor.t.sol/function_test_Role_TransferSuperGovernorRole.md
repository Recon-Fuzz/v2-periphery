# Function: test_Role_TransferSuperGovernorRole()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_Role_TransferSuperGovernorRole()`
- **Visibility**: public
- **Source Range**: 14756:3054:659

## Implementation

```solidity
/// @notice Tests transferring SUPER_GOVERNOR_ROLE to a new address after deployment
///  @dev Demonstrates the complete role transfer process including DEFAULT_ADMIN_ROLE
function test_Role_TransferSuperGovernorRole() public {
    address newSuperGovernor = _deployAccount(0x20, "NewSuperGovernor");
    bytes32 defaultAdminRole = superGovernor.DEFAULT_ADMIN_ROLE();
    assertTrue(superGovernor.hasRole(defaultAdminRole, sGovernor), "sGovernor should have DEFAULT_ADMIN_ROLE");
    assertTrue(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should have SUPER_GOVERNOR_ROLE");
    assertFalse(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, newSuperGovernor), "newSuperGovernor should not have SUPER_GOVERNOR_ROLE initially");
    vm.startPrank(sGovernor);
    superGovernor.grantRole(SUPER_GOVERNOR_ROLE, newSuperGovernor);
    assertTrue(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, newSuperGovernor), "newSuperGovernor should now have SUPER_GOVERNOR_ROLE");
    superGovernor.grantRole(defaultAdminRole, newSuperGovernor);
    assertTrue(superGovernor.hasRole(defaultAdminRole, newSuperGovernor), "newSuperGovernor should now have DEFAULT_ADMIN_ROLE");
    superGovernor.revokeRole(SUPER_GOVERNOR_ROLE, sGovernor);
    assertFalse(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should no longer have SUPER_GOVERNOR_ROLE");
    superGovernor.revokeRole(defaultAdminRole, sGovernor);
    vm.stopPrank();
    assertFalse(superGovernor.hasRole(defaultAdminRole, sGovernor), "sGovernor should no longer have DEFAULT_ADMIN_ROLE");
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, SUPER_GOVERNOR_ROLE));
    superGovernor.setAddress(TEST_KEY, user);
    vm.prank(newSuperGovernor);
    superGovernor.setAddress(TEST_KEY, user);
    assertEq(superGovernor.getAddress(TEST_KEY), user, "newSuperGovernor should be able to set address");
    address anotherAddress = _deployAccount(0x21, "AnotherAddress");
    vm.prank(newSuperGovernor);
    superGovernor.grantRole(GOVERNOR_ROLE, anotherAddress);
    assertTrue(superGovernor.hasRole(GOVERNOR_ROLE, anotherAddress), "newSuperGovernor should be able to grant GOVERNOR_ROLE");
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperGovernor::DEFAULT_ADMIN_ROLE()**
- **SuperGovernor::hasRole(bytes32,address)**
- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::revokeRole(bytes32,address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::getAddress(bytes32)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **TEST_KEY** (`bytes32`)
- **user** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_Role_TransferSuperGovernorRole() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "NewSuperGovernor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.hasRole(defaultAdminRole, sGovernor), "sGovernor should have DEFAULT_ADMIN_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should have SUPER_GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, newSuperGovernor), "newSuperGovernor should not have SUPER_GOVERNOR_ROLE initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, newSuperGovernor), "newSuperGovernor should now have SUPER_GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 6)
  │   💬 Args: [superGovernor.hasRole(defaultAdminRole, newSuperGovernor), "newSuperGovernor should now have DEFAULT_ADMIN_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 7)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should no longer have SUPER_GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 8)
  │   💬 Args: [superGovernor.hasRole(defaultAdminRole, sGovernor), "sGovernor should no longer have DEFAULT_ADMIN_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 9)
  │   💬 Args: [superGovernor.getAddress(TEST_KEY), user, "newSuperGovernor should be able to set address"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 10)
  │   💬 Args: [0x21, "AnotherAddress"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 11)
      💬 Args: [superGovernor.hasRole(GOVERNOR_ROLE, anotherAddress), "newSuperGovernor should be able to grant GOVERNOR_ROLE"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests transferring SUPER_GOVERNOR_ROLE to a new address after deployment
 @dev Demonstrates the complete role transfer process including DEFAULT_ADMIN_ROLE
