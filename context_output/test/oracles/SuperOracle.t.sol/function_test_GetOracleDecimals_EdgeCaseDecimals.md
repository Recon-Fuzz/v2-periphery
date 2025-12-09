# Function: test_GetOracleDecimals_EdgeCaseDecimals()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleDecimals_EdgeCaseDecimals()`
- **Visibility**: public
- **Source Range**: 77405:616:624

## Implementation

```solidity
/// @notice Tests _getOracleDecimals with edge case decimal values
///  @dev Tests minimum (0) and maximum (18) decimal values commonly used
function test_GetOracleDecimals_EdgeCaseDecimals() public {
    MockAggregator feed0Dec = new MockAggregator(1000, 0);
    assertEq(feed0Dec.decimals(), 0, "Should return 0 decimals");
    MockAggregator feed18Dec = new MockAggregator(1e18, 18);
    assertEq(feed18Dec.decimals(), 18, "Should return 18 decimals");
    MockAggregator feed1Dec = new MockAggregator(10, 1);
    assertEq(feed1Dec.decimals(), 1, "Should return 1 decimal");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **MockAggregator::decimals()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleDecimals_EdgeCaseDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [feed0Dec.decimals(), 0, "Should return 0 decimals"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [feed18Dec.decimals(), 18, "Should return 18 decimals"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [feed1Dec.decimals(), 1, "Should return 1 decimal"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getOracleDecimals with edge case decimal values
 @dev Tests minimum (0) and maximum (18) decimal values commonly used
