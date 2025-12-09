# Function: test_AddSecondaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AddSecondaryManager()`
- **Visibility**: public
- **Source Range**: 77404:1075:661

## Implementation

```solidity
function test_AddSecondaryManager() public {
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.addSecondaryManager(strategy, manager);
    vm.startPrank(manager);
    vm.expectRevert(ISuperVaultAggregator.SECONDARY_MANAGER_CANNOT_BE_PRIMARY.selector);
    superVaultAggregator.addSecondaryManager(strategy, manager);
    vm.stopPrank();
    address newSecondaryManager = _deployAccount(0x10, "NewSecondaryManager");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 2, "Should have 2 secondary managers");
    vm.prank(manager);
    superVaultAggregator.removeSecondaryManager(strategy, newSecondaryManager);
    secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 1, "Should have 1 secondary manager");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::getSecondaryManagers(address)**
- **SuperVaultAggregator::removeSecondaryManager(address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AddSecondaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x10, "NewSecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [secondaryManagers.length, 2, "Should have 2 secondary managers"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [secondaryManagers.length, 1, "Should have 1 secondary manager"]
      👁️  Def: internal
```
