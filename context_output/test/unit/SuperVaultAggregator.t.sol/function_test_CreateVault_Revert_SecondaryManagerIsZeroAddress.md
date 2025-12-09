# Function: test_CreateVault_Revert_SecondaryManagerIsZeroAddress()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_Revert_SecondaryManagerIsZeroAddress()`
- **Visibility**: public
- **Source Range**: 17807:848:661

## Implementation

```solidity
function test_CreateVault_Revert_SecondaryManagerIsZeroAddress() public {
    address[] memory secondaryManagers = new address[](1);
    secondaryManagers[0] = address(0);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_Revert_SecondaryManagerIsZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
