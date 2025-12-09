# Function: test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge()`
- **Visibility**: public
- **Source Range**: 235875:2768:661

## Implementation

```solidity
/// @notice Test that PPS updates succeed even when upkeep cost calculation fails (try-catch)
///  @dev Security fix: Validates resilience against oracle misconfiguration
function test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge() public {
    vm.startPrank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.stopPrank();
    vm.startPrank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    vm.warp(block.timestamp + 8 days);
    superGovernor.executeUpkeepPaymentsChange();
    vm.stopPrank();
    assertTrue(superGovernor.isUpkeepPaymentsEnabled(), "Upkeep payments should be enabled");
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = averageProvider;
    vm.startPrank(oracleManager);
    superGovernor.queueOracleProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1);
    ISuperOracle(superOracle).executeProviderRemoval();
    vm.stopPrank();
    uint256 initialPPS = superVaultAggregator.getPPS(strategy);
    vm.prank(manager);
    superVaultAggregator.updateDeviationThreshold(strategy, type(uint256).max);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = initialPPS * 2;
    timestamps[0] = block.timestamp + 100;
    vm.warp(timestamps[0]);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    assertEq(superVaultAggregator.getPPS(strategy), ppss[0], "PPS should have updated");
    uint256 finalBalance = superVaultAggregator.getUpkeepBalance(manager);
    assertEq(finalBalance, 0, "No upkeep should have been deducted");
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

- **Vm::startPrank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **Vm::stopPrank()**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **Vm::warp(uint256)**
- **SuperGovernor::executeUpkeepPaymentsChange()**
- **SuperGovernor::isUpkeepPaymentsEnabled()**
- **SuperGovernor::queueOracleProviderRemoval(bytes32[])**
- **ISuperOracle::executeProviderRemoval()**
- **SuperVaultAggregator::getPPS(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::getUpkeepBalance(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **oracleManager** (`address`)
- **superOracle** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isUpkeepPaymentsEnabled(), "Upkeep payments should be enabled"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getPPS(strategy), ppss[0], "PPS should have updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [finalBalance, 0, "No upkeep should have been deducted"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that PPS updates succeed even when upkeep cost calculation fails (try-catch)
 @dev Security fix: Validates resilience against oracle misconfiguration
