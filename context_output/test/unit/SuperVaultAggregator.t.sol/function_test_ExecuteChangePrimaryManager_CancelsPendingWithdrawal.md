# Function: test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal()`
- **Visibility**: public
- **Source Range**: 179406:1475:661

## Implementation

```solidity
/// @notice Tests that democratic transition cancels pending withdrawal
function test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal() public {
    uint256 upkeepAmount = 1000e18;
    address newSecondaryManager = address(0x5EC);
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    vm.prank(newSecondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newSecondaryManager, treasury);
    vm.warp((block.timestamp + 7 days) + 1);
    vm.expectEmit(true, false, false, false);
    emit ISuperVaultAggregator.UpkeepWithdrawalCancelled(strategy);
    superVaultAggregator.executeChangePrimaryManager(strategy);
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
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **SuperVaultAggregator::pendingUpkeepWithdrawals(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [amount, 0, "Amount should be zero"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, 0, "Effective time should be zero"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that democratic transition cancels pending withdrawal
