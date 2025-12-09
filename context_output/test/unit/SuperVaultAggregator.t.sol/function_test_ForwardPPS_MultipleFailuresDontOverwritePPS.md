# Function: test_ForwardPPS_MultipleFailuresDontOverwritePPS()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_MultipleFailuresDontOverwritePPS()`
- **Visibility**: public
- **Source Range**: 229832:2752:661

## Implementation

```solidity
/// @notice Test that multiple consecutive validation failures don't overwrite PPS
function test_ForwardPPS_MultipleFailuresDontOverwritePPS() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    uint256 initialPPS = superVaultAggregator.getPPS(strategy);
    assertGt(initialPPS, 0, "Initial PPS should be greater than 0");
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, 1e16);
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = initialPPS * 2;
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    assertTrue(superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused after first failure");
    assertEq(superVaultAggregator.getPPS(strategy), initialPPS, "PPS should remain at initial value");
    vm.prank(mainManager);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.warp(block.timestamp + 10);
    ppss[0] = initialPPS / 2;
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    uint256 finalPPS = superVaultAggregator.getPPS(strategy);
    assertEq(finalPPS, initialPPS / 2, "PPS should be updated with escape hatch active");
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::getPPS(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_MultipleFailuresDontOverwritePPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initialPPS, 0, "Initial PPS should be greater than 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused after first failure"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.getPPS(strategy), initialPPS, "PPS should remain at initial value"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [finalPPS, initialPPS / 2, "PPS should be updated with escape hatch active"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that multiple consecutive validation failures don't overwrite PPS
