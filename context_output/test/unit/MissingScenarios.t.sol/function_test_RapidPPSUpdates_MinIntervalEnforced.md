# Function: test_RapidPPSUpdates_MinIntervalEnforced()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_RapidPPSUpdates_MinIntervalEnforced()`
- **Visibility**: public
- **Source Range**: 29785:2173:657

## Implementation

```solidity
/// @notice Tests that multiple rapid PPS updates within minUpdateInterval are rejected
///  @dev Verifies rate limiting on PPS updates
function test_RapidPPSUpdates_MinIntervalEnforced() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(ecdsaPPSOracle));
    vm.prank(manager);
    superVaultAggregator.updateDeviationThreshold(address(strategy), type(uint256).max);
    vm.warp(100);
    address[] memory strategies = new address[](1);
    strategies[0] = address(strategy);
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = 1.01e18;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    vm.prank(address(ecdsaPPSOracle));
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: manager}));
    uint256 ppsAfterFirst = superVaultAggregator.getPPS(address(strategy));
    assertEq(ppsAfterFirst, 1.01e18, "First update should have succeeded");
    vm.warp(block.timestamp + 2);
    ppss[0] = 1.02e18;
    timestamps[0] = block.timestamp;
    vm.prank(address(ecdsaPPSOracle));
    vm.expectEmit(false, false, false, false);
    emit ISuperVaultAggregator.UpdateTooFrequent();
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: manager}));
    uint256 ppsAfterSecond = superVaultAggregator.getPPS(address(strategy));
    assertEq(ppsAfterSecond, ppsAfterFirst, "PPS should be unchanged after too-soon update");
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
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::getPPS(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ecdsaPPSOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_RapidPPSUpdates_MinIntervalEnforced() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [ppsAfterFirst, 1.01e18, "First update should have succeeded"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [ppsAfterSecond, ppsAfterFirst, "PPS should be unchanged after too-soon update"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that multiple rapid PPS updates within minUpdateInterval are rejected
 @dev Verifies rate limiting on PPS updates
