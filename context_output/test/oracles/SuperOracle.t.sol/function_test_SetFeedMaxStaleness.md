# Function: test_SetFeedMaxStaleness()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStaleness()`
- **Visibility**: public
- **Source Range**: 15160:364:624

## Implementation

```solidity
function test_SetFeedMaxStaleness() public {
    uint256 feedStaleness = 6 hours;
    superOracle.setFeedMaxStaleness(address(mockFeed1), feedStaleness);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), feedStaleness, "Feed staleness should be updated");
}
```

## Related Implementations

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

- **SuperOracle::setFeedMaxStaleness(address,uint256)**
- **SuperOracle::feedMaxStaleness(address)**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), feedStaleness, "Feed staleness should be updated"]
      👁️  Def: internal
```
