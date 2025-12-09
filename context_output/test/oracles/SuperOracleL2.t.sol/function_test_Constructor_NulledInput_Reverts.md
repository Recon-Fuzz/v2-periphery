# Function: test_Constructor_NulledInput_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_Constructor_NulledInput_Reverts()`
- **Visibility**: public
- **Source Range**: 4309:754:625

## Implementation

```solidity
function test_Constructor_NulledInput_Reverts() public {
    address[] memory bases = new address[](1);
    address[] memory quotes = new address[](1);
    bytes32[] memory providers = new bytes32[](1);
    address[] memory feeds = new address[](1);
    bases[0] = address(0);
    quotes[0] = address(0);
    providers[0] = bytes32(0);
    feeds[0] = address(0);
    vm.expectRevert();
    SuperOracleL2(payable(VmContractHelper623(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracleL2.sol:SuperOracleL2", _args: encodeArgs596(DeployHelper596.FoundryPpConstructorArgs(owner, bases, quotes, providers, feeds))})));
}
```

## External Calls

- **Vm::expectRevert()**
- **VmContractHelper623::deployCode(string,bytes)**

## State Variable Reads

- **owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_Constructor_NulledInput_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
