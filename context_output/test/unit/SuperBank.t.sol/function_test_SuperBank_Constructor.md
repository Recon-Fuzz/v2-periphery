# Function: test_SuperBank_Constructor()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_Constructor()`
- **Visibility**: public
- **Source Range**: 5125:461:658

## Implementation

```solidity
function test_SuperBank_Constructor() public {
    assertEq(address(superBank.SUPER_GOVERNOR()), address(superGovernor), "SuperGovernor address not set correctly");
    vm.expectRevert(ISuperBank.INVALID_ADDRESS.selector);
    SuperBank(payable(VmContractHelper689(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(0)))})));
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperBank::SUPER_GOVERNOR()**
- **Vm::expectRevert(bytes4)**
- **VmContractHelper689::deployCode(string,bytes)**

## State Variable Reads

- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_Constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [address(superBank.SUPER_GOVERNOR()), address(superGovernor), "SuperGovernor address not set correctly"]
      👁️  Def: internal
```
