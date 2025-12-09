# Function: test_Constructor_ZeroAddressReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_Constructor_ZeroAddressReverts()`
- **Visibility**: public
- **Source Range**: 7328:480:622

## Implementation

```solidity
function test_Constructor_ZeroAddressReverts() public {
    vm.expectRevert(IECDSAPPSOracle.INVALID_VALIDATOR.selector);
    ECDSAPPSOracle(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(0), ECDSAPPS_ORACLE_KEY, ECDSAPPS_ORACLE_VERSION))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper620::deployCode(string,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_Constructor_ZeroAddressReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
