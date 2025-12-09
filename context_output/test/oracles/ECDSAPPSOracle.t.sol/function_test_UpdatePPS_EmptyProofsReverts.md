# Function: test_UpdatePPS_EmptyProofsReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_EmptyProofsReverts()`
- **Visibility**: public
- **Source Range**: 34242:1236:622

## Implementation

```solidity
function test_UpdatePPS_EmptyProofsReverts() public {
    bytes[] memory proofs = new bytes[](0);
    vm.prank(user);
    vm.expectEmit(true, false, false, false);
    emit IECDSAPPSOracle.ProofValidationFailedLowLevel(address(svStrategy), abi.encodeWithSelector(IECDSAPPSOracle.ZERO_LENGTH_ARRAY.selector));
    address[] memory strategies = new address[](1);
    strategies[0] = address(svStrategy);
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory validatorSets = new uint256[](1);
    validatorSets[0] = 0;
    uint256[] memory totalValidators = new uint256[](1);
    totalValidators[0] = 3;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **user** (`address`)
- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_EmptyProofsReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
