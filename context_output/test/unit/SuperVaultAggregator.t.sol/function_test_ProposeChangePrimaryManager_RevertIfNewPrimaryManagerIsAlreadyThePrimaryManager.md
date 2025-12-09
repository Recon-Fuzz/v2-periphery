# Function: test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()`
- **Visibility**: public
- **Source Range**: 80345:416:661

## Implementation

```solidity
/// @notice Tests that proposeChangePrimaryManager reverts if new primary manager is already the primary manager
function test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() public {
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    vm.prank(secondaryManagers[0]);
    vm.expectRevert(ISuperVaultAggregator.MANAGER_ALREADY_EXISTS.selector);
    superVaultAggregator.proposeChangePrimaryManager(strategy, manager, treasury);
}
```

## External Calls

- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that proposeChangePrimaryManager reverts if new primary manager is already the primary manager
