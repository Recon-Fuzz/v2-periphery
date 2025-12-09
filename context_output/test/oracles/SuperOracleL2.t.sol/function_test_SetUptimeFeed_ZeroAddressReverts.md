# Function: test_SetUptimeFeed_ZeroAddressReverts()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_SetUptimeFeed_ZeroAddressReverts()`
- **Visibility**: public
- **Source Range**: 6847:787:625

## Implementation

```solidity
function test_SetUptimeFeed_ZeroAddressReverts() public {
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracleL2.ZERO_ADDRESS.selector);
    vm.expectRevert(encodedError);
    address[] memory uptimeOracles = new address[](1);
    uptimeOracles[0] = address(uptimeFeed);
    uint256[] memory gracePeriods = new uint256[](1);
    gracePeriods[0] = GRACE_PERIOD;
    oracle.batchSetUptimeFeed(new address[](1), uptimeOracles, gracePeriods);
    vm.expectRevert(encodedError);
    address[] memory dataOracles = new address[](1);
    dataOracles[0] = address(dataFeed);
    oracle.batchSetUptimeFeed(dataOracles, new address[](1), gracePeriods);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_SetUptimeFeed_ZeroAddressReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
