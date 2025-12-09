# Function: test_HundredPercentDeviationCase()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_HundredPercentDeviationCase()`
- **Visibility**: public
- **Source Range**: 46424:580:624

## Implementation

```solidity
function test_HundredPercentDeviationCase() public {
    mockFeed1.setAnswer(2e8);
    mockFeed2.setAnswer(1e7);
    mockFeed3.setAnswer(1e8);
    (, uint256 deviation, , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), AVERAGE_PROVIDER);
    assertGt(deviation, 0, "Deviation should be > 0 with extreme price differences");
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **MockAggregator::setAnswer(int256)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **AVERAGE_PROVIDER** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_HundredPercentDeviationCase() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [deviation, 0, "Deviation should be > 0 with extreme price differences"]
      👁️  Def: internal
```
