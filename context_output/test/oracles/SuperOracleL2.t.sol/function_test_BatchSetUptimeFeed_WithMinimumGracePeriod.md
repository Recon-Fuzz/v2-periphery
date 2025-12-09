# Function: test_BatchSetUptimeFeed_WithMinimumGracePeriod()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_WithMinimumGracePeriod()`
- **Visibility**: public
- **Source Range**: 14613:585:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed with exactly MIN_GRACE_PERIOD_TIME boundary
///  @dev Tests boundary condition for grace period validation (line 70)
function test_BatchSetUptimeFeed_WithMinimumGracePeriod() public {
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    gracePeriods[0] = 600;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.gracePeriods(address(uptimeFeed)), 600);
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

- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_WithMinimumGracePeriod() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [oracle.gracePeriods(address(uptimeFeed)), 600]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed with exactly MIN_GRACE_PERIOD_TIME boundary
 @dev Tests boundary condition for grace period validation (line 70)
