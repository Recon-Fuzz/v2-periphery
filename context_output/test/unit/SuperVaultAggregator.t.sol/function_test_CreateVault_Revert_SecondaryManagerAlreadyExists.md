# Function: test_CreateVault_Revert_SecondaryManagerAlreadyExists()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_Revert_SecondaryManagerAlreadyExists()`
- **Visibility**: public
- **Source Range**: 18661:913:661

## Implementation

```solidity
function test_CreateVault_Revert_SecondaryManagerAlreadyExists() public {
    address[] memory secondaryManagers = new address[](2);
    secondaryManagers[0] = secondaryManager;
    secondaryManagers[1] = secondaryManager;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MANAGER_ALREADY_EXISTS.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault Revert", symbol: "TVR", mainManager: manager, secondaryManagers: secondaryManagers, minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **secondaryManager** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_Revert_SecondaryManagerAlreadyExists() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
