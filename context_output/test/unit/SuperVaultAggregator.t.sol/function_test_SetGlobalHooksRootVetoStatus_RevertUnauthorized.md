# Function: test_SetGlobalHooksRootVetoStatus_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SetGlobalHooksRootVetoStatus_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 47585:835:661

## Implementation

```solidity
/// @notice Tests that setGlobalHooksRootVetoStatus reverts when caller is not SuperGovernor
function test_SetGlobalHooksRootVetoStatus_RevertUnauthorized() public {
    bool vetoStatus = true;
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setGlobalHooksRootVetoStatus(vetoStatus);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setGlobalHooksRootVetoStatus(vetoStatus);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setGlobalHooksRootVetoStatus(vetoStatus);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::setGlobalHooksRootVetoStatus(bool)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **secondaryManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SetGlobalHooksRootVetoStatus_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that setGlobalHooksRootVetoStatus reverts when caller is not SuperGovernor
