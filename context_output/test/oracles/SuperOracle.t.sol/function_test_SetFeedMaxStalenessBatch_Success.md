# Function: test_SetFeedMaxStalenessBatch_Success()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStalenessBatch_Success()`
- **Visibility**: public
- **Source Range**: 63673:684:624

## Implementation

```solidity
/// @notice Tests batch staleness update success path
///  @dev Covers SuperOracleBase.sol:134 (success path), 141-142 (for loop in batch update)
function test_SetFeedMaxStalenessBatch_Success() public {
    address[] memory feeds = new address[](3);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    feeds[2] = address(mockFeed3);
    uint256[] memory staleness = new uint256[](3);
    staleness[0] = 6 hours;
    staleness[1] = 12 hours;
    staleness[2] = 18 hours;
    superOracle.setFeedMaxStalenessBatch(feeds, staleness);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed2)), 12 hours);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed3)), 18 hours);
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

- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**
- **SuperOracle::feedMaxStaleness(address)**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStalenessBatch_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [superOracle.feedMaxStaleness(address(mockFeed2)), 12 hours]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [superOracle.feedMaxStaleness(address(mockFeed3)), 18 hours]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batch staleness update success path
 @dev Covers SuperOracleBase.sol:134 (success path), 141-142 (for loop in batch update)
