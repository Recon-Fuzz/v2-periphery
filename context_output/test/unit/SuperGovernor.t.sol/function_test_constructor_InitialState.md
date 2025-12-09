# Function: test_constructor_InitialState()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_constructor_InitialState()`
- **Visibility**: public
- **Source Range**: 6713:505:659

## Implementation

```solidity
/// @notice Tests if the constructor correctly sets initial roles and treasury.
function test_constructor_InitialState() public view {
    assertTrue(superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "Admin should have SUPER_GOVERNOR_ROLE");
    assertTrue(superGovernor.hasRole(GOVERNOR_ROLE, governor), "Governor should have GOVERNOR_ROLE");
    assertTrue(superGovernor.hasRole(BANK_MANAGER_ROLE, governor), "Governor should have BANK_MANAGER_ROLE");
    assertEq(superGovernor.getAddress(superGovernor.TREASURY()), treasury, "Treasury address mismatch");
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperGovernor::hasRole(bytes32,address)**
- **SuperGovernor::getAddress(bytes32)**
- **SuperGovernor::TREASURY()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **SUPER_GOVERNOR_ROLE** (`bytes32`)
- **sGovernor** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **governor** (`address`)
- **BANK_MANAGER_ROLE** (`bytes32`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_constructor_InitialState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.hasRole(SUPER_GOVERNOR_ROLE, sGovernor), "Admin should have SUPER_GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.hasRole(GOVERNOR_ROLE, governor), "Governor should have GOVERNOR_ROLE"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.hasRole(BANK_MANAGER_ROLE, governor), "Governor should have BANK_MANAGER_ROLE"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [superGovernor.getAddress(superGovernor.TREASURY()), treasury, "Treasury address mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests if the constructor correctly sets initial roles and treasury.
