# Function: test_UpdatePPS_EmptyProofsArrayReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_EmptyProofsArrayReverts()`
- **Visibility**: public
- **Source Range**: 33253:983:622

## Implementation

```solidity
function test_UpdatePPS_EmptyProofsArrayReverts() public {
    bytes[] memory emptyProofs = new bytes[](0);
    vm.expectEmit(true, false, false, false);
    emit IECDSAPPSOracle.ProofValidationFailedLowLevel(address(svStrategy), abi.encodeWithSelector(IECDSAPPSOracle.ZERO_LENGTH_ARRAY.selector));
    address[] memory strategies = new address[](1);
    strategies[0] = address(svStrategy);
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = emptyProofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    oracleECDSA.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
}
```

## External Calls

- **Vm::expectEmit(bool,bool,bool,bool)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **svStrategy** (`address`)
- **PPS** (`uint256`)
- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_EmptyProofsArrayReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
