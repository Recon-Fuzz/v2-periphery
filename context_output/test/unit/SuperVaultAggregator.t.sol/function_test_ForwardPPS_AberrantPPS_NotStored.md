# Function: test_ForwardPPS_AberrantPPS_NotStored()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_AberrantPPS_NotStored()`
- **Visibility**: public
- **Source Range**: 218623:1735:661

## Implementation

```solidity
/// @notice Test that aberrant PPS is NOT stored when validation fails
function test_ForwardPPS_AberrantPPS_NotStored() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    uint256 initialPPS = superVaultAggregator.getPPS(strategy);
    assertEq(initialPPS, 1e18, "Initial PPS should be 1e18");
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = 10e18;
    timestamps[0] = block.timestamp;
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, 1e17);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    assertTrue(superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused");
    uint256 currentPPS = superVaultAggregator.getPPS(strategy);
    assertEq(currentPPS, initialPPS, "Aberrant PPS should NOT be stored");
    assertTrue(superVaultAggregator.isPPSStale(strategy), "PPS should be stale after auto-pause");
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::getPPS(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::isPPSStale(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_AberrantPPS_NotStored() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initialPPS, 1e18, "Initial PPS should be 1e18"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [currentPPS, initialPPS, "Aberrant PPS should NOT be stored"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isPPSStale(strategy), "PPS should be stale after auto-pause"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that aberrant PPS is NOT stored when validation fails
