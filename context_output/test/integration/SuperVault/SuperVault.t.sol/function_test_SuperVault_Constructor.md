# Function: test_SuperVault_Constructor()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVault_Constructor()`
- **Visibility**: public
- **Source Range**: 6165:1279:580

## Implementation

```solidity
function test_SuperVault_Constructor() public {
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    SuperVault(payable(VmContractHelper590(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(0)))})));
    vm.prank(MANAGER);
    vm.expectEmit(true, true, true, true);
    emit Initializable.Initialized(type(uint64).max);
    SuperVault vault = SuperVault(payable(VmContractHelper590(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))})));
    assertEq(address(vault.SUPER_GOVERNOR()), address(superGovernor));
    SuperVault vaultError = SuperVault(payable(VmContractHelper590(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))})));
    vm.expectRevert(Initializable.InvalidInitialization.selector);
    vaultError.initialize(address(0), "SuperVault", "SV_USDC", address(strategy), address(escrow));
}
```

## Related Implementations

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper590::deployCode(string,bytes)**
- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVault::SUPER_GOVERNOR()**
- **SuperVault::initialize(address,string,string,address,address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVault_Constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
      💬 Args: [address(vault.SUPER_GOVERNOR()), address(superGovernor)]
      👁️  Def: internal
```
