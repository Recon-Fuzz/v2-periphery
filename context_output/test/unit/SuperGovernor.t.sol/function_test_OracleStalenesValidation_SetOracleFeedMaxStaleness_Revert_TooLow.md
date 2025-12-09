# Function: test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow()`
- **Visibility**: public
- **Source Range**: 99614:625:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts when staleness is too low
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address feed = address(0x123);
    uint256 tooLowStaleness = 250;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.MAX_STALENESS_TOO_LOW.selector);
    superGovernor.setOracleFeedMaxStaleness(feed, tooLowStaleness);
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setOracleFeedMaxStaleness(address,uint256)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStaleness reverts when staleness is too low
