# Function: test_WithdrawUpkeep_RevertCases()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_WithdrawUpkeep_RevertCases()`
- **Visibility**: public
- **Source Range**: 127124:1221:661

## Implementation

```solidity
function test_WithdrawUpkeep_RevertCases() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep balance should be the same");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UPKEEP_WITHDRAWAL_NOT_FOUND.selector);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    vm.prank(manager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.prank(manager);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_AMOUNT.selector);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
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
- **Vm::stopPrank()**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::warp(uint256)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_WithdrawUpkeep_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Upkeep balance should be the same"]
      👁️  Def: internal
```
