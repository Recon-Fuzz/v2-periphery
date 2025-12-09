# Function: test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 28882:711:625

## Implementation

```solidity
/// @notice Tests _getQuoteFromOracle reverts with ORACLE_UNTRUSTED_DATA when data is stale and revertOnError = true
///  @dev Covers SuperOracleL2.sol:136 - if (revertOnError) with stale data
function test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError() public {
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    dataFeed.setAnswer(int256(INITIAL_PRICE));
    dataFeed.setUpdatedAt(block.timestamp - 86_401);
    vm.expectRevert(ISuperOracle.ORACLE_UNTRUSTED_DATA.selector);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **MockAggregator::setAnswer(int256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **INITIAL_PRICE** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests _getQuoteFromOracle reverts with ORACLE_UNTRUSTED_DATA when data is stale and revertOnError = true
 @dev Covers SuperOracleL2.sol:136 - if (revertOnError) with stale data
