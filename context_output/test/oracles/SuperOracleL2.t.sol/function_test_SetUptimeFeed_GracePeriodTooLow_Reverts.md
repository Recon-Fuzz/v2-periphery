# Function: test_SetUptimeFeed_GracePeriodTooLow_Reverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_SetUptimeFeed_GracePeriodTooLow_Reverts()`
- **Visibility**: public
- **Source Range**: 7640:1619:625

## Implementation

```solidity
function test_SetUptimeFeed_GracePeriodTooLow_Reverts() public {
    uint256 tooLowGracePeriod = 599;
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(uptimeFeed);
    gracePeriods[0] = tooLowGracePeriod;
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracleL2.GRACE_PERIOD_TOO_LOW.selector);
    vm.expectRevert(encodedError);
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    gracePeriods[0] = 1;
    vm.expectRevert(encodedError);
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    gracePeriods[0] = 0;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    gracePeriods[0] = 600;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.gracePeriods(address(uptimeFeed)), 600);
    gracePeriods[0] = 601;
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    assertEq(oracle.gracePeriods(address(uptimeFeed)), 601);
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

- **Vm::expectRevert(bytes)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_SetUptimeFeed_GracePeriodTooLow_Reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [oracle.gracePeriods(address(uptimeFeed)), 600]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [oracle.gracePeriods(address(uptimeFeed)), 601]
      👁️  Def: internal
```
