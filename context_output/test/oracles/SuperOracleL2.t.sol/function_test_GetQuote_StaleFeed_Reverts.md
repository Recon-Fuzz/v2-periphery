# Function: test_GetQuote_StaleFeed_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuote_StaleFeed_Reverts()`
- **Visibility**: public
- **Source Range**: 22557:723:625

## Implementation

```solidity
function test_GetQuote_StaleFeed_Reverts() public {
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    dataFeed.setUpdatedAt((block.timestamp - DEFAULT_STALENESS) - 1);
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    vm.expectRevert(encodedError);
    oracle.getQuote(1 * (10 ** 15), address(baseToken), address(quoteToken));
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuote(uint256,address,address)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **DEFAULT_STALENESS** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuote_StaleFeed_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
