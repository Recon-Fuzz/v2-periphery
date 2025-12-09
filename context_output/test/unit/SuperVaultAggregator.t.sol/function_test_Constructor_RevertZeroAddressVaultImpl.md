# Function: test_Constructor_RevertZeroAddressVaultImpl()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_Constructor_RevertZeroAddressVaultImpl()`
- **Visibility**: public
- **Source Range**: 8433:974:661

## Implementation

```solidity
/// @notice Tests that constructor reverts when vaultImpl is zero address
function test_Constructor_RevertZeroAddressVaultImpl() public {
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    SuperVaultAggregator(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), address(0), strategyImpl, escrowImpl))})));
}
```

## External Calls

- **VmContractHelper703::deployCode(string,bytes)**
- **VmContractHelper703::deployCode(string)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_Constructor_RevertZeroAddressVaultImpl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that constructor reverts when vaultImpl is zero address
