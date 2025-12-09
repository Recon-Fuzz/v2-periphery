# Function: test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset()`
- **Visibility**: public
- **Source Range**: 50095:1514:660

## Implementation

```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when asset has invalid decimals
function test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset() public {
    MockAssetNoDecimals invalidAsset = new MockAssetNoDecimals("Invalid Asset", "INVALID");
    Mock4626Vault mockVault = new Mock4626Vault(address(asset), "Mock Vault", "MVAULT");
    mockVault.setAsset(address(invalidAsset));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 500, recipient: manager});
    bytes memory initData = abi.encodeWithSelector(SuperVaultStrategy.initialize.selector, address(mockVault), feeConfig);
    vm.expectRevert(ISuperVaultStrategy.INVALID_ASSET.selector);
    new ERC1967Proxy(strategyImpl, initData);
}
```

## External Calls

- **Mock4626Vault::setAsset(address)**
- **VmContractHelper702::deployCode(string,bytes)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests SuperVaultStrategy initialize reverts when asset has invalid decimals
