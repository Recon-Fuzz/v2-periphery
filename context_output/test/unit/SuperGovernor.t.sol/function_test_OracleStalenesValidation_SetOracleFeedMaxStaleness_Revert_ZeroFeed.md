# Function: test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed()`
- **Visibility**: public
- **Source Range**: 100324:552:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts with zero feed address
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    uint256 validStaleness = 400;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setOracleFeedMaxStaleness(address(0), validStaleness);
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStaleness reverts with zero feed address
