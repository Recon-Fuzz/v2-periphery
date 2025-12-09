# Function: test_FixedPriceOracle_SetDecimals()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_SetDecimals()`
- **Visibility**: public
- **Source Range**: 2857:203:623

## Implementation

```solidity
/// @notice Test decimals update by owner
function test_FixedPriceOracle_SetDecimals() public {
    uint8 newDecimals = 8;
    fixedPriceOracle.setDecimals(newDecimals);
    assertEq(fixedPriceOracle.decimals(), newDecimals);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **FixedPriceOracle::setDecimals(uint8)**
- **FixedPriceOracle::decimals()**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_SetDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [fixedPriceOracle.decimals(), newDecimals]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test decimals update by owner
