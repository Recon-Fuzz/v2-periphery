# Function: test_UpdateDeviationThreshold_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpdateDeviationThreshold_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 36893:939:661

## Implementation

```solidity
/// @notice Tests that updateDeviationThreshold reverts when caller is not main manager
function test_UpdateDeviationThreshold_RevertUnauthorized() public {
    uint256 newThreshold = 500;
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.updateDeviationThreshold(strategy, newThreshold);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.updateDeviationThreshold(strategy, newThreshold);
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.updateDeviationThreshold(strategy, newThreshold);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpdateDeviationThreshold_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that updateDeviationThreshold reverts when caller is not main manager
