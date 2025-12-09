# Function: test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 54641:1937:625

## Implementation

```solidity
/// @notice Tests that data oracle latestRoundData() revert causes revert when revertOnError=true
///  @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for data oracle
function test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError() public {
    MockAggregatorRevertingLatestRoundData revertingDataFeed = new MockAggregatorRevertingLatestRoundData();
    MockL2Sequencer uptimeFeedForReverting = new MockL2Sequencer();
    uptimeFeedForReverting.setLatestAnswer(0);
    uptimeFeedForReverting.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory bases = new address[](1);
    address[] memory quotes = new address[](1);
    bytes32[] memory providers = new bytes32[](1);
    address[] memory feeds = new address[](1);
    bases[0] = address(baseToken);
    quotes[0] = address(quoteToken);
    providers[0] = keccak256("REVERTING_PROVIDER");
    feeds[0] = address(revertingDataFeed);
    oracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 7 days);
    oracle.executeOracleUpdate();
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(revertingDataFeed);
    uptimeOracles[0] = address(uptimeFeedForReverting);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    vm.expectRevert(abi.encodeWithSelector(ISuperOracle.ORACLE_ROUND_DATA_CALL_FAIL.selector, address(revertingDataFeed)));
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), keccak256("REVERTING_PROVIDER"));
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::warp(uint256)**
- **SuperOracleL2::executeOracleUpdate()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **GRACE_PERIOD** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that data oracle latestRoundData() revert causes revert when revertOnError=true
 @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for data oracle
