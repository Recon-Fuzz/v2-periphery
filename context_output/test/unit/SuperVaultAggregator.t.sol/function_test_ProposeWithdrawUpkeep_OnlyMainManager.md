# Function: test_ProposeWithdrawUpkeep_OnlyMainManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeWithdrawUpkeep_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 173297:778:661

## Implementation

```solidity
/// @notice Tests that only main manager can propose withdrawal
function test_ProposeWithdrawUpkeep_OnlyMainManager() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.prank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    vm.prank(manager);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, address(0x999));
    vm.prank(address(0x999));
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
}
```

## External Calls

- **MockUp::mint(address,uint256)**
- **Vm::prank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeWithdrawUpkeep_OnlyMainManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that only main manager can propose withdrawal
