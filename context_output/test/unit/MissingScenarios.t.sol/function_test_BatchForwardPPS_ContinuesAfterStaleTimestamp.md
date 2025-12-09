# Function: test_BatchForwardPPS_ContinuesAfterStaleTimestamp()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_BatchForwardPPS_ContinuesAfterStaleTimestamp()`
- **Visibility**: public
- **Source Range**: 11569:1951:657

## Implementation

```solidity
/// @notice Tests batch forwardPPS continues after stale timestamp
///  @dev Verifies graceful degradation: batch continues even if one update is stale
function test_BatchForwardPPS_ContinuesAfterStaleTimestamp() public {
    vm.prank(manager);
    (, address strategy2Address, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(ecdsaPPSOracle));
    vm.warp(1000);
    uint256 currentTime = block.timestamp;
    address[] memory strategies = new address[](2);
    strategies[0] = address(strategy);
    strategies[1] = strategy2Address;
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = 1.1e18;
    ppss[1] = 1.1e18;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = currentTime - 400;
    timestamps[1] = currentTime;
    vm.prank(address(ecdsaPPSOracle));
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.StaleUpdate(address(strategy), manager, timestamps[0]);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: manager}));
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperGovernor::setActivePPSOracle(address)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ecdsaPPSOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_BatchForwardPPS_ContinuesAfterStaleTimestamp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batch forwardPPS continues after stale timestamp
 @dev Verifies graceful degradation: batch continues even if one update is stale
