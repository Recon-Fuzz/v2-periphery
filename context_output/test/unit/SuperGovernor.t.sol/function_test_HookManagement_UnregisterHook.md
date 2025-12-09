# Function: test_HookManagement_UnregisterHook()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_UnregisterHook()`
- **Visibility**: public
- **Source Range**: 32526:453:659

## Implementation

```solidity
/// @notice Tests unregistering a hook
function test_HookManagement_UnregisterHook() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    vm.prank(governor);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.HookRemoved(hook1);
    superGovernor.unregisterHook(hook1);
    assertFalse(superGovernor.isHookRegistered(hook1), "Hook should be unregistered");
}
```

## Related Implementations

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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::unregisterHook(address)**
- **SuperGovernor::isHookRegistered(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_UnregisterHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.isHookRegistered(hook1), "Hook should be unregistered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests unregistering a hook
