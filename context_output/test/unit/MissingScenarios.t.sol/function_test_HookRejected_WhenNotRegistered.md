# Function: test_HookRejected_WhenNotRegistered()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_HookRejected_WhenNotRegistered()`
- **Visibility**: public
- **Source Range**: 20286:1353:657

## Implementation

```solidity
/// @notice Tests that unregistered hooks are rejected
///  @dev Verifies HOOK_NOT_REGISTERED error when hook not in SuperGovernor
function test_HookRejected_WhenNotRegistered() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook unregisteredHook = new MockSuperHook(address(mockTarget));
    assertFalse(superGovernor.isHookRegistered(address(unregisteredHook)), "Hook should not be registered");
    address[] memory hooks = new address[](1);
    hooks[0] = address(unregisteredHook);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectRevert(Bank.HOOK_NOT_REGISTERED.selector);
    superBank.executeHooks(executionData);
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

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **SuperGovernor::isHookRegistered(address)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_HookRejected_WhenNotRegistered() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.isHookRegistered(address(unregisteredHook)), "Hook should not be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that unregistered hooks are rejected
 @dev Verifies HOOK_NOT_REGISTERED error when hook not in SuperGovernor
