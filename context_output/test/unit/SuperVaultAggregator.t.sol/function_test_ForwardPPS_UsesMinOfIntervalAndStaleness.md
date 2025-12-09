# Function: test_ForwardPPS_UsesMinOfIntervalAndStaleness()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_UsesMinOfIntervalAndStaleness()`
- **Visibility**: public
- **Source Range**: 212008:2470:661

## Implementation

```solidity
/// @notice Test 15: _forwardPPS uses min(minUpdateInterval, maxStaleness) for rate limiting
function test_ForwardPPS_UsesMinOfIntervalAndStaleness() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 200);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 200, "MinUpdateInterval should be 200");
    assertEq(superVaultAggregator.getMaxStaleness(strategy), 300, "MaxStaleness should be 300");
    uint256 lastUpdate = superVaultAggregator.getLastUpdateTimestamp(strategy);
    vm.warp(lastUpdate + 150);
    address[] memory strategies = new address[](1);
    strategies[0] = strategy;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = 1e18 + 1e15;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    vm.expectEmit(false, false, false, false);
    emit UpdateTooFrequent();
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    vm.warp(lastUpdate + 201);
    timestamps[0] = block.timestamp;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    assertEq(superVaultAggregator.getPPS(strategy), 1e18 + 1e15, "PPS should be updated");
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
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**
- **SuperVaultAggregator::getMinUpdateInterval(address)**
- **SuperVaultAggregator::getMaxStaleness(address)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::getPPS(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_UsesMinOfIntervalAndStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 200, "MinUpdateInterval should be 200"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getMaxStaleness(strategy), 300, "MaxStaleness should be 300"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [superVaultAggregator.getPPS(strategy), 1e18 + 1e15, "PPS should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 15: _forwardPPS uses min(minUpdateInterval, maxStaleness) for rate limiting
