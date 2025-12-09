# Function: test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw()`
- **Visibility**: public
- **Source Range**: 131582:1336:661

## Implementation

```solidity
/// @notice Test: Secondary manager attempts withdrawUpkeep() → reverts
function test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep should be unchanged");
    vm.prank(manager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.prank(manager);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), 0, "MainManager should be able to withdraw");
}
```

## Related Implementations

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
- **Vm::stopPrank()**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep should be unchanged"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0, "MainManager should be able to withdraw"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Secondary manager attempts withdrawUpkeep() → reverts
