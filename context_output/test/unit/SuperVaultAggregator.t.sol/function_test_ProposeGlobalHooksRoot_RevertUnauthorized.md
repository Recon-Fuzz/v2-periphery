# Function: test_ProposeGlobalHooksRoot_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeGlobalHooksRoot_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 45324:835:661

## Implementation

```solidity
/// @notice Tests that proposeGlobalHooksRoot reverts when caller is not SuperGovernor
function test_ProposeGlobalHooksRoot_RevertUnauthorized() public {
    bytes32 newRoot = keccak256("newHooksRoot");
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **secondaryManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeGlobalHooksRoot_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that proposeGlobalHooksRoot reverts when caller is not SuperGovernor
