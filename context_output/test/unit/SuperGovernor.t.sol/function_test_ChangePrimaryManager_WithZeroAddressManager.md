# Function: test_ChangePrimaryManager_WithZeroAddressManager()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangePrimaryManager_WithZeroAddressManager()`
- **Visibility**: public
- **Source Range**: 27035:562:659

## Implementation

```solidity
/// @notice Tests changePrimaryManager with zero address as new manager
///  @dev Tests edge case with zero address (should be caught by aggregator, not SuperGovernor)
function test_ChangePrimaryManager_WithZeroAddressManager() public {
    vm.prank(sGovernor);
    superGovernor.setAddress(SUPER_VAULT_AGGREGATOR, superVaultAggregator);
    vm.prank(sGovernor);
    vm.expectRevert();
    superGovernor.changePrimaryManager(strategy1, address(0), manager);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert()**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)
- **superVaultAggregator** (`address`)
- **strategy1** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangePrimaryManager_WithZeroAddressManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests changePrimaryManager with zero address as new manager
 @dev Tests edge case with zero address (should be caught by aggregator, not SuperGovernor)
