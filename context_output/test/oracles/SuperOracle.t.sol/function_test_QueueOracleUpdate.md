# Function: test_QueueOracleUpdate()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_QueueOracleUpdate()`
- **Visibility**: public
- **Source Range**: 17635:1229:624

## Implementation

```solidity
function test_QueueOracleUpdate() public {
    address[] memory bases = new address[](1);
    bases[0] = address(mockBTC);
    address[] memory quotes = new address[](1);
    quotes[0] = address(mockUSD);
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = NEW_PROVIDER;
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed4);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.expectRevert(ISuperOracle.TIMELOCK_NOT_ELAPSED.selector);
    superOracle.executeOracleUpdate();
    vm.warp((block.timestamp + 1 weeks) + 1 seconds);
    mockFeed4.setUpdatedAt(block.timestamp);
    superOracle.executeOracleUpdate();
    address oracle = superOracle.getOracleAddress(address(mockBTC), address(mockUSD), NEW_PROVIDER);
    assertEq(oracle, address(mockFeed4), "Oracle address should be set for new provider");
}
```

## Related Implementations

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

## External Calls

- **SuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::executeOracleUpdate()**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**

## State Variable Reads

- **mockBTC** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **NEW_PROVIDER** (`bytes32`)
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_QueueOracleUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [oracle, address(mockFeed4), "Oracle address should be set for new provider"]
      👁️  Def: internal
```
