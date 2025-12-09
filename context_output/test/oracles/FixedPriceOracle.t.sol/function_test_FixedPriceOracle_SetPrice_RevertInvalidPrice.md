# Function: test_FixedPriceOracle_SetPrice_RevertInvalidPrice()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_SetPrice_RevertInvalidPrice()`
- **Visibility**: public
- **Source Range**: 2520:285:623

## Implementation

```solidity
/// @notice Test that zero/negative price cannot be set
function test_FixedPriceOracle_SetPrice_RevertInvalidPrice() public {
    vm.expectRevert(FixedPriceOracle.INVALID_PRICE.selector);
    fixedPriceOracle.setPrice(0);
    vm.expectRevert(FixedPriceOracle.INVALID_PRICE.selector);
    fixedPriceOracle.setPrice(-1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **FixedPriceOracle::setPrice(int256)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_SetPrice_RevertInvalidPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test that zero/negative price cannot be set
