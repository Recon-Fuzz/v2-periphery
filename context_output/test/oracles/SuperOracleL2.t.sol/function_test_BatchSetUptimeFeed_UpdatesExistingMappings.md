# Function: test_BatchSetUptimeFeed_UpdatesExistingMappings()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_UpdatesExistingMappings()`
- **Visibility**: public
- **Source Range**: 17369:1013:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed can update existing mappings
///  @dev Verifies that calling again overwrites previous values
function test_BatchSetUptimeFeed_UpdatesExistingMappings() public {
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD);
    MockL2Sequencer newUptimeFeed = new MockL2Sequencer();
    uptimeOracles[0] = address(newUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD * 3;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.uptimeFeeds(address(dataFeed)), address(newUptimeFeed));
    assertEq(oracle.gracePeriods(address(newUptimeFeed)), GRACE_PERIOD * 3);
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

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **SuperOracleL2::gracePeriods(address)**
- **SuperOracleL2::uptimeFeeds(address)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_UpdatesExistingMappings() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed)), address(newUptimeFeed)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [oracle.gracePeriods(address(newUptimeFeed)), GRACE_PERIOD * 3]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed can update existing mappings
 @dev Verifies that calling again overwrites previous values
