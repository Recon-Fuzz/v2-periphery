# Function: test_HookManagement_GetRegisteredHooks()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HookManagement_GetRegisteredHooks()`
- **Visibility**: public
- **Source Range**: 34613:558:659

## Implementation

```solidity
/// @notice Tests getting the list of registered hooks
function test_HookManagement_GetRegisteredHooks() public {
    vm.startPrank(governor);
    superGovernor.registerHook(hook1);
    superGovernor.registerHook(hook2);
    vm.stopPrank();
    address[] memory hooks = superGovernor.getRegisteredHooks();
    assertEq(hooks.length, 2, "Should have 2 registered hooks");
    assertTrue((hooks[0] == hook1) || (hooks[1] == hook1), "hook1 should be in the list");
    assertTrue((hooks[0] == hook2) || (hooks[1] == hook2), "hook2 should be in the list");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

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

- **Vm::startPrank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::stopPrank()**
- **SuperGovernor::getRegisteredHooks()**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)
- **hook2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HookManagement_GetRegisteredHooks() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [hooks.length, 2, "Should have 2 registered hooks"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [(hooks[0] == hook1) || (hooks[1] == hook1), "hook1 should be in the list"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [(hooks[0] == hook2) || (hooks[1] == hook2), "hook2 should be in the list"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getting the list of registered hooks
