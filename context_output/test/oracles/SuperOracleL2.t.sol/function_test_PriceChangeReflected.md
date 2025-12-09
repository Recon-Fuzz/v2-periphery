# Function: test_PriceChangeReflected()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_PriceChangeReflected()`
- **Visibility**: public
- **Source Range**: 24169:840:625

## Implementation

```solidity
function test_PriceChangeReflected() public {
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    uint256 baseAmount = 1 * (10 ** 15);
    uint256 initialQuote = oracle.getQuote(baseAmount, address(baseToken), address(quoteToken));
    uint256 newPrice = INITIAL_PRICE * 2;
    dataFeed.setAnswer(int256(newPrice));
    uint256 newQuote = oracle.getQuote(baseAmount, address(baseToken), address(quoteToken));
    assertEq(newQuote, initialQuote * 2);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::getQuote(uint256,address,address)**
- **MockAggregator::setAnswer(int256)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **INITIAL_PRICE** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_PriceChangeReflected() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [newQuote, initialQuote * 2]
      👁️  Def: internal
```
