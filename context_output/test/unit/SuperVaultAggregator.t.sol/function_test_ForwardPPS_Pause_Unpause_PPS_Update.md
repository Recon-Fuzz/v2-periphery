# Function: test_ForwardPPS_Pause_Unpause_PPS_Update()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_Pause_Unpause_PPS_Update()`
- **Visibility**: public
- **Source Range**: 196196:3334:661

## Implementation

```solidity
function test_ForwardPPS_Pause_Unpause_PPS_Update() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = 1e18 + 1e15;
    timestamps[0] = superVaultAggregator.getLastUpdateTimestamp(strategy) + 20;
    vm.warp(block.timestamp + 25);
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, 1);
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    bool isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertTrue(isPaused, "Strategy should be paused after invalid update");
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, type(uint256).max);
    ppss[0] = 1e18 + 1e15;
    timestamps[0] = superVaultAggregator.getLastUpdateTimestamp(strategy) + 20;
    vm.warp(block.timestamp + 25);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertTrue(isPaused, "Strategy should still be paused");
    vm.prank(mainManager);
    superVaultAggregator.unpauseStrategy(strategy);
    isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertFalse(isPaused, "Strategy should be unpaused after calling unpauseStrategy");
    vm.warp(block.timestamp + 10);
    ppss[0] = 1e18 + 1e15;
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    uint256 pps = superVaultAggregator.getPPS(strategy);
    assertEq(pps, 1e18 + 1e15, "PPS should be updated after successful update");
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
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **SuperVaultAggregator::getPPS(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_Pause_Unpause_PPS_Update() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [isPaused, "Strategy should be paused after invalid update"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [isPaused, "Strategy should still be paused"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [isPaused, "Strategy should be unpaused after calling unpauseStrategy"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [pps, 1e18 + 1e15, "PPS should be updated after successful update"]
      👁️  Def: internal
```
