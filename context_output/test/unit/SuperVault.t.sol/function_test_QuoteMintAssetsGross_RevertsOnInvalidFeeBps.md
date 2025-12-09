# Function: test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps()`
- **Visibility**: public
- **Source Range**: 80294:1138:660

## Implementation

```solidity
/// @notice Tests quoteMintAssetsGross reverts when feeBps >= BPS_PRECISION
///  @dev Covers SuperVaultStrategy.sol:243
function test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps() public {
    vm.prank(manager);
    (, address strategyAddress, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Invalid Fee Vault", symbol: "IFV", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 0, managementFeeBps: 10_000, recipient: manager})}));
    SuperVaultStrategy testStrategy = SuperVaultStrategy(payable(strategyAddress));
    vm.expectRevert(ISuperVaultStrategy.INVALID_AMOUNT.selector);
    testStrategy.quoteMintAssetsGross(100e18);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::quoteMintAssetsGross(uint256)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests quoteMintAssetsGross reverts when feeBps >= BPS_PRECISION
 @dev Covers SuperVaultStrategy.sol:243
