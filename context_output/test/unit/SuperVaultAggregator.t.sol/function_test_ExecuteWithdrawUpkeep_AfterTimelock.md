# Function: test_ExecuteWithdrawUpkeep_AfterTimelock()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteWithdrawUpkeep_AfterTimelock()`
- **Visibility**: public
- **Source Range**: 174150:1470:661

## Implementation

```solidity
/// @notice Tests successful withdrawal execution after timelock
function test_ExecuteWithdrawUpkeep_AfterTimelock() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    vm.warp((block.timestamp + 24 hours) + 1);
    uint256 managerBalBefore = IERC20(upToken).balanceOf(manager);
    vm.prank(user);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepWithdrawn(strategy, manager, upkeepAmount);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(IERC20(upToken).balanceOf(manager), managerBalBefore + upkeepAmount, "Manager should receive upkeep");
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), 0, "Strategy upkeep should be zero");
    (uint256 amount, uint256 effectiveTime) = superVaultAggregator.pendingUpkeepWithdrawals(strategy);
    assertEq(amount, 0, "Amount should be zero");
    assertEq(effectiveTime, 0, "Effective time should be zero");
}
```

## Related Implementations

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

- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **IERC20::balanceOf(address)**
- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **SuperVaultAggregator::pendingUpkeepWithdrawals(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteWithdrawUpkeep_AfterTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [IERC20(upToken).balanceOf(manager), managerBalBefore + upkeepAmount, "Manager should receive upkeep"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0, "Strategy upkeep should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [amount, 0, "Amount should be zero"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [effectiveTime, 0, "Effective time should be zero"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests successful withdrawal execution after timelock
