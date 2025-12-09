# Function: test_CatchBlock_InsufficientGasDetection()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_CatchBlock_InsufficientGasDetection()`
- **Visibility**: public
- **Source Range**: 42377:2372:625

## Implementation

```solidity
/// @notice Tests catch block detects insufficient gas before external call
///  @dev Covers SuperOracleL2.sol:153 - if (gasleft() <= gasBefore / 64) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL()
///  @dev This is difficult to test reliably due to gas accounting complexities
function test_CatchBlock_InsufficientGasDetection() public {
    MockAggregatorFailDecimals failingFeed = new MockAggregatorFailDecimals(int256(INITIAL_PRICE));
    failingFeed.setUpdatedAt(block.timestamp);
    MockL2Sequencer uptimeFeedForFailing = new MockL2Sequencer();
    uptimeFeedForFailing.setLatestAnswer(0);
    uptimeFeedForFailing.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](1);
    address[] memory quotes = new address[](1);
    bytes32[] memory providers = new bytes32[](1);
    address[] memory feeds = new address[](1);
    bases[0] = address(baseToken);
    quotes[0] = address(quoteToken);
    providers[0] = keccak256("FAILING_PROVIDER");
    feeds[0] = address(failingFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    failingFeed.setUpdatedAt(block.timestamp);
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(failingFeed);
    uptimeOracles[0] = address(uptimeFeedForFailing);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    vm.expectRevert(abi.encodeWithSelector(ISuperOracleL2.ORACLE_DECIMALS_CALL_FAIL.selector, address(failingFeed)));
    oracle.getQuoteFromProvider{gas: 500_000}(1 * (10 ** 15), address(baseToken), address(quoteToken), keccak256("FAILING_PROVIDER"));
}
```

## External Calls

- **MockAggregatorFailDecimals::setUpdatedAt(uint256)**
- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **SuperOracleL2::executeOracleUpdate()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **Vm::expectRevert(bytes)**
- **unknown::unknown**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **GRACE_PERIOD** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_CatchBlock_InsufficientGasDetection() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests catch block detects insufficient gas before external call
 @dev Covers SuperOracleL2.sol:153 - if (gasleft() <= gasBefore / 64) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL()
 @dev This is difficult to test reliably due to gas accounting complexities
