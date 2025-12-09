# Function: test_OracleStalenesValidation_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 105780:277:659

## Implementation

```solidity
/// @notice Tests reverting when oracle is not set in registry
function test_OracleStalenesValidation_Revert_OracleNotSet() public {
    uint256 validStaleness = 400;
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.setOracleMaxStaleness(validStaleness);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setOracleMaxStaleness(uint256)**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when oracle is not set in registry
