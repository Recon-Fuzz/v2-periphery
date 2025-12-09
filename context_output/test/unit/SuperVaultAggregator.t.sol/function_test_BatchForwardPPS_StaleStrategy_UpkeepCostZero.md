# Function: test_BatchForwardPPS_StaleStrategy_UpkeepCostZero()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_StaleStrategy_UpkeepCostZero()`
- **Visibility**: public
- **Source Range**: 121904:3541:661

## Implementation

```solidity
/// @notice Tests that batch PPS updates with stale strategy have upkeepCost set to 0
function test_BatchForwardPPS_StaleStrategy_UpkeepCostZero() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    vm.warp(block.timestamp + 7 days);
    superGovernor.executeUpkeepPaymentsChange();
    vm.prank(manager);
    (, address strategy2, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: manager, secondaryManagers: new address[](0), name: "Test Vault 2", symbol: "TV2", minUpdateInterval: 5, maxStaleness: 400, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 timestamp1 = superVaultAggregator.getLastUpdateTimestamp(strategy);
    uint256 timestamp2 = superVaultAggregator.getLastUpdateTimestamp(strategy2);
    vm.warp(block.timestamp + 450);
    address[] memory strategies = new address[](2);
    strategies[0] = strategy;
    strategies[1] = strategy2;
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = 1e18;
    ppss[1] = 1e18;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = timestamp1 + 150;
    timestamps[1] = timestamp2 + 40;
    address[] memory updateAuthorities = new address[](2);
    updateAuthorities[0] = user;
    updateAuthorities[1] = user;
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.StaleUpdate(strategy2, address(this), timestamps[1]);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    assertEq(superVaultAggregator.getLastUpdateTimestamp(strategy), 1, "Strategy timestamp should remain at creation time (stale)");
    assertEq(superVaultAggregator.getLastUpdateTimestamp(strategy2), 604_801, "Strategy2 timestamp should remain at creation time (stale)");
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

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **Vm::warp(uint256)**
- **SuperGovernor::executeUpkeepPaymentsChange()**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_StaleStrategy_UpkeepCostZero() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategy), 1, "Strategy timestamp should remain at creation time (stale)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategy2), 604_801, "Strategy2 timestamp should remain at creation time (stale)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that batch PPS updates with stale strategy have upkeepCost set to 0
