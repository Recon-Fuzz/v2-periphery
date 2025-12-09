# Function: test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch()`
- **Visibility**: public
- **Source Range**: 11003:720:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed reverts when gracePeriods array length doesn't match
///  @dev Covers SuperOracleL2.sol:62-63 - array length mismatch check (gracePeriods)
function test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch() public {
    address[] memory dataOracles = new address[](2);
    address[] memory uptimeOracles = new address[](2);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    dataOracles[1] = address(dataFeed);
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
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed reverts when gracePeriods array length doesn't match
 @dev Covers SuperOracleL2.sol:62-63 - array length mismatch check (gracePeriods)
