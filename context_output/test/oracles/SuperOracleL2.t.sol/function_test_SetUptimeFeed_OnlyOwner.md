# Function: test_SetUptimeFeed_OnlyOwner()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_SetUptimeFeed_OnlyOwner()`
- **Visibility**: public
- **Source Range**: 6180:661:625

## Implementation

```solidity
function test_SetUptimeFeed_OnlyOwner() public {
    MockL2Sequencer newUptimeFeed = new MockL2Sequencer();
    address[] memory dataOracles = new address[](1);
    address[] memory uptimeOracles = new address[](1);
    uint256[] memory gracePeriods = new uint256[](1);
    dataOracles[0] = address(dataFeed);
    uptimeOracles[0] = address(newUptimeFeed);
    gracePeriods[0] = GRACE_PERIOD;
    vm.prank(user);
    vm.expectRevert();
    oracle.batchSetUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert()**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **GRACE_PERIOD** (`uint256`)
- **user** (`address`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_SetUptimeFeed_OnlyOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
