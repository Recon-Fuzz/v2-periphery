# Function: test_BatchSetUptimeFeed_EmitsEvents()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_EmitsEvents()`
- **Visibility**: public
- **Source Range**: 16143:1082:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed event emissions
///  @dev Verifies UptimeFeedSet and GracePeriodSet events are emitted (lines 77-78)
function test_BatchSetUptimeFeed_EmitsEvents() public {
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    gracePeriods[0] = GRACE_PERIOD * 2;
    vm.recordLogs();
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertGe(entries.length, 2, "Should emit at least 2 events");
    assertEq(oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed), "Uptime feed should be set");
    assertEq(oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD * 2, "Grace period should be set");
}
```

## Related Implementations

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 17502:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left < right) {
        vm.assertGe(left, right, err);
    }
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::recordLogs()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **Vm::getRecordedLogs()**
- **SuperOracleL2::uptimeFeeds(address)**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_EmitsEvents() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [entries.length, 2, "Should emit at least 2 events"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed), "Uptime feed should be set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD * 2, "Grace period should be set"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed event emissions
 @dev Verifies UptimeFeedSet and GracePeriodSet events are emitted (lines 77-78)
