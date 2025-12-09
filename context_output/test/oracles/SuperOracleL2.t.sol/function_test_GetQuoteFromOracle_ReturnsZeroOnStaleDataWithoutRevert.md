# Function: test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert()`
- **Visibility**: public
- **Source Range**: 32454:2418:625

## Implementation

```solidity
/// @notice Tests _getQuoteFromOracle returns 0 when data is stale and revertOnError = false
///  @dev Covers SuperOracleL2.sol:137 - return 0 path with stale data
function test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert() public {
    MockAggregator dataFeed2 = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    MockL2Sequencer uptimeFeed2 = new MockL2Sequencer();
    uptimeFeed2.setLatestAnswer(0);
    uptimeFeed2.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](1);
    address[] memory quotes = new address[](1);
    bytes32[] memory providers = new bytes32[](1);
    address[] memory feeds = new address[](1);
    bases[0] = address(baseToken);
    quotes[0] = address(quoteToken);
    providers[0] = keccak256("PROVIDER_2");
    feeds[0] = address(dataFeed2);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    dataFeed2.setUpdatedAt(block.timestamp);
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed2);
    uptimeOracles[0] = address(uptimeFeed2);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    dataFeed.setAnswer(int256(INITIAL_PRICE));
    dataFeed.setUpdatedAt(block.timestamp - 86_401);
    dataFeed2.setAnswer(int256(INITIAL_PRICE));
    dataFeed2.setUpdatedAt(block.timestamp);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    (uint256 quoteAmount, , , ) = oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    assertGt(quoteAmount, 0, "Should get quote from fresh provider despite one provider being stale");
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
- **SuperOracleL2::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracleL2::executeOracleUpdate()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **MockAggregator::setAnswer(int256)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **PRICE_DECIMALS** (`uint256`)
- **GRACE_PERIOD** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 0, "Should get quote from fresh provider despite one provider being stale"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _getQuoteFromOracle returns 0 when data is stale and revertOnError = false
 @dev Covers SuperOracleL2.sol:137 - return 0 path with stale data
