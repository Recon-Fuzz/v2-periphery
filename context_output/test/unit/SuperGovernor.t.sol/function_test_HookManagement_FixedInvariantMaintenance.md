# Function: test_HookManagement_FixedInvariantMaintenance()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_FixedInvariantMaintenance()`
- **Visibility**: public
- **Source Range**: 33091:1457:659

## Implementation

```solidity
/// @notice Tests the fix for the dangerous hook registration behavior where sets can get out of sync
function test_HookManagement_FixedInvariantMaintenance() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    assertTrue(superGovernor.isHookRegistered(hook1), "Hook should be in regular set");
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    assertTrue(superGovernor.isHookRegistered(hook1), "Hook should still be in regular set");
    vm.prank(governor);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.HookRemoved(hook1);
    superGovernor.unregisterHook(hook1);
    assertFalse(superGovernor.isHookRegistered(hook1), "Hook should be removed from regular set");
    vm.prank(governor);
    superGovernor.registerHook(hook2);
    vm.prank(governor);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.HookRemoved(hook2);
    superGovernor.unregisterHook(hook2);
    assertFalse(superGovernor.isHookRegistered(hook2), "Hook should be removed");
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **SuperGovernor::isHookRegistered(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::unregisterHook(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)
- **hook2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_FixedInvariantMaintenance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isHookRegistered(hook1), "Hook should be in regular set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isHookRegistered(hook1), "Hook should still be in regular set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.isHookRegistered(hook1), "Hook should be removed from regular set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 4)
      💬 Args: [superGovernor.isHookRegistered(hook2), "Hook should be removed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the fix for the dangerous hook registration behavior where sets can get out of sync
