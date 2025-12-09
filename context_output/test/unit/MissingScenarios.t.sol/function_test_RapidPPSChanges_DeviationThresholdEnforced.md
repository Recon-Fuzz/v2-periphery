# Function: test_RapidPPSChanges_DeviationThresholdEnforced()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_RapidPPSChanges_DeviationThresholdEnforced()`
- **Visibility**: public
- **Source Range**: 28035:1601:657

## Implementation

```solidity
/// @notice Tests behavior under rapid PPS changes with deviation threshold
///  @dev Verifies slippage protection when PPS changes rapidly
function test_RapidPPSChanges_DeviationThresholdEnforced() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(ecdsaPPSOracle));
    vm.prank(manager);
    superVaultAggregator.updateDeviationThreshold(address(strategy), 500);
    uint256 initialPPS = superVaultAggregator.getPPS(address(strategy));
    vm.warp(block.timestamp + 10);
    uint256 highPPS = (initialPPS * 120) / 100;
    address[] memory strategies = new address[](1);
    strategies[0] = address(strategy);
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = highPPS;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    vm.prank(address(ecdsaPPSOracle));
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: manager}));
    bool isPaused = superVaultAggregator.isStrategyPaused(address(strategy));
    assertTrue(isPaused, "Strategy should be paused after exceeding deviation threshold");
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **SuperVaultAggregator::getPPS(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**

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
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_RapidPPSChanges_DeviationThresholdEnforced() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [isPaused, "Strategy should be paused after exceeding deviation threshold"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests behavior under rapid PPS changes with deviation threshold
 @dev Verifies slippage protection when PPS changes rapidly
