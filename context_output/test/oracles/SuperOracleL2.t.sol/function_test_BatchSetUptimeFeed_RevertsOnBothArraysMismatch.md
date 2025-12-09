# Function: test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch()`
- **Visibility**: public
- **Source Range**: 11897:766:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed reverts when both arrays have mismatched lengths
///  @dev Covers SuperOracleL2.sol:62-63 - both conditions in OR statement
function test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch() public {
    address[] memory dataOracles = new address[](3);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    dataOracles[1] = address(dataFeed);
    dataOracles[2] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    uptimeOracles[1] = address(uptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracle.ARRAY_LENGTH_MISMATCH.selector);
    vm.expectRevert(encodedError);
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed reverts when both arrays have mismatched lengths
 @dev Covers SuperOracleL2.sol:62-63 - both conditions in OR statement
