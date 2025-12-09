# Function: test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()`
- **Visibility**: public
- **Source Range**: 78590:305:661

## Implementation

```solidity
/// @notice Tests changePrimaryManager reverts if new primary manager is already the primary manager
function test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() public {
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.MANAGER_ALREADY_EXISTS.selector);
    superVaultAggregator.changePrimaryManager(strategy, manager, treasury);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests changePrimaryManager reverts if new primary manager is already the primary manager
