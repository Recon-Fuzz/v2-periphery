# Function: test_GracePeriodNotOver_BothRevertOnErrorPaths()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_GracePeriodNotOver_BothRevertOnErrorPaths()`
- **Visibility**: public
- **Source Range**: 67554:846:625

## Implementation

```solidity
/// @notice Tests that GRACE_PERIOD_NOT_OVER returns 0 with revertOnError=false but reverts with revertOnError=true
///  @dev Verifies both paths for grace period condition
function test_GracePeriodNotOver_BothRevertOnErrorPaths() public {
    uptimeFeed.setLatestAnswer(0);
    uptimeFeed.setStartedAt(block.timestamp - 100);
    bytes32 averageProvider = keccak256("AVERAGE_PROVIDER");
    vm.expectRevert(ISuperOracle.NO_VALID_REPORTED_PRICES.selector);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), averageProvider);
    vm.expectRevert(ISuperOracleL2.GRACE_PERIOD_NOT_OVER.selector);
    oracle.getQuoteFromProvider(1 * (10 ** 15), address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
}
```

## External Calls

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperOracleL2::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_GracePeriodNotOver_BothRevertOnErrorPaths() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that GRACE_PERIOD_NOT_OVER returns 0 with revertOnError=false but reverts with revertOnError=true
 @dev Verifies both paths for grace period condition
