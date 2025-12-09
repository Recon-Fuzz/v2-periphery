# Function: test_SetFeedMaxStalenessBatch_Unauthorized()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStalenessBatch_Unauthorized()`
- **Visibility**: public
- **Source Range**: 61909:422:624

## Implementation

```solidity
/// @notice Tests setFeedMaxStalenessBatch with unauthorized caller
///  @dev Covers SuperOracleBase.sol:134 - if (msg.sender != SUPER_GOVERNOR) (revert path)
function test_SetFeedMaxStalenessBatch_Unauthorized() public {
    address[] memory feeds = new address[](1);
    feeds[0] = address(mockFeed1);
    uint256[] memory staleness = new uint256[](1);
    staleness[0] = 6 hours;
    vm.prank(address(0x999));
    vm.expectRevert(ISuperOracle.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superOracle.setFeedMaxStalenessBatch(feeds, staleness);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStalenessBatch_Unauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setFeedMaxStalenessBatch with unauthorized caller
 @dev Covers SuperOracleBase.sol:134 - if (msg.sender != SUPER_GOVERNOR) (revert path)
