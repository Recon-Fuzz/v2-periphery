# Function: test_PerStrategyUpkeep_PermissionlessDeposit()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_PerStrategyUpkeep_PermissionlessDeposit()`
- **Visibility**: public
- **Source Range**: 136458:1003:661

## Implementation

```solidity
/// @notice Test: Anyone can deposit upkeep to any strategy (permissionless)
function test_PerStrategyUpkeep_PermissionlessDeposit() public {
    address randomDepositor = _deployAccount(0x96, "RandomDepositor");
    uint256 depositAmount = 500e18;
    MockUp(upToken).mint(randomDepositor, depositAmount);
    vm.startPrank(randomDepositor);
    IERC20(upToken).approve(address(superVaultAggregator), depositAmount);
    superVaultAggregator.depositUpkeep(strategy, depositAmount);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), depositAmount);
    vm.prank(manager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.prank(manager);
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
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **upToken** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_PerStrategyUpkeep_PermissionlessDeposit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x96, "RandomDepositor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), depositAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Anyone can deposit upkeep to any strategy (permissionless)
