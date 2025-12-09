# Function: test_HookSequence_RevertsAtomically()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_HookSequence_RevertsAtomically()`
- **Visibility**: public
- **Source Range**: 25262:2417:657

## Implementation

```solidity
/// @notice Tests that a failure in any hook reverts the entire sequence
///  @dev Verifies atomic execution: if hook fails with build() error, entire sequence reverts
function test_HookSequence_RevertsAtomically() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook successHook = new MockSuperHook(address(mockTarget));
    MockSuperHook failHook = new MockSuperHook(address(mockTarget));
    failHook.setShouldFailBuild(true);
    vm.startPrank(governor);
    superGovernor.registerHook(address(successHook));
    superGovernor.registerHook(address(failHook));
    vm.stopPrank();
    bytes32 leaf1 = keccak256(bytes.concat(keccak256(abi.encode(address(successHook), abi.encodePacked(mockTarget)))));
    bytes32 leaf2 = keccak256(bytes.concat(keccak256(abi.encode(address(failHook), abi.encodePacked(mockTarget)))));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(successHook)), abi.encode(leaf1));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(failHook)), abi.encode(leaf2));
    address[] memory hooks = new address[](2);
    hooks[0] = address(successHook);
    hooks[1] = address(failHook);
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
    vm.expectRevert("MockSuperHook: build failed");
    superBank.executeHooks(executionData);
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **MockSuperHook::setShouldFailBuild(bool)**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_HookSequence_RevertsAtomically() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that a failure in any hook reverts the entire sequence
 @dev Verifies atomic execution: if hook fails with build() error, entire sequence reverts
