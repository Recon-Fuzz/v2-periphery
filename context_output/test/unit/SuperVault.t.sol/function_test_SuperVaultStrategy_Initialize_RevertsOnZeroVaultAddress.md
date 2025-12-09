# Function: test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress()`
- **Visibility**: public
- **Source Range**: 43054:1158:660

## Implementation

```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when vaultAddress is address(0)
function test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress() public {
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 500, recipient: manager});
    bytes memory initData = abi.encodeWithSelector(SuperVaultStrategy.initialize.selector, address(0), feeConfig);
    vm.expectRevert(ISuperVaultStrategy.INVALID_VAULT.selector);
    new ERC1967Proxy(strategyImpl, initData);
}
```

## External Calls

- **VmContractHelper702::deployCode(string,bytes)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests SuperVaultStrategy initialize reverts when vaultAddress is address(0)
