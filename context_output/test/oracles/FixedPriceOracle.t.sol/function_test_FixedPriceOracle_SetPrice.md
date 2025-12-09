# Function: test_FixedPriceOracle_SetPrice()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_SetPrice()`
- **Visibility**: public
- **Source Range**: 1927:249:623

## Implementation

```solidity
/// @notice Test price update by owner
function test_FixedPriceOracle_SetPrice() public {
    int256 newPrice = 0.1e18;
    fixedPriceOracle.setPrice(newPrice);
    (, int256 answer, , , ) = fixedPriceOracle.latestRoundData();
    assertEq(answer, newPrice);
}
```

## Related Implementations

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **FixedPriceOracle::setPrice(int256)**
- **FixedPriceOracle::latestRoundData()**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_SetPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 1)
      💬 Args: [answer, newPrice]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test price update by owner
