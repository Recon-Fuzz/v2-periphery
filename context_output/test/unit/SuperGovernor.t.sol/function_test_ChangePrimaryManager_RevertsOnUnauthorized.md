# Function: test_ChangePrimaryManager_RevertsOnUnauthorized()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangePrimaryManager_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 24447:1026:659

## Implementation

```solidity
/// @notice Tests changePrimaryManager reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:185 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
function test_ChangePrimaryManager_RevertsOnUnauthorized() public {
    vm.prank(sGovernor);
    superGovernor.setAddress(SUPER_VAULT_AGGREGATOR, superVaultAggregator);
    address feeRecipient = _deployAccount(0x2D, "FeeRecipient");
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, SUPER_GOVERNOR_ROLE));
    superGovernor.changePrimaryManager(strategy1, newManager, feeRecipient);
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, SUPER_GOVERNOR_ROLE));
    superGovernor.changePrimaryManager(strategy1, newManager, feeRecipient);
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

- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)
- **superVaultAggregator** (`address`)
- **governor** (`address`)
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **strategy1** (`address`)
- **newManager** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangePrimaryManager_RevertsOnUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x2D, "FeeRecipient"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests changePrimaryManager reverts when called by unauthorized user
 @dev Covers SuperGovernor.sol:185 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
