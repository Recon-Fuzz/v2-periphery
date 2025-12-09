# Function: test_SetFeedMaxStalenessBatch_ZeroLength()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_SetFeedMaxStalenessBatch_ZeroLength()`
- **Visibility**: public
- **Source Range**: 62497:303:624

## Implementation

```solidity
/// @notice Tests setFeedMaxStalenessBatch with zero length array
///  @dev Covers SuperOracleBase.sol:136 - if (length == 0) revert ZERO_ARRAY_LENGTH()
function test_SetFeedMaxStalenessBatch_ZeroLength() public {
    address[] memory feeds = new address[](0);
    uint256[] memory staleness = new uint256[](0);
    vm.expectRevert(ISuperOracle.ZERO_ARRAY_LENGTH.selector);
    superOracle.setFeedMaxStalenessBatch(feeds, staleness);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_SetFeedMaxStalenessBatch_ZeroLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setFeedMaxStalenessBatch with zero length array
 @dev Covers SuperOracleBase.sol:136 - if (length == 0) revert ZERO_ARRAY_LENGTH()
