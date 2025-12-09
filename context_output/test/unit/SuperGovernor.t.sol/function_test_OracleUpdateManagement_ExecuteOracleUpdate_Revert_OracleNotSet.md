# Function: test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 114107:240:659

## Implementation

```solidity
/// @notice Tests executeOracleUpdate reverts when oracle is not set in registry
function test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet() public {
    vm.prank(oracleManager);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.executeOracleUpdate();
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeOracleUpdate()**

## State Variable Reads

- **oracleManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeOracleUpdate reverts when oracle is not set in registry
