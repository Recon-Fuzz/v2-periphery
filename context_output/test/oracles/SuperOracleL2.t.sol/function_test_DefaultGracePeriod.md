# Function: test_DefaultGracePeriod()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_DefaultGracePeriod()`
- **Visibility**: public
- **Source Range**: 25015:1848:625

## Implementation

```solidity
function test_DefaultGracePeriod() public {
    MockL2Sequencer newUptimeFeed = new MockL2Sequencer();
    newUptimeFeed.setLatestAnswer(0);
    newUptimeFeed.setStartedAt(block.timestamp - 100);
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(newUptimeFeed);
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    vm.expectRevert(encodedError);
    oracle.getQuote(1 * (10 ** 15), address(baseToken), address(quoteToken));
    bytes memory gracePeriodError = abi.encodeWithSelector(ISuperOracleL2.GRACE_PERIOD_NOT_OVER.selector);
    vm.expectRevert(gracePeriodError);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
    newUptimeFeed.setStartedAt(block.timestamp - 3700);
    uint256 quoteAmount = oracle.getQuote(1 * (10 ** 15), address(baseToken), address(quoteToken));
    assertGt(quoteAmount, 0);
}
```

## Related Implementations

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 14636:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right);
    }
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuote(uint256,address,address)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_DefaultGracePeriod() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
      💬 Args: [quoteAmount, 0]
      👁️  Def: internal
```
