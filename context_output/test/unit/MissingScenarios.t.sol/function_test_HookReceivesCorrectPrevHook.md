# Function: test_HookReceivesCorrectPrevHook()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_HookReceivesCorrectPrevHook()`
- **Visibility**: public
- **Source Range**: 22179:2665:657

## Implementation

```solidity
/// @notice Tests that hooks receive correct prevHook parameter via preExecute events
///  @dev Verifies context isolation: first hook gets address(0), subsequent hooks get previous hook address
///  Note: This test verifies the hook framework passes prevHook correctly by checking emitted events
function test_HookReceivesCorrectPrevHook() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook hook1 = new MockSuperHook(address(mockTarget));
    MockSuperHook hook2 = new MockSuperHook(address(mockTarget));
    vm.startPrank(governor);
    superGovernor.registerHook(address(hook1));
    superGovernor.registerHook(address(hook2));
    vm.stopPrank();
    bytes32 leaf1 = keccak256(bytes.concat(keccak256(abi.encode(address(hook1), abi.encodePacked(mockTarget)))));
    bytes32 leaf2 = keccak256(bytes.concat(keccak256(abi.encode(address(hook2), abi.encodePacked(mockTarget)))));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(hook1)), abi.encode(leaf1));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(hook2)), abi.encode(leaf2));
    address[] memory hooks = new address[](2);
    hooks[0] = address(hook1);
    hooks[1] = address(hook2);
    bytes[] memory data = new bytes[](2);
    data[0] = "data1";
    data[1] = "data2";
    bytes32[][] memory merkleProofs = new bytes32[][](2);
    merkleProofs[0] = new bytes32[](0);
    merkleProofs[1] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](2);
    expectedOutputs[0] = 0;
    expectedOutputs[1] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectEmit(true, true, false, false);
    emit MockSuperHook.PreExecuteCalled(address(0), address(superBank), "data1");
    vm.expectEmit(true, true, false, false);
    emit MockSuperHook.PreExecuteCalled(address(hook1), address(superBank), "data2");
    superBank.executeHooks(executionData);
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_HookReceivesCorrectPrevHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that hooks receive correct prevHook parameter via preExecute events
 @dev Verifies context isolation: first hook gets address(0), subsequent hooks get previous hook address
 Note: This test verifies the hook framework passes prevHook correctly by checking emitted events
