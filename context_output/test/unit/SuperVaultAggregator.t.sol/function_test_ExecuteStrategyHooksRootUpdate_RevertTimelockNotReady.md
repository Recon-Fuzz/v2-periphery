# Function: test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady()`
- **Visibility**: public
- **Source Range**: 50944:868:661

## Implementation

```solidity
/// @notice Tests that executeStrategyHooksRootUpdate reverts when timelock hasn't expired
function test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady() public {
    bytes32 newRoot = keccak256("newStrategyHooksRoot");
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
    vm.expectRevert(ISuperVaultAggregator.ROOT_UPDATE_NOT_READY.selector);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    uint256 timelock = superVaultAggregator.getHooksRootUpdateTimelock();
    vm.warp((block.timestamp + timelock) - 1);
    vm.expectRevert(ISuperVaultAggregator.ROOT_UPDATE_NOT_READY.selector);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **Vm::warp(uint256)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that executeStrategyHooksRootUpdate reverts when timelock hasn't expired
