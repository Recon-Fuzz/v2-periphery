# Function: test_GetOracleDecimals_ReturnsCorrectDecimals()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleDecimals_ReturnsCorrectDecimals()`
- **Visibility**: public
- **Source Range**: 75930:573:624

## Implementation

```solidity
/// @notice Tests _getOracleDecimals returns correct decimals from oracle
///  @dev Covers SuperOracleBase.sol:514-516 - _getOracleDecimals function
function test_GetOracleDecimals_ReturnsCorrectDecimals() public view {
    uint8 decimals1 = mockFeed1.decimals();
    assertEq(decimals1, 8, "mockFeed1 should have 8 decimals");
    uint8 decimals2 = mockFeed2.decimals();
    assertEq(decimals2, 8, "mockFeed2 should have 8 decimals");
    uint8 decimals3 = mockFeed3.decimals();
    assertEq(decimals3, 8, "mockFeed3 should have 8 decimals");
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
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleDecimals_ReturnsCorrectDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [decimals1, 8, "mockFeed1 should have 8 decimals"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [decimals2, 8, "mockFeed2 should have 8 decimals"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [decimals3, 8, "mockFeed3 should have 8 decimals"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getOracleDecimals returns correct decimals from oracle
 @dev Covers SuperOracleBase.sol:514-516 - _getOracleDecimals function
