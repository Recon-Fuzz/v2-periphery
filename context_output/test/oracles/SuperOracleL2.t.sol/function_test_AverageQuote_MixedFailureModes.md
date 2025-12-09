# Function: test_AverageQuote_MixedFailureModes()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_AverageQuote_MixedFailureModes()`
- **Visibility**: public
- **Source Range**: 59449:4214:625

## Implementation

```solidity
/// @notice Tests multi-provider average with mixed failure modes
///  @dev Comprehensive test with sequencer down, grace period issues, stale data, and working provider
function test_AverageQuote_MixedFailureModes() public {
    MockAggregator workingFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    workingFeed.setUpdatedAt(block.timestamp);
    MockAggregator sequencerDownFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    sequencerDownFeed.setUpdatedAt(block.timestamp);
    MockAggregator gracePeriodFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    gracePeriodFeed.setUpdatedAt(block.timestamp);
    MockAggregator staleFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    staleFeed.setUpdatedAt(block.timestamp - 86_401);
    MockL2Sequencer workingUptime = new MockL2Sequencer();
    workingUptime.setLatestAnswer(0);
    workingUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    MockL2Sequencer sequencerDownUptime = new MockL2Sequencer();
    sequencerDownUptime.setLatestAnswer(1);
    MockL2Sequencer gracePeriodUptime = new MockL2Sequencer();
    gracePeriodUptime.setLatestAnswer(0);
    gracePeriodUptime.setStartedAt(block.timestamp - 100);
    MockL2Sequencer staleUptime = new MockL2Sequencer();
    staleUptime.setLatestAnswer(0);
    staleUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](4);
    address[] memory quotes = new address[](4);
    bytes32[] memory providers = new bytes32[](4);
    address[] memory feeds = new address[](4);
    for (uint256 i = 0; i < 4; i++) {
        bases[i] = address(baseToken);
        quotes[i] = address(quoteToken);
    }
    providers[0] = keccak256("WORKING");
    providers[1] = keccak256("SEQUENCER_DOWN");
    providers[2] = keccak256("GRACE_PERIOD");
    providers[3] = keccak256("STALE");
    feeds[0] = address(workingFeed);
    feeds[1] = address(sequencerDownFeed);
    feeds[2] = address(gracePeriodFeed);
    feeds[3] = address(staleFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    workingFeed.setUpdatedAt(block.timestamp);
    sequencerDownFeed.setUpdatedAt(block.timestamp);
    gracePeriodFeed.setUpdatedAt(block.timestamp);
    staleFeed.setUpdatedAt(block.timestamp - 86_401);
    workingUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    gracePeriodUptime.setStartedAt(block.timestamp - 100);
    staleUptime.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](4);
    address[] memory uptimeOracles = new address[](4);
    uint256[] memory gracePeriods = new uint256[](4);
    dataOracles[0] = address(workingFeed);
    dataOracles[1] = address(sequencerDownFeed);
    dataOracles[2] = address(gracePeriodFeed);
    dataOracles[3] = address(staleFeed);
    uptimeOracles[0] = address(workingUptime);
    uptimeOracles[1] = address(sequencerDownUptime);
    uptimeOracles[2] = address(gracePeriodUptime);
    uptimeOracles[3] = address(staleUptime);
    for (uint256 i = 0; i < 4; i++) {
        gracePeriods[i] = GRACE_PERIOD;
    }
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    (uint256 quoteAmount, , , uint256 availableProviders) = oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    assertGt(quoteAmount, 0, "Should get quote from the working provider");
    assertEq(availableProviders, 1, "Only one provider should be available");
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
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_AverageQuote_MixedFailureModes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [quoteAmount, 0, "Should get quote from the working provider"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [availableProviders, 1, "Only one provider should be available"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests multi-provider average with mixed failure modes
 @dev Comprehensive test with sequencer down, grace period issues, stale data, and working provider
