# Function: test_BatchForwardPPS_ContinuesAfterUnknownStrategy()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_BatchForwardPPS_ContinuesAfterUnknownStrategy()`
- **Visibility**: public
- **Source Range**: 7170:2103:657

## Implementation

```solidity
/// @notice Tests batch forwardPPS continues processing after encountering an unknown strategy
///  @dev Verifies graceful degradation: batch continues even if one strategy is invalid
function test_BatchForwardPPS_ContinuesAfterUnknownStrategy() public {
    vm.prank(manager);
    (, address strategy2Address, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault 2", symbol: "TV2", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(ecdsaPPSOracle));
    address[] memory strategies = new address[](3);
    strategies[0] = address(strategy);
    strategies[1] = address(0xDEAD);
    strategies[2] = strategy2Address;
    uint256[] memory ppss = new uint256[](3);
    ppss[0] = 1.1e18;
    ppss[1] = 1.1e18;
    ppss[2] = 1.1e18;
    uint256[] memory timestamps = new uint256[](3);
    timestamps[0] = block.timestamp;
    timestamps[1] = block.timestamp;
    timestamps[2] = block.timestamp;
    vm.prank(address(ecdsaPPSOracle));
    vm.expectEmit(true, false, false, false);
    emit ISuperVaultAggregator.UnknownStrategy(address(0xDEAD));
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: manager}));
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperGovernor::setActivePPSOracle(address)**
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
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_BatchForwardPPS_ContinuesAfterUnknownStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batch forwardPPS continues processing after encountering an unknown strategy
 @dev Verifies graceful degradation: batch continues even if one strategy is invalid
