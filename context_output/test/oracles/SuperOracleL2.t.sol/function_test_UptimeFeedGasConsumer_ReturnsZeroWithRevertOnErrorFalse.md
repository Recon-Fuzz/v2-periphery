# Function: test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse()`
- **Visibility**: public
- **Source Range**: 68970:3015:625

## Implementation

```solidity
/// @notice Tests line 120: When uptime feed consumes most gas before reverting and revertOnError=false
///  @dev Covers the `&& revertOnError` condition on line 120 when revertOnError=false
///  The gas check condition is true but && revertOnError makes the whole condition false,
///  so it falls through to line 121 (also false), and returns 0 on line 122
function test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse() public {
    MockAggregator workingFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    workingFeed.setUpdatedAt(block.timestamp);
    MockAggregator feedWithGasConsumingUptime = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    feedWithGasConsumingUptime.setUpdatedAt(block.timestamp);
    MockL2Sequencer workingUptimeFeed = new MockL2Sequencer();
    workingUptimeFeed.setLatestAnswer(0);
    workingUptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    MockL2SequencerGasConsumer gasConsumingUptimeFeed = new MockL2SequencerGasConsumer();
    address[] memory bases = new address[](2);
    address[] memory quotes = new address[](2);
    bytes32[] memory providers = new bytes32[](2);
    address[] memory feeds = new address[](2);
    bases[0] = address(baseToken);
    bases[1] = address(baseToken);
    quotes[0] = address(quoteToken);
    quotes[1] = address(quoteToken);
    providers[0] = keccak256("WORKING_PROVIDER");
    providers[1] = keccak256("GAS_CONSUMING_UPTIME_PROVIDER");
    feeds[0] = address(workingFeed);
    feeds[1] = address(feedWithGasConsumingUptime);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    workingFeed.setUpdatedAt(block.timestamp);
    feedWithGasConsumingUptime.setUpdatedAt(block.timestamp);
    workingUptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](2);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](2);
    dataOracles[0] = address(workingFeed);
    dataOracles[1] = address(feedWithGasConsumingUptime);
    uptimeOracles[0] = address(workingUptimeFeed);
    uptimeOracles[1] = address(gasConsumingUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    gracePeriods[1] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    (uint256 quoteAmount, , , ) = oracle.getQuoteFromProvider{gas: 5_000_000}(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    assertGt(quoteAmount, 0, "Should get quote from working provider despite gas-consuming uptime feed");
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

- **MockAggregator::setUpdatedAt(uint256)**
- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **SuperOracleL2::executeOracleUpdate()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **unknown::unknown**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **PRICE_DECIMALS** (`uint256`)
- **GRACE_PERIOD** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 0, "Should get quote from working provider despite gas-consuming uptime feed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests line 120: When uptime feed consumes most gas before reverting and revertOnError=false
 @dev Covers the `&& revertOnError` condition on line 120 when revertOnError=false
 The gas check condition is true but && revertOnError makes the whole condition false,
 so it falls through to line 121 (also false), and returns 0 on line 122
