# Function: test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 50524:1052:625

## Implementation

```solidity
/// @notice Tests that uptime feed latestRoundData() revert causes revert when revertOnError=true
///  @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for uptime feed
function test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError() public {
    MockL2SequencerReverting revertingUptimeFeed = new MockL2SequencerReverting();
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(revertingUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    vm.expectRevert(abi.encodeWithSelector(ISuperOracle.ORACLE_ROUND_DATA_CALL_FAIL.selector, address(revertingUptimeFeed)));
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
}
```

## External Calls

- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that uptime feed latestRoundData() revert causes revert when revertOnError=true
 @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for uptime feed
