# Function: test_GetOracleDecimals_ConsistentResults()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleDecimals_ConsistentResults()`
- **Visibility**: public
- **Source Range**: 78166:498:624

## Implementation

```solidity
/// @notice Tests _getOracleDecimals consistency across multiple calls
///  @dev Verifies that decimals() returns consistent values
function test_GetOracleDecimals_ConsistentResults() public view {
    uint8 decimals1 = mockFeed1.decimals();
    uint8 decimals2 = mockFeed1.decimals();
    uint8 decimals3 = mockFeed1.decimals();
    assertEq(decimals1, decimals2, "First and second calls should match");
    assertEq(decimals2, decimals3, "Second and third calls should match");
    assertEq(decimals1, 8, "All calls should return 8");
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

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleDecimals_ConsistentResults() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [decimals1, decimals2, "First and second calls should match"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [decimals2, decimals3, "Second and third calls should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [decimals1, 8, "All calls should return 8"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getOracleDecimals consistency across multiple calls
 @dev Verifies that decimals() returns consistent values
