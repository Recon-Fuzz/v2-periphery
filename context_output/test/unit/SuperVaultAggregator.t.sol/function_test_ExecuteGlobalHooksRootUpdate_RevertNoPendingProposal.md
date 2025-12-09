# Function: test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal()`
- **Visibility**: public
- **Source Range**: 46262:281:661

## Implementation

```solidity
/// @notice Tests that executeGlobalHooksRootUpdate reverts when there's no pending proposal
function test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal() public {
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_GLOBAL_ROOT_CHANGE.selector);
    superVaultAggregator.executeGlobalHooksRootUpdate();
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that executeGlobalHooksRootUpdate reverts when there's no pending proposal
