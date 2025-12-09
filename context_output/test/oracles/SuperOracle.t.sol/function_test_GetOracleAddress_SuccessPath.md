# Function: test_GetOracleAddress_SuccessPath()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_GetOracleAddress_SuccessPath()`
- **Visibility**: public
- **Source Range**: 66836:808:624

## Implementation

```solidity
/// @notice Tests getOracleAddress returns correct oracle for configured pair
///  @dev Covers SuperOracleBase.sol:186-190 - Success path (line 188)
function test_GetOracleAddress_SuccessPath() public view {
    address oracle = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    assertEq(oracle, address(mockFeed1), "Should return correct oracle address for PROVIDER_1");
    address oracle2 = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_2);
    assertEq(oracle2, address(mockFeed2), "Should return correct oracle address for PROVIDER_2");
    address oracle3 = superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_3);
    assertEq(oracle3, address(mockFeed3), "Should return correct oracle address for PROVIDER_3");
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **PROVIDER_1** (`bytes32`)
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **PROVIDER_2** (`bytes32`)
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **PROVIDER_3** (`bytes32`)
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_GetOracleAddress_SuccessPath() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [oracle, address(mockFeed1), "Should return correct oracle address for PROVIDER_1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [oracle2, address(mockFeed2), "Should return correct oracle address for PROVIDER_2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [oracle3, address(mockFeed3), "Should return correct oracle address for PROVIDER_3"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getOracleAddress returns correct oracle for configured pair
 @dev Covers SuperOracleBase.sol:186-190 - Success path (line 188)
