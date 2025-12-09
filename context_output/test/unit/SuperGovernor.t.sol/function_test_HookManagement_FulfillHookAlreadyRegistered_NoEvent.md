# Function: test_HookManagement_FulfillHookAlreadyRegistered_NoEvent()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_FulfillHookAlreadyRegistered_NoEvent()`
- **Visibility**: public
- **Source Range**: 31845:632:659

## Implementation

```solidity
/// @notice Tests that registering an already registered fulfill requests hook doesn't emit events
function test_HookManagement_FulfillHookAlreadyRegistered_NoEvent() public {
    vm.prank(governor);
    superGovernor.registerHook(fulfillHook1);
    assertTrue(superGovernor.isHookRegistered(fulfillHook1), "Hook should be registered");
    vm.prank(governor);
    superGovernor.registerHook(fulfillHook1);
    assertTrue(superGovernor.isHookRegistered(fulfillHook1), "Hook should still be registered");
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
- **SuperGovernor::registerHook(address)**
- **SuperGovernor::isHookRegistered(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **fulfillHook1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_FulfillHookAlreadyRegistered_NoEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isHookRegistered(fulfillHook1), "Hook should be registered"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [superGovernor.isHookRegistered(fulfillHook1), "Hook should still be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that registering an already registered fulfill requests hook doesn't emit events
