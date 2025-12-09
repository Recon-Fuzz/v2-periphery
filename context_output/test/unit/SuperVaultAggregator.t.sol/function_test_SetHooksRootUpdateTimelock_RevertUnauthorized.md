# Function: test_SetHooksRootUpdateTimelock_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SetHooksRootUpdateTimelock_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 44390:837:661

## Implementation

```solidity
/// @notice Tests that setHooksRootUpdateTimelock reverts when caller is not SuperGovernor
function test_SetHooksRootUpdateTimelock_RevertUnauthorized() public {
    uint256 newTimelock = 14 days;
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setHooksRootUpdateTimelock(newTimelock);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setHooksRootUpdateTimelock(newTimelock);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.setHooksRootUpdateTimelock(newTimelock);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::setHooksRootUpdateTimelock(uint256)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **secondaryManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SetHooksRootUpdateTimelock_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that setHooksRootUpdateTimelock reverts when caller is not SuperGovernor
