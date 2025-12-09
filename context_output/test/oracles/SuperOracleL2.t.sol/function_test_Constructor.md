# Function: test_Constructor()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_Constructor()`
- **Visibility**: public
- **Source Range**: 3715:588:625

## Implementation

```solidity
function test_Constructor() public view {
    assertEq(oracle.defaultStaleness(), DEFAULT_STALENESS);
    address configuredOracle = oracle.getOracleAddress(address(baseToken), address(quoteToken), CHAINLINK_PROVIDER);
    assertEq(configuredOracle, address(dataFeed));
    assertEq(oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed));
    assertEq(oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD);
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

- **SuperOracleL2::defaultStaleness()**
- **SuperOracleL2::getOracleAddress(address,address,bytes32)**
- **SuperOracleL2::uptimeFeeds(address)**
- **SuperOracleL2::gracePeriods(address)**

## State Variable Reads

- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **DEFAULT_STALENESS** (`uint256`)
- **baseToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **quoteToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **CHAINLINK_PROVIDER** (`bytes32`)
- **dataFeed** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **uptimeFeed** (`contract MockL2Sequencer`) [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]
- **GRACE_PERIOD** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_Constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [oracle.defaultStaleness(), DEFAULT_STALENESS]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │   💬 Args: [configuredOracle, address(dataFeed)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 3)
  │   💬 Args: [oracle.uptimeFeeds(address(dataFeed)), address(uptimeFeed)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [oracle.gracePeriods(address(uptimeFeed)), GRACE_PERIOD]
      👁️  Def: internal
```
