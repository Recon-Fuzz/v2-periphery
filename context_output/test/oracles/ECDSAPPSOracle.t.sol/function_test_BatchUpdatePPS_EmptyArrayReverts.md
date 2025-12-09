# Function: test_BatchUpdatePPS_EmptyArrayReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_BatchUpdatePPS_EmptyArrayReverts()`
- **Visibility**: public
- **Source Range**: 54561:754:622

## Implementation

```solidity
/// @notice Fuzz test for insufficient gas check with varying parameters
function test_BatchUpdatePPS_EmptyArrayReverts() public {
    address[] memory strategies = new address[](0);
    bytes[][] memory proofsArray = new bytes[][](0);
    uint256[] memory ppss = new uint256[](0);
    uint256[] memory timestamps = new uint256[](0);
    vm.prank(user);
    vm.expectRevert(IECDSAPPSOracle.ZERO_LENGTH_ARRAY.selector);
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **user** (`address`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_BatchUpdatePPS_EmptyArrayReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Fuzz test for insufficient gas check with varying parameters
