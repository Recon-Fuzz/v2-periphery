# Function: test_ChangePrimaryManager_CancelsPendingWithdrawal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_CancelsPendingWithdrawal()`
- **Visibility**: public
- **Source Range**: 177756:1568:661

## Implementation

```solidity
/// @notice Tests that governance takeover cancels pending withdrawal
function test_ChangePrimaryManager_CancelsPendingWithdrawal() public {
    uint256 upkeepAmount = 1000e18;
    address newManager = address(0xB0B);
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    (uint256 amount, uint256 effectiveTime) = superVaultAggregator.pendingUpkeepWithdrawals(strategy);
    assertEq(amount, upkeepAmount, "Amount should match balance");
    assertEq(effectiveTime, block.timestamp + 24 hours, "Effective time should be 24h later");
    vm.prank(address(superGovernor));
    vm.expectEmit(true, false, false, false);
    emit ISuperVaultAggregator.UpkeepWithdrawalCancelled(strategy);
    superVaultAggregator.changePrimaryManager(strategy, newManager, treasury);
    (, effectiveTime) = superVaultAggregator.pendingUpkeepWithdrawals(strategy);
    assertEq(effectiveTime, 0, "Effective time should be zero");
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.expectRevert(ISuperVaultAggregator.UPKEEP_WITHDRAWAL_NOT_FOUND.selector);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
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
- **SuperVaultAggregator::pendingUpkeepWithdrawals(address)**
- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_CancelsPendingWithdrawal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [amount, upkeepAmount, "Amount should match balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime, block.timestamp + 24 hours, "Effective time should be 24h later"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [effectiveTime, 0, "Effective time should be zero"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that governance takeover cancels pending withdrawal
