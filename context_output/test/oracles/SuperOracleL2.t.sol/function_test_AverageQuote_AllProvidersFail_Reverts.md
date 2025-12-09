# Function: test_AverageQuote_AllProvidersFail_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_AverageQuote_AllProvidersFail_Reverts()`
- **Visibility**: public
- **Source Range**: 63832:2608:625

## Implementation

```solidity
/// @notice Tests that all providers failing results in NO_VALID_REPORTED_PRICES
///  @dev When every provider fails, the average computation should revert
function test_AverageQuote_AllProvidersFail_Reverts() public {
    MockAggregator sequencerDownFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    sequencerDownFeed.setUpdatedAt(block.timestamp);
    MockAggregator negativePriceFeed = new MockAggregator(-1000, uint8(PRICE_DECIMALS));
    negativePriceFeed.setUpdatedAt(block.timestamp);
    MockL2Sequencer sequencerDownUptime = new MockL2Sequencer();
    sequencerDownUptime.setLatestAnswer(1);
    MockL2Sequencer workingUptime = new MockL2Sequencer();
    workingUptime.setLatestAnswer(0);
    workingUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](2);
    address[] memory quotes = new address[](2);
    bytes32[] memory providers = new bytes32[](2);
    address[] memory feeds = new address[](2);
    bases[0] = address(baseToken);
    bases[1] = address(baseToken);
    quotes[0] = address(quoteToken);
    quotes[1] = address(quoteToken);
    providers[0] = keccak256("SEQUENCER_DOWN");
    providers[1] = keccak256("NEGATIVE_PRICE");
    feeds[0] = address(sequencerDownFeed);
    feeds[1] = address(negativePriceFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    sequencerDownFeed.setUpdatedAt(block.timestamp);
    negativePriceFeed.setUpdatedAt(block.timestamp);
    workingUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](2);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](2);
    dataOracles[0] = address(sequencerDownFeed);
    dataOracles[1] = address(negativePriceFeed);
    uptimeOracles[0] = address(sequencerDownUptime);
    uptimeOracles[1] = address(workingUptime);
    gracePeriods[0] = GRACE_PERIOD;
    gracePeriods[1] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    vm.expectRevert(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
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
- **Vm::expectRevert(bytes4)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **PRICE_DECIMALS** (`uint256`)
- **GRACE_PERIOD** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_AverageQuote_AllProvidersFail_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that all providers failing results in NO_VALID_REPORTED_PRICES
 @dev When every provider fails, the average computation should revert
