# Function: test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum()`
- **Visibility**: public
- **Source Range**: 15358:634:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed with grace period just below minimum
///  @dev Tests boundary condition for grace period validation (line 70)
function test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum() public {
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    gracePeriods[0] = 599;
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracleL2.GRACE_PERIOD_TOO_LOW.selector);
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
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed with grace period just below minimum
 @dev Tests boundary condition for grace period validation (line 70)
