# Function: test_SetFeedMaxStalenessBatch_SingleElement()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStalenessBatch_SingleElement()`
- **Visibility**: public
- **Source Range**: 64509:389:624

## Implementation

```solidity
/// @notice Tests batch staleness update with single element
///  @dev Covers SuperOracleBase.sol:141 - loop with length=1 (boundary case)
function test_SetFeedMaxStalenessBatch_SingleElement() public {
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed1);
    uint256[] memory staleness = new uint256[](1);
    staleness[0] = 8 hours;
    superOracle.setFeedMaxStalenessBatch(feeds, staleness);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), 8 hours);
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
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStalenessBatch_SingleElement() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), 8 hours]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batch staleness update with single element
 @dev Covers SuperOracleBase.sol:141 - loop with length=1 (boundary case)
