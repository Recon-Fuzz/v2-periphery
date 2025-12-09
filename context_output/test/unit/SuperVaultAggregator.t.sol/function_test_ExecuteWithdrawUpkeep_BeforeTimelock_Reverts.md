# Function: test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts()`
- **Visibility**: public
- **Source Range**: 175687:739:661

## Implementation

```solidity
/// @notice Tests that execution before timelock reverts
function test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    vm.warp(block.timestamp + 23 hours);
    vm.expectRevert(ISuperVaultAggregator.UPKEEP_WITHDRAWAL_NOT_READY.selector);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
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
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that execution before timelock reverts
