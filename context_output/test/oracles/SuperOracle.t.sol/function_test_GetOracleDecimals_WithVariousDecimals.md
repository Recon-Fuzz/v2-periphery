# Function: test_GetOracleDecimals_WithVariousDecimals()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleDecimals_WithVariousDecimals()`
- **Visibility**: public
- **Source Range**: 76668:583:624

## Implementation

```solidity
/// @notice Tests _getOracleDecimals with different decimal configurations
///  @dev Verifies the function works with various decimal values (6, 8, 18)
function test_GetOracleDecimals_WithVariousDecimals() public {
    MockAggregator feed6Dec = new MockAggregator(1e6, 6);
    MockAggregator feed8Dec = new MockAggregator(1e8, 8);
    MockAggregator feed18Dec = new MockAggregator(1e18, 18);
    assertEq(feed6Dec.decimals(), 6, "Should return 6 decimals");
    assertEq(feed8Dec.decimals(), 8, "Should return 8 decimals");
    assertEq(feed18Dec.decimals(), 18, "Should return 18 decimals");
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
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleDecimals_WithVariousDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [feed6Dec.decimals(), 6, "Should return 6 decimals"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [feed8Dec.decimals(), 8, "Should return 8 decimals"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [feed18Dec.decimals(), 18, "Should return 18 decimals"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getOracleDecimals with different decimal configurations
 @dev Verifies the function works with various decimal values (6, 8, 18)
