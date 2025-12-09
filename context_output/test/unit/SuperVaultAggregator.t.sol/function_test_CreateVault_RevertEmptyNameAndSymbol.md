# Function: test_CreateVault_RevertEmptyNameAndSymbol()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_RevertEmptyNameAndSymbol()`
- **Visibility**: public
- **Source Range**: 14123:716:661

## Implementation

```solidity
/// @notice Tests that createVault reverts when both name and symbol are empty
function test_CreateVault_RevertEmptyNameAndSymbol() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.INVALID_VAULT_PARAMS.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "", symbol: "", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_RevertEmptyNameAndSymbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that createVault reverts when both name and symbol are empty
