# Function: test_SetUptimeFeed()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_SetUptimeFeed()`
- **Visibility**: public
- **Source Range**: 5253:921:625

## Implementation

```solidity
function test_SetUptimeFeed() public {
    MockL2Sequencer newUptimeFeed = new MockL2Sequencer();
    newUptimeFeed.setLatestAnswer(0);
    newUptimeFeed.setStartedAt(block.timestamp - (GRACE_PERIOD * 2));
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(newUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD * 2;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.uptimeFeeds(address(dataFeed)), address(newUptimeFeed));
    assertEq(oracle.gracePeriods(address(newUptimeFeed)), GRACE_PERIOD * 2);
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

- **MockL2Sequencer::setLatestAnswer(int256)**
- **MockL2Sequencer::setStartedAt(uint256)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **SuperOracleL2::uptimeFeeds(address)**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **GRACE_PERIOD** (`uint256`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_SetUptimeFeed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed)), address(newUptimeFeed)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [oracle.gracePeriods(address(newUptimeFeed)), GRACE_PERIOD * 2]
      👁️  Def: internal
```
