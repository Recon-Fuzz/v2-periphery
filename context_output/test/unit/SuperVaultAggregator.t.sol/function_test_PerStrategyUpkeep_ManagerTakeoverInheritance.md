# Function: test_PerStrategyUpkeep_ManagerTakeoverInheritance()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_PerStrategyUpkeep_ManagerTakeoverInheritance()`
- **Visibility**: public
- **Source Range**: 137536:1760:661

## Implementation

```solidity
/// @notice Test: Manager takeover scenario - upkeep inheritance
function test_PerStrategyUpkeep_ManagerTakeoverInheritance() public {
    uint256 upkeepAmount = 1000e18;
    address newManager = _deployAccount(0x95, "NewManager");
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.stopPrank();
    vm.prank(secondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newManager, treasury);
    vm.warp((block.timestamp + 7 days) + 1);
    vm.prank(secondaryManager);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    assertEq(superVaultAggregator.getMainManager(strategy), newManager);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep should remain with strategy");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.prank(newManager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.prank(newManager);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), 0);
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_PerStrategyUpkeep_ManagerTakeoverInheritance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x95, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getMainManager(strategy), newManager]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep should remain with strategy"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Manager takeover scenario - upkeep inheritance
