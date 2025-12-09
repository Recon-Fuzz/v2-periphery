# Function: test_BatchSetUptimeFeed_RevertsOnEmptyArray()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_SuperOracleL2Test.md]

## Metadata

- **Contract**: SuperOracleL2Test
- **Signature**: `test_BatchSetUptimeFeed_RevertsOnEmptyArray()`
- **Visibility**: public
- **Source Range**: 9419:491:625

## Implementation

```solidity
/// @notice Tests batchSetUptimeFeed reverts with empty arrays
///  @dev Covers SuperOracleL2.sol:61 - if (length == 0) revert ZERO_ARRAY_LENGTH()
function test_BatchSetUptimeFeed_RevertsOnEmptyArray() public {
    address[] memory emptyDataOracles = new address[](0);
    address[] memory emptyUptimeOracles = new address[](0);
    uint256[] memory emptyGracePeriods = new uint256[](0);
    bytes memory encodedError = abi.encodeWithSelector(ISuperOracle.ZERO_ARRAY_LENGTH.selector);
    vm.expectRevert(encodedError);
    oracle.batchSetUptimeFeed(emptyDataOracles, emptyUptimeOracles, emptyGracePeriods);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **SuperOracleL2::batchSetUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **oracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleL2Test.test_BatchSetUptimeFeed_RevertsOnEmptyArray() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batchSetUptimeFeed reverts with empty arrays
 @dev Covers SuperOracleL2.sol:61 - if (length == 0) revert ZERO_ARRAY_LENGTH()
