# Function: test_ForwardPPS_SkipsC1CheckWhenStale()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_SkipsC1CheckWhenStale()`
- **Visibility**: public
- **Source Range**: 223313:2062:661

## Implementation

```solidity
/// @notice Test that first PPS update after unpause skips C1 deviation check
function test_ForwardPPS_SkipsC1CheckWhenStale() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.pauseStrategy(strategy);
    assertTrue(superVaultAggregator.isPPSStale(strategy), "PPS should be stale after pause");
    vm.prank(mainManager);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, 1e15);
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = 5e17;
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    uint256 currentPPS = superVaultAggregator.getPPS(strategy);
    assertEq(currentPPS, 5e17, "PPS should be updated despite large deviation when stale");
    assertFalse(superVaultAggregator.isPPSStale(strategy), "PPS should not be stale after valid update");
    assertFalse(superVaultAggregator.isStrategyPaused(strategy), "Strategy should not be paused");
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **SuperVaultAggregator::isPPSStale(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::getPPS(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_SkipsC1CheckWhenStale() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.isPPSStale(strategy), "PPS should be stale after pause"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [currentPPS, 5e17, "PPS should be updated despite large deviation when stale"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isPPSStale(strategy), "PPS should not be stale after valid update"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isStrategyPaused(strategy), "Strategy should not be paused"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that first PPS update after unpause skips C1 deviation check
