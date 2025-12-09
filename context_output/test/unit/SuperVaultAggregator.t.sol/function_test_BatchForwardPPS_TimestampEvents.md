# Function: test_BatchForwardPPS_TimestampEvents()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_TimestampEvents()`
- **Visibility**: public
- **Source Range**: 106275:3821:661

## Implementation

```solidity
/// @notice Tests timestamp event emissions
function test_BatchForwardPPS_TimestampEvents() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.prank(manager);
    (, address strategy2, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: manager, secondaryManagers: new address[](0), name: "Test Vault 2", symbol: "TV2", minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    uint256 timestamp1 = superVaultAggregator.getLastUpdateTimestamp(strategy);
    uint256 timestamp2 = superVaultAggregator.getLastUpdateTimestamp(strategy2);
    address[] memory strategies = new address[](2);
    strategies[0] = strategy;
    strategies[1] = strategy2;
    uint256[] memory ppss = new uint256[](2);
    ppss[0] = 1e18;
    ppss[1] = 1e18;
    uint256[] memory timestamps = new uint256[](2);
    timestamps[0] = timestamp1 + 10 weeks;
    timestamps[1] = timestamp2 + 10;
    address[] memory updateAuthorities = new address[](2);
    updateAuthorities[0] = user;
    updateAuthorities[1] = user;
    uint256 timeBeforeUpdate1 = block.timestamp;
    vm.warp(timeBeforeUpdate1 + 10);
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    vm.warp(block.timestamp + 2 weeks);
    vm.prank(sGovernor);
    superGovernor.executeUpkeepPaymentsChange();
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.ProvidedTimestampExceedsBlockTimestamp(strategy, timestamps[0], block.timestamp);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    uint256 lastUpdate = superVaultAggregator.getLastUpdateTimestamp(strategy);
    timestamps[0] = lastUpdate + 2;
    timestamps[1] = lastUpdate + 2;
    vm.warp(timestamps[0] + 1);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.UpdateTooFrequent();
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
    timestamps[0] = timeBeforeUpdate1 + 20;
    timestamps[1] = timeBeforeUpdate1 + 20;
    vm.warp(block.timestamp + 1000 weeks);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.StaleUpdate(strategy, address(this), timestamps[0]);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **Vm::warp(uint256)**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **SuperGovernor::executeUpkeepPaymentsChange()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **strategy** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_TimestampEvents() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests timestamp event emissions
