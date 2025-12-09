# Function: test_ManagerTakeover_Revert_FrozenChangeAttempt()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ManagerTakeover_Revert_FrozenChangeAttempt()`
- **Visibility**: public
- **Source Range**: 22666:581:659

## Implementation

```solidity
/// @notice Tests reverting when trying to change manager after freeze
function test_ManagerTakeover_Revert_FrozenChangeAttempt() public {
    vm.prank(sGovernor);
    superGovernor.setAddress(SUPER_VAULT_AGGREGATOR, superVaultAggregator);
    vm.prank(sGovernor);
    superGovernor.freezeManagerTakeover();
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.MANAGER_TAKEOVERS_FROZEN.selector);
    superGovernor.changePrimaryManager(strategy1, newManager, manager);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::freezeManagerTakeover()**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)
- **superVaultAggregator** (`address`)
- **strategy1** (`address`)
- **newManager** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ManagerTakeover_Revert_FrozenChangeAttempt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when trying to change manager after freeze
