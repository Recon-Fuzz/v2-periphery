# Function: test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal()`
- **Visibility**: public
- **Source Range**: 50554:289:661

## Implementation

```solidity
/// @notice Tests that executeStrategyHooksRootUpdate reverts when there's no pending proposal
function test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal() public {
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MANAGER_CHANGE.selector);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that executeStrategyHooksRootUpdate reverts when there's no pending proposal
