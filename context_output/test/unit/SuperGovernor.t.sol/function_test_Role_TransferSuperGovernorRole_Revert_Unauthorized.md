# Function: test_Role_TransferSuperGovernorRole_Revert_Unauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_Role_TransferSuperGovernorRole_Revert_Unauthorized()`
- **Visibility**: public
- **Source Range**: 17889:570:659

## Implementation

```solidity
/// @notice Tests that non-admin cannot transfer SUPER_GOVERNOR_ROLE
function test_Role_TransferSuperGovernorRole_Revert_Unauthorized() public {
    address newSuperGovernor = _deployAccount(0x22, "NewSuperGovernor2");
    bytes32 defaultAdminRole = superGovernor.DEFAULT_ADMIN_ROLE();
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, defaultAdminRole));
    superGovernor.grantRole(SUPER_GOVERNOR_ROLE, newSuperGovernor);
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

## External Calls

- **SuperGovernor::DEFAULT_ADMIN_ROLE()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::grantRole(bytes32,address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_Role_TransferSuperGovernorRole_Revert_Unauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x22, "NewSuperGovernor2"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that non-admin cannot transfer SUPER_GOVERNOR_ROLE
