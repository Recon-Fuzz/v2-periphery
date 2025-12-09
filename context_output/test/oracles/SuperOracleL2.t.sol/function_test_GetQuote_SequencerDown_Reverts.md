# Function: test_GetQuote_SequencerDown_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GetQuote_SequencerDown_Reverts()`
- **Visibility**: public
- **Source Range**: 19382:931:625

## Implementation

```solidity
function test_GetQuote_SequencerDown_Reverts() public {
    uptimeFeed.setLatestAnswer(1);
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    vm.expectRevert(encodedError);
    oracle.getQuote(1 * (10 ** 15), address(baseToken), address(quoteToken));
    bytes memory sequencerDownError = abi.encodeWithSelector(ISuperOracleL2.SEQUENCER_DOWN.selector);
    vm.expectRevert(sequencerDownError);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **Vm::expectRevert(bytes)**
- **SuperOracleL2::getQuote(uint256,address,address)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GetQuote_SequencerDown_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
