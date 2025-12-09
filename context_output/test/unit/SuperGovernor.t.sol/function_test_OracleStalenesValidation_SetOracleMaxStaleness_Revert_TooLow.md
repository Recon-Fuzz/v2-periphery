# Function: test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow()`
- **Visibility**: public
- **Source Range**: 98029:692:659

## Implementation

```solidity
/// @notice Tests setOracleMaxStaleness reverts when staleness is too low
function test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    uint256 tooLowStaleness = 200;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.MAX_STALENESS_TOO_LOW.selector);
    superGovernor.setOracleMaxStaleness(tooLowStaleness);
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setOracleMaxStaleness(uint256)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setOracleMaxStaleness reverts when staleness is too low
