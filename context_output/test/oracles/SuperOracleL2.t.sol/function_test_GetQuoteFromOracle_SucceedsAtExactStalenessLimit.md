# Function: test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit()`
- **Visibility**: public
- **Source Range**: 35051:756:625

## Implementation

```solidity
/// @notice Tests boundary case where updatedAt is exactly at the staleness limit
///  @dev Tests boundary of line 135 condition: block.timestamp - updatedAt > limit
function test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit() public {
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    dataFeed.setAnswer(int256(INITIAL_PRICE));
    dataFeed.setUpdatedAt(block.timestamp - 86_400);
    (uint256 quoteAmount, , , ) = oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
    assertGt(quoteAmount, 0, "Should succeed when exactly at staleness limit");
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **MockAggregator::setAnswer(int256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **INITIAL_PRICE** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 0, "Should succeed when exactly at staleness limit"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests boundary case where updatedAt is exactly at the staleness limit
 @dev Tests boundary of line 135 condition: block.timestamp - updatedAt > limit
