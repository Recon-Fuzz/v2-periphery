# Function: test_StalenessBatchUpdate()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_StalenessBatchUpdate()`
- **Visibility**: public
- **Source Range**: 15530:693:624

## Implementation

```solidity
function test_StalenessBatchUpdate() public {
    address[] memory feeds = new address[](2);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    uint256[] memory stalenessList = new uint256[](2);
    stalenessList[0] = 6 hours;
    stalenessList[1] = 12 hours;
    superOracle.setFeedMaxStalenessBatch(feeds, stalenessList);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours, "Feed 1 staleness should be updated");
    assertEq(superOracle.feedMaxStaleness(address(mockFeed2)), 12 hours, "Feed 2 staleness should be updated");
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

- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**
- **SuperOracle::feedMaxStaleness(address)**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_StalenessBatchUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours, "Feed 1 staleness should be updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [superOracle.feedMaxStaleness(address(mockFeed2)), 12 hours, "Feed 2 staleness should be updated"]
      👁️  Def: internal
```
