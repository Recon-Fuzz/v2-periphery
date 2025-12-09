# Function: test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert()`
- **Visibility**: public
- **Source Range**: 47638:2708:625

## Implementation

```solidity
/// @notice Tests that uptime feed latestRoundData() revert is caught and returns 0 when revertOnError=false
///  @dev Covers the new try/catch block around uptime feed's latestRoundData() call
function test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert() public {
    MockAggregator workingFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    workingFeed.setUpdatedAt(block.timestamp);
    MockAggregator feedWithBadUptime = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    feedWithBadUptime.setUpdatedAt(block.timestamp);
    MockL2Sequencer workingUptimeFeed = new MockL2Sequencer();
    workingUptimeFeed.setLatestAnswer(0);
    workingUptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    MockL2SequencerReverting revertingUptimeFeed = new MockL2SequencerReverting();
    address[] memory bases = new address[](2);
    address[] memory quotes = new address[](2);
    bytes32[] memory providers = new bytes32[](2);
    address[] memory feeds = new address[](2);
    bases[0] = address(baseToken);
    bases[1] = address(baseToken);
    quotes[0] = address(quoteToken);
    quotes[1] = address(quoteToken);
    providers[0] = keccak256("WORKING_PROVIDER");
    providers[1] = keccak256("BAD_UPTIME_PROVIDER");
    feeds[0] = address(workingFeed);
    feeds[1] = address(feedWithBadUptime);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    workingFeed.setUpdatedAt(block.timestamp);
    feedWithBadUptime.setUpdatedAt(block.timestamp);
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](2);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](2);
    dataOracles[0] = address(workingFeed);
    dataOracles[1] = address(feedWithBadUptime);
    uptimeOracles[0] = address(workingUptimeFeed);
    uptimeOracles[1] = address(revertingUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    gracePeriods[1] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    (uint256 quoteAmount, , , ) = oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    assertGt(quoteAmount, 0, "Should get quote from working provider despite one having reverting uptime feed");
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
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

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
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 0, "Should get quote from working provider despite one having reverting uptime feed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that uptime feed latestRoundData() revert is caught and returns 0 when revertOnError=false
 @dev Covers the new try/catch block around uptime feed's latestRoundData() call
