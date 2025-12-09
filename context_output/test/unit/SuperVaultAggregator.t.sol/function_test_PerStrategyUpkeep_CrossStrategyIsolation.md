# Function: test_PerStrategyUpkeep_CrossStrategyIsolation()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_PerStrategyUpkeep_CrossStrategyIsolation()`
- **Visibility**: public
- **Source Range**: 133896:2475:661

## Implementation

```solidity
/// @notice Test: Cross-strategy isolation - strategies cannot affect each other
function test_PerStrategyUpkeep_CrossStrategyIsolation() public {
    vm.prank(manager);
    (, address strategy2, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 upkeep1 = 1000e18;
    uint256 upkeep2 = 2000e18;
    MockUp(upToken).mint(manager, upkeep1 + upkeep2);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeep1 + upkeep2);
    superVaultAggregator.depositUpkeep(strategy, upkeep1);
    superVaultAggregator.depositUpkeep(strategy2, upkeep2);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeep1, "Strategy 1 should have upkeep1");
    assertEq(superVaultAggregator.getUpkeepBalance(strategy2), upkeep2, "Strategy 2 should have upkeep2");
    vm.prank(manager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    vm.prank(manager);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), 0, "Strategy 1 should be empty");
    assertEq(superVaultAggregator.getUpkeepBalance(strategy2), upkeep2, "Strategy 2 should be UNCHANGED");
    MockUp(upToken).mint(manager, upkeep1);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeep1);
    superVaultAggregator.depositUpkeep(strategy, upkeep1);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeep1);
    assertEq(superVaultAggregator.getUpkeepBalance(strategy2), upkeep2);
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

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **upToken** (`address`)
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_PerStrategyUpkeep_CrossStrategyIsolation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeep1, "Strategy 1 should have upkeep1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy2), upkeep2, "Strategy 2 should have upkeep2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), 0, "Strategy 1 should be empty"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy2), upkeep2, "Strategy 2 should be UNCHANGED"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeep1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy2), upkeep2]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Cross-strategy isolation - strategies cannot affect each other
