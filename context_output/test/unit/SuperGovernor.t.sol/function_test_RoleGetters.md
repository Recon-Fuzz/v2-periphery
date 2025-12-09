# Function: test_RoleGetters()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_RoleGetters()`
- **Visibility**: public
- **Source Range**: 20428:379:659

## Implementation

```solidity
function test_RoleGetters() public view {
    assertEq(superGovernor.SUPER_GOVERNOR_ROLE(), keccak256("SUPER_GOVERNOR_ROLE"));
    assertEq(superGovernor.GOVERNOR_ROLE(), keccak256("GOVERNOR_ROLE"));
    assertEq(superGovernor.ORACLE_MANAGER_ROLE(), keccak256("ORACLE_MANAGER_ROLE"));
    assertEq(superGovernor.GUARDIAN_ROLE(), keccak256("GUARDIAN_ROLE"));
}
```

## Related Implementations

### assertEq(bytes32,bytes32)

- **Kind**: internal
- **Source**: 4362:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32)`

```solidity
function assertEq(bytes32 left, bytes32 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperGovernor::SUPER_GOVERNOR_ROLE()**
- **SuperGovernor::GOVERNOR_ROLE()**
- **SuperGovernor::ORACLE_MANAGER_ROLE()**
- **SuperGovernor::GUARDIAN_ROLE()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_RoleGetters() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 1)
  │   💬 Args: [superGovernor.SUPER_GOVERNOR_ROLE(), keccak256("SUPER_GOVERNOR_ROLE")]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 2)
  │   💬 Args: [superGovernor.GOVERNOR_ROLE(), keccak256("GOVERNOR_ROLE")]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 3)
  │   💬 Args: [superGovernor.ORACLE_MANAGER_ROLE(), keccak256("ORACLE_MANAGER_ROLE")]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 4)
      💬 Args: [superGovernor.GUARDIAN_ROLE(), keccak256("GUARDIAN_ROLE")]
      👁️  Def: internal
```
