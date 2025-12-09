# Function: test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow()`
- **Visibility**: public
- **Source Range**: 101916:867:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch reverts when any staleness is too low
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory feeds = new address[](3);
    feeds[0] = address(0x123);
    feeds[1] = address(0x456);
    feeds[2] = address(0x789);
    uint256[] memory stalenessList = new uint256[](3);
    stalenessList[0] = 400;
    stalenessList[1] = 200;
    stalenessList[2] = 600;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.MAX_STALENESS_TOO_LOW.selector);
    superGovernor.setOracleFeedMaxStalenessBatch(feeds, stalenessList);
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setOracleFeedMaxStalenessBatch(address[],uint256[])**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStalenessBatch reverts when any staleness is too low
