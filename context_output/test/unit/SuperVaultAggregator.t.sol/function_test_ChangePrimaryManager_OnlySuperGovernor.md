# Function: test_ChangePrimaryManager_OnlySuperGovernor()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_OnlySuperGovernor()`
- **Visibility**: public
- **Source Range**: 98439:1225:661

## Implementation

```solidity
/// @notice Tests that only SuperGovernor can call changePrimaryManager
function test_ChangePrimaryManager_OnlySuperGovernor() public {
    address newManager = _deployAccount(0x16, "NewManager");
    address feeRecipient = _deployAccount(0x2D, "FeeRecipient");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, newManager, feeRecipient);
    address currentManager = superVaultAggregator.getMainManager(strategy);
    assertEq(currentManager, newManager, "New manager should be set");
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

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getMainManager(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **user** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_OnlySuperGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x16, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x2D, "FeeRecipient"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [currentManager, newManager, "New manager should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that only SuperGovernor can call changePrimaryManager
