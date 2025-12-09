# Function: test_UpkeepWithdrawn_EmitsCorrectWithdrawer()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpkeepWithdrawn_EmitsCorrectWithdrawer()`
- **Visibility**: public
- **Source Range**: 142108:1367:661

## Implementation

```solidity
/// @notice Test: UpkeepWithdrawn event is emitted with correct withdrawer (initiator)
function test_UpkeepWithdrawn_EmitsCorrectWithdrawer() public {
    uint256 depositAmount = 1000e18;
    MockUp(upToken).mint(manager, depositAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), depositAmount);
    superVaultAggregator.depositUpkeep(strategy, depositAmount);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepWithdrawn(strategy, manager, depositAmount);
    address randomExecutor = _deployAccount(0x92, "RandomExecutor");
    vm.prank(randomExecutor);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), 0);
    assertEq(IERC20(upToken).balanceOf(manager), depositAmount);
    assertEq(IERC20(upToken).balanceOf(randomExecutor), 0);
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
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **Vm::prank(address)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpkeepWithdrawn_EmitsCorrectWithdrawer() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x92, "RandomExecutor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [IERC20(upToken).balanceOf(manager), depositAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [IERC20(upToken).balanceOf(randomExecutor), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: UpkeepWithdrawn event is emitted with correct withdrawer (initiator)
