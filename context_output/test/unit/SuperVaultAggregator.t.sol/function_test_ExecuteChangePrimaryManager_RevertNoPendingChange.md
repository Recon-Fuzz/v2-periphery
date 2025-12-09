# Function: test_ExecuteChangePrimaryManager_RevertNoPendingChange()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager_RevertNoPendingChange()`
- **Visibility**: public
- **Source Range**: 40083:281:661

## Implementation

```solidity
/// @notice Tests that executeChangePrimaryManager reverts when there's no pending manager change
function test_ExecuteChangePrimaryManager_RevertNoPendingChange() public {
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MANAGER_CHANGE.selector);
    superVaultAggregator.executeChangePrimaryManager(strategy);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager_RevertNoPendingChange() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that executeChangePrimaryManager reverts when there's no pending manager change
