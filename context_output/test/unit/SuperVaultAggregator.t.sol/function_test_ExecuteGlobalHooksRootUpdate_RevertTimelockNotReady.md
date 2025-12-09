# Function: test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady()`
- **Visibility**: public
- **Source Range**: 46642:840:661

## Implementation

```solidity
/// @notice Tests that executeGlobalHooksRootUpdate reverts when timelock hasn't expired
function test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady() public {
    bytes32 newRoot = keccak256("newHooksRoot");
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    vm.expectRevert(ISuperVaultAggregator.ROOT_UPDATE_NOT_READY.selector);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    uint256 timelock = superVaultAggregator.getHooksRootUpdateTimelock();
    vm.warp((block.timestamp + timelock) - 1);
    vm.expectRevert(ISuperVaultAggregator.ROOT_UPDATE_NOT_READY.selector);
    superVaultAggregator.executeGlobalHooksRootUpdate();
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **Vm::warp(uint256)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that executeGlobalHooksRootUpdate reverts when timelock hasn't expired
