# Function: test_BatchForwardPPS_Revert_NonMonotonicTimestamp()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_Revert_NonMonotonicTimestamp()`
- **Visibility**: public
- **Source Range**: 103816:2405:661

## Implementation

```solidity
/// @notice Tests that batch PPS updates with non-monotonic timestamps are rejected
function test_BatchForwardPPS_Revert_NonMonotonicTimestamp() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.prank(manager);
    (, address strategy2, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: manager, secondaryManagers: new address[](0), name: "Test Vault 2", symbol: "TV2", minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 timestamp1 = superVaultAggregator.getLastUpdateTimestamp(strategy);
    uint256 timestamp2 = superVaultAggregator.getLastUpdateTimestamp(strategy2);
    address[] memory strategies = new address[](2);
    strategies[0] = strategy;
    strategies[1] = strategy2;
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = 1e18;
    ppss[1] = 1e18;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = timestamp1 + 10;
    timestamps[1] = timestamp2 - 1;
    address[] memory updateAuthorities = new address[](2);
    updateAuthorities[0] = user;
    updateAuthorities[1] = user;
    vm.warp(block.timestamp + 10);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.TimestampNotMonotonic();
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    assertEq(superVaultAggregator.getLastUpdateTimestamp(strategy), timestamp1 + 10, "timestamp 1");
    assertEq(superVaultAggregator.getLastUpdateTimestamp(strategy2), timestamp2, "timestamp 2 should not change");
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
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **Vm::warp(uint256)**
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_Revert_NonMonotonicTimestamp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategy), timestamp1 + 10, "timestamp 1"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategy2), timestamp2, "timestamp 2 should not change"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that batch PPS updates with non-monotonic timestamps are rejected
