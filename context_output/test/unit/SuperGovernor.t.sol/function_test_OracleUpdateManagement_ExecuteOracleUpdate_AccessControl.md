# Function: test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl()`
- **Visibility**: public
- **Source Range**: 114446:1230:659

## Implementation

```solidity
/// @notice Tests executeOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
function test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, ORACLE_MANAGER_ROLE));
    superGovernor.executeOracleUpdate();
    vm.prank(governor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, governor, ORACLE_MANAGER_ROLE));
    superGovernor.executeOracleUpdate();
    vm.prank(oracleManager);
    superGovernor.executeOracleUpdate();
    assertTrue(mockOracle.oracleUpdateExecuted(), "sGovernor should be able to execute oracle update");
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::executeOracleUpdate()**
- **MockSuperOracleForStaleness::oracleUpdateExecuted()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **user** (`address`)
- **ORACLE_MANAGER_ROLE** (`bytes32`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [mockOracle.oracleUpdateExecuted(), "sGovernor should be able to execute oracle update"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
