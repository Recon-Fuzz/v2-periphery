# Function: test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress()`
- **Visibility**: public
- **Source Range**: 42460:496:660

## Implementation

```solidity
/// @notice Tests SuperVaultStrategy constructor reverts when superGovernor is address(0)
function test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress() public {
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(0)))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper702::deployCode(string,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests SuperVaultStrategy constructor reverts when superGovernor is address(0)
