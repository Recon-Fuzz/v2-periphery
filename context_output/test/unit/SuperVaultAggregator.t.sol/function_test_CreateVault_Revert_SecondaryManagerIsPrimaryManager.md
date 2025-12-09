# Function: test_CreateVault_Revert_SecondaryManagerIsPrimaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_Revert_SecondaryManagerIsPrimaryManager()`
- **Visibility**: public
- **Source Range**: 16930:871:661

## Implementation

```solidity
/// @notice Tests that createVault reverts when secondary manager is already the primary manager
function test_CreateVault_Revert_SecondaryManagerIsPrimaryManager() public {
    address[] memory secondaryManagers = new address[](1);
    secondaryManagers[0] = manager;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.SECONDARY_MANAGER_CANNOT_BE_PRIMARY.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault Revert", symbol: "TVR", mainManager: manager, secondaryManagers: secondaryManagers, minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_Revert_SecondaryManagerIsPrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that createVault reverts when secondary manager is already the primary manager
