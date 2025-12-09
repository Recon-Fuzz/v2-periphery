# Function: test_CreateVault_RevertInvalidAsset()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CreateVault_RevertInvalidAsset()`
- **Visibility**: public
- **Source Range**: 14934:811:661

## Implementation

```solidity
/// @notice Tests that createVault reverts when asset has no valid decimals function
function test_CreateVault_RevertInvalidAsset() public {
    MockAssetNoDecimals invalidAsset = new MockAssetNoDecimals("Invalid", "INV");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.INVALID_ASSET.selector);
    superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(invalidAsset), name: "Test Vault", symbol: "TEST", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CreateVault_RevertInvalidAsset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that createVault reverts when asset has no valid decimals function
