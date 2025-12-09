# Function: test_OracleStalenesValidation_RoleAssignments()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_RoleAssignments()`
- **Visibility**: public
- **Source Range**: 96629:416:659

## Implementation

```solidity
/// @notice Tests that roles are properly assigned for oracle tests
function test_OracleStalenesValidation_RoleAssignments() public view {
    assertTrue(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should have SUPER_GOVERNOR_ROLE");
    assertTrue(superGovernor.hasRole(GOVERNOR_ROLE, governor), "governor should have GOVERNOR_ROLE");
    assertTrue(superGovernor.hasRole(BANK_MANAGER_ROLE, governor), "governor should have BANK_MANAGER_ROLE");
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

- **SuperGovernor::hasRole(bytes32,address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **sGovernor** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **governor** (`address`)
- **BANK_MANAGER_ROLE** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_RoleAssignments() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "sGovernor should have SUPER_GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.hasRole(GOVERNOR_ROLE, governor), "governor should have GOVERNOR_ROLE"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [superGovernor.hasRole(BANK_MANAGER_ROLE, governor), "governor should have BANK_MANAGER_ROLE"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that roles are properly assigned for oracle tests
