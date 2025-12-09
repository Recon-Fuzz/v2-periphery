# Function: test_ProposeStrategyHooksRoot_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeStrategyHooksRoot_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 49519:930:661

## Implementation

```solidity
/// @notice Tests that proposeStrategyHooksRoot reverts when caller is not main manager
function test_ProposeStrategyHooksRoot_RevertUnauthorized() public {
    bytes32 newRoot = keccak256("newStrategyHooksRoot");
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeStrategyHooksRoot_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that proposeStrategyHooksRoot reverts when caller is not main manager
