# Function: test_ValidateProofs_RevertsOnZeroLengthProofs()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_ValidateProofs_RevertsOnZeroLengthProofs()`
- **Visibility**: public
- **Source Range**: 61617:493:622

## Implementation

```solidity
/// @notice Tests validateProofs reverts when proofs array is empty
///  @dev Covers ECDSAPPSOracle.sol:149 - ZERO_LENGTH_ARRAY check in _validateProofs
function test_ValidateProofs_RevertsOnZeroLengthProofs() public {
    bytes[] memory emptyProofs = new bytes[](0);
    vm.expectRevert(IECDSAPPSOracle.ZERO_LENGTH_ARRAY.selector);
    oracleECDSA.validateProofs(IECDSAPPSOracle.ValidationParams({strategy: address(svStrategy), proofs: emptyProofs, pps: PPS, timestamp: block.timestamp}));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **ECDSAPPSOracle::validateProofs(struct IECDSAPPSOracle.ValidationParams)**

## State Variable Reads

- **oracleECDSA** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **svStrategy** (`address`)
- **PPS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_ValidateProofs_RevertsOnZeroLengthProofs() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests validateProofs reverts when proofs array is empty
 @dev Covers ECDSAPPSOracle.sol:149 - ZERO_LENGTH_ARRAY check in _validateProofs
