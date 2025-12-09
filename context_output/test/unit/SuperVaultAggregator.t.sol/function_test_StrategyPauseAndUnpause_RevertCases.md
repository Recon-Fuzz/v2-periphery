# Function: test_StrategyPauseAndUnpause_RevertCases()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_StrategyPauseAndUnpause_RevertCases()`
- **Visibility**: public
- **Source Range**: 125636:953:661

## Implementation

```solidity
function test_StrategyPauseAndUnpause_RevertCases() public {
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.pauseStrategy(strategy);
    vm.startPrank(manager);
    superVaultAggregator.pauseStrategy(strategy);
    vm.expectRevert(ISuperVaultAggregator.STRATEGY_ALREADY_PAUSED.selector);
    superVaultAggregator.pauseStrategy(strategy);
    vm.stopPrank();
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.startPrank(manager);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.expectRevert(ISuperVaultAggregator.STRATEGY_NOT_PAUSED.selector);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.stopPrank();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::unpauseStrategy(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_StrategyPauseAndUnpause_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
