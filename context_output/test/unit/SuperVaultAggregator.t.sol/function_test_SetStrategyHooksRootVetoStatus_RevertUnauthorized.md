# Function: test_SetStrategyHooksRootVetoStatus_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SetStrategyHooksRootVetoStatus_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 51917:873:661

## Implementation

```solidity
/// @notice Tests that setStrategyHooksRootVetoStatus reverts when caller is not SuperGovernor
function test_SetStrategyHooksRootVetoStatus_RevertUnauthorized() public {
    bool vetoStatus = true;
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, vetoStatus);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, vetoStatus);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, vetoStatus);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::setStrategyHooksRootVetoStatus(address,bool)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **secondaryManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SetStrategyHooksRootVetoStatus_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that setStrategyHooksRootVetoStatus reverts when caller is not SuperGovernor
