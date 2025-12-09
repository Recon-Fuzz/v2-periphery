# Function: test_HandleMint_RevertCases()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_HandleMint_RevertCases()`
- **Visibility**: public
- **Source Range**: 15162:736:580

## Implementation

```solidity
function test_HandleMint_RevertCases() public {
    uint256 shares = 1000e6;
    uint256 assetsNet = vault.previewMint(shares);
    uint256 assetsGross = vault.convertToAssets(shares);
    vm.expectRevert(ISuperVaultStrategy.ACCESS_DENIED.selector);
    strategy.handleOperations4626Mint(accountEth, shares, assetsGross, assetsNet);
    vm.prank(address(vault));
    vm.expectRevert(ISuperVaultStrategy.INVALID_AMOUNT.selector);
    strategy.handleOperations4626Mint(accountEth, 0, assetsGross, assetsNet);
    vm.prank(address(vault));
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    strategy.handleOperations4626Mint(address(0), shares, assetsGross, assetsNet);
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::convertToAssets(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::handleOperations4626Mint(address,uint256,uint256,uint256)**
- **Vm::prank(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_HandleMint_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
