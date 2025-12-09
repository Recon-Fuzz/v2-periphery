# Function: test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert()`
- **Visibility**: public
- **Source Range**: 39303:2784:625

## Implementation

```solidity
/// @notice Tests catch block returns 0 when decimals() fails and revertOnError = false
///  @dev Covers SuperOracleL2.sol:155 - return 0 when revertOnError = false
function test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert() public {
    MockAggregatorFailDecimals failingFeed = new MockAggregatorFailDecimals(int256(INITIAL_PRICE));
    failingFeed.setUpdatedAt(block.timestamp);
    MockAggregator workingFeed = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    workingFeed.setUpdatedAt(block.timestamp);
    MockL2Sequencer uptimeFeedFailing = new MockL2Sequencer();
    uptimeFeedFailing.setLatestAnswer(0);
    uptimeFeedFailing.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    MockL2Sequencer uptimeFeedWorking = new MockL2Sequencer();
    uptimeFeedWorking.setLatestAnswer(0);
    uptimeFeedWorking.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](2);
    address[] memory quotes = new address[](2);
    bytes32[] memory providers = new bytes32[](2);
    address[] memory feeds = new address[](2);
    bases[0] = address(baseToken);
    bases[1] = address(baseToken);
    quotes[0] = address(quoteToken);
    quotes[1] = address(quoteToken);
    providers[0] = keccak256("FAILING_PROVIDER");
    providers[1] = keccak256("WORKING_PROVIDER");
    feeds[0] = address(failingFeed);
    feeds[1] = address(workingFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    failingFeed.setUpdatedAt(block.timestamp);
    workingFeed.setUpdatedAt(block.timestamp);
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](2);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](2);
    dataOracles[0] = address(failingFeed);
    dataOracles[1] = address(workingFeed);
    uptimeOracles[0] = address(uptimeFeedFailing);
    uptimeOracles[1] = address(uptimeFeedWorking);
    gracePeriods[0] = GRACE_PERIOD;
    gracePeriods[1] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    (uint256 quoteAmount, , , ) = oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    assertGt(quoteAmount, 0, "Should get quote from working provider despite one provider failing decimals()");
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

- **MockAggregatorFailDecimals::setUpdatedAt(uint256)**
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
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [quoteAmount, 0, "Should get quote from working provider despite one provider failing decimals()"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests catch block returns 0 when decimals() fails and revertOnError = false
 @dev Covers SuperOracleL2.sol:155 - return 0 when revertOnError = false
