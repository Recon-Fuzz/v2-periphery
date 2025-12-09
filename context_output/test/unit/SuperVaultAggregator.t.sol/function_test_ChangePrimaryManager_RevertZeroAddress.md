# Function: test_ChangePrimaryManager_RevertZeroAddress()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 99740:263:661

## Implementation

```solidity
/// @notice Tests emergency replacement with zero address reverts
function test_ChangePrimaryManager_RevertZeroAddress() public {
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    superVaultAggregator.changePrimaryManager(strategy, address(0), manager);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_RevertZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests emergency replacement with zero address reverts
