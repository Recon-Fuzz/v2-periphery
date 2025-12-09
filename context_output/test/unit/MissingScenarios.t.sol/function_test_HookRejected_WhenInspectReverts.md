# Function: test_HookRejected_WhenInspectReverts()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `test_HookRejected_WhenInspectReverts()`
- **Visibility**: public
- **Source Range**: 16753:1536:657

## Implementation

```solidity
/// @notice Tests hook rejection when inspect() reverts
///  @dev Covers the catch branch in _validateHookConfiguration when inspect() throws
function test_HookRejected_WhenInspectReverts() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookInspectReverts mockHook = new MockHookInspectReverts();
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook));
    address[] memory hooks = new address[](1);
    hooks[0] = address(mockHook);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(mockHook)), abi.encode(bytes32(uint256(1))));
    vm.expectRevert(Bank.HOOK_VALIDATION_FAILED.selector);
    superBank.executeHooks(executionData);
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.test_HookRejected_WhenInspectReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests hook rejection when inspect() reverts
 @dev Covers the catch branch in _validateHookConfiguration when inspect() throws
