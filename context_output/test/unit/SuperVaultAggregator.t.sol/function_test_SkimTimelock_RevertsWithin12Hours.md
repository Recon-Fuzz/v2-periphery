# Function: test_SkimTimelock_RevertsWithin12Hours()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SkimTimelock_RevertsWithin12Hours()`
- **Visibility**: public
- **Source Range**: 220425:2800:661

## Implementation

```solidity
/// @notice Test that skim reverts within 12h of unpause
function test_SkimTimelock_RevertsWithin12Hours() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.pauseStrategy(strategy);
    assertTrue(superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused");
    vm.prank(mainManager);
    superVaultAggregator.unpauseStrategy(strategy);
    uint256 lastUnpause = superVaultAggregator.getLastUnpauseTimestamp(strategy);
    assertEq(lastUnpause, block.timestamp, "lastUnpauseTimestamp should be set");
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = 1e18 + 1e15;
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    vm.warp(block.timestamp + 6 hours);
    vm.prank(mainManager);
    vm.expectRevert(ISuperVaultStrategy.SKIM_TIMELOCK_ACTIVE.selector);
    ISuperVaultStrategy(strategy).skimPerformanceFee();
    vm.warp(lastUnpause + 13 hours);
    vm.prank(mainManager);
    try ISuperVaultStrategy(strategy).skimPerformanceFee() {} catch (bytes memory reason) {
        bytes4 selector = bytes4(reason);
        assertTrue(selector != ISuperVaultStrategy.SKIM_TIMELOCK_ACTIVE.selector, "Should not revert with SKIM_TIMELOCK_ACTIVE after 12h");
    }
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **SuperVaultAggregator::getLastUnpauseTimestamp(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **Vm::expectRevert(bytes4)**
- **ISuperVaultStrategy::skimPerformanceFee()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SkimTimelock_RevertsWithin12Hours() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(strategy), "Strategy should be paused"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [lastUnpause, block.timestamp, "lastUnpauseTimestamp should be set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [selector != ISuperVaultStrategy.SKIM_TIMELOCK_ACTIVE.selector, "Should not revert with SKIM_TIMELOCK_ACTIVE after 12h"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that skim reverts within 12h of unpause
