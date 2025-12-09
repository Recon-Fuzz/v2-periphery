# Function: test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees()`
- **Visibility**: public
- **Source Range**: 46999:1182:660

## Implementation

```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when fees > 0 and recipient is address(0)
///  @dev Covers SuperVaultStrategy.sol:124-127 (initialization validation that protects line 178)
function test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees() public {
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy.FeeConfig({performanceFeeBps: 0, managementFeeBps: 500, recipient: address(0)});
    bytes memory initData = abi.encodeWithSelector(SuperVaultStrategy.initialize.selector, address(vault), feeConfig);
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    new ERC1967Proxy(strategyImpl, initData);
}
```

## External Calls

- **VmContractHelper702::deployCode(string,bytes)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests SuperVaultStrategy initialize reverts when fees > 0 and recipient is address(0)
 @dev Covers SuperVaultStrategy.sol:124-127 (initialization validation that protects line 178)
