# Function: test_SetFeedMaxStaleness_ZeroResetsToDefault()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStaleness_ZeroResetsToDefault()`
- **Visibility**: public
- **Source Range**: 65066:447:624

## Implementation

```solidity
/// @notice Tests _setFeedMaxStaleness with newMaxStaleness == 0 reset to default
///  @dev Covers SuperOracleBase.sol:349-351 - if (newMaxStaleness == 0)
function test_SetFeedMaxStaleness_ZeroResetsToDefault() public {
    superOracle.setFeedMaxStaleness(address(mockFeed1), 6 hours);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours);
    superOracle.setFeedMaxStaleness(address(mockFeed1), 0);
    assertEq(superOracle.feedMaxStaleness(address(mockFeed1)), superOracle.defaultStaleness());
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

- **SuperOracle::setFeedMaxStaleness(address,uint256)**
- **SuperOracle::feedMaxStaleness(address)**
- **SuperOracle::defaultStaleness()**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStaleness_ZeroResetsToDefault() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), 6 hours]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [superOracle.feedMaxStaleness(address(mockFeed1)), superOracle.defaultStaleness()]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests _setFeedMaxStaleness with newMaxStaleness == 0 reset to default
 @dev Covers SuperOracleBase.sol:349-351 - if (newMaxStaleness == 0)
