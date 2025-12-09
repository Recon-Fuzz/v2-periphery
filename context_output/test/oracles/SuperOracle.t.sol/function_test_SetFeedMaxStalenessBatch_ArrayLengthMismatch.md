# Function: test_SetFeedMaxStalenessBatch_ArrayLengthMismatch()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStalenessBatch_ArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 62975:539:624

## Implementation

```solidity
/// @notice Tests setFeedMaxStalenessBatch with mismatched array lengths
///  @dev Covers SuperOracleBase.sol:137-138 - if (length != newMaxStalenessList.length)
function test_SetFeedMaxStalenessBatch_ArrayLengthMismatch() public {
    address[] memory feeds = new address[](3);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    feeds[2] = address(mockFeed3);
    uint256[] memory staleness = new uint256[](2);
    staleness[0] = 6 hours;
    staleness[1] = 12 hours;
    vm.expectRevert(ISuperOracle.ARRAY_LENGTH_MISMATCH.selector);
    superOracle.setFeedMaxStalenessBatch(feeds, staleness);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStalenessBatch_ArrayLengthMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setFeedMaxStalenessBatch with mismatched array lengths
 @dev Covers SuperOracleBase.sol:137-138 - if (length != newMaxStalenessList.length)
