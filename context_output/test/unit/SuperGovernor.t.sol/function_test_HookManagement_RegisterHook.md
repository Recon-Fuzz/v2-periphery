# Function: test_HookManagement_RegisterHook()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_RegisterHook()`
- **Visibility**: public
- **Source Range**: 30482:317:659

## Implementation

```solidity
/// @notice Tests registering a hook
function test_HookManagement_RegisterHook() public {
    vm.prank(governor);
    vm.expectEmit(true, false, false, false);
    emit ISuperGovernor.HookApproved(hook1);
    superGovernor.registerHook(hook1);
    assertTrue(superGovernor.isHookRegistered(hook1), "Hook should be registered");
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

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::registerHook(address)**
- **SuperGovernor::isHookRegistered(address)**

## State Variable Reads

- **governor** (`address`)
- **hook1** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_RegisterHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.isHookRegistered(hook1), "Hook should be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests registering a hook
