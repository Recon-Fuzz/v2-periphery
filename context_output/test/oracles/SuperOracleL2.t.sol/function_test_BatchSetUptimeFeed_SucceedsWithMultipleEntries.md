# Function: test_BatchSetUptimeFeed_SucceedsWithMultipleEntries()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_SucceedsWithMultipleEntries()`
- **Visibility**: public
- **Source Range**: 12822:1624:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed succeeds with multiple valid entries
///  @dev Tests loop iteration through multiple valid entries (line 66)
function test_BatchSetUptimeFeed_SucceedsWithMultipleEntries() public {
    MockAggregator dataFeed2 = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    MockAggregator dataFeed3 = new MockAggregator(int256(INITIAL_PRICE), uint8(PRICE_DECIMALS));
    MockL2Sequencer uptimeFeed2 = new MockL2Sequencer();
    MockL2Sequencer uptimeFeed3 = new MockL2Sequencer();
    address[] memory dataOracles = new address[](3);
    address[] memory uptimeOracles = new address[](3);
    uint256[] memory gracePeriods = new uint256[](3);
    dataOracles[0] = address(dataFeed);
    dataOracles[1] = address(dataFeed2);
    dataOracles[2] = address(dataFeed3);
    uptimeOracles[0] = address(uptimeFeed);
    uptimeOracles[1] = address(uptimeFeed2);
    uptimeOracles[2] = address(uptimeFeed3);
    gracePeriods[0] = GRACE_PERIOD;
    gracePeriods[1] = GRACE_PERIOD * 2;
    gracePeriods[2] = 0;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed));
    assertEq(oracle.uptimeFeeds(address(dataFeed2)), address(uptimeFeed2));
    assertEq(oracle.uptimeFeeds(address(dataFeed3)), address(uptimeFeed3));
    assertEq(oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD);
    assertEq(oracle.gracePeriods(address(uptimeFeed2)), GRACE_PERIOD * 2);
    assertEq(oracle.gracePeriods(address(uptimeFeed3)), 0);
}
```

## Related Implementations

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
- **SuperOracleL2::uptimeFeeds(address)**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **INITIAL_PRICE** (`uint256`)
- **PRICE_DECIMALS** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_SucceedsWithMultipleEntries() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed2)), address(uptimeFeed2)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 3)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed3)), address(uptimeFeed3)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [oracle.gracePeriods(address(uptimeFeed2)), GRACE_PERIOD * 2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [oracle.gracePeriods(address(uptimeFeed3)), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed succeeds with multiple valid entries
 @dev Tests loop iteration through multiple valid entries (line 66)
