# Function: test_executeHooks_HookExecutionFailed()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_HookExecutionFailed()`
- **Visibility**: public
- **Source Range**: 47281:1669:570

## Implementation

```solidity
function test_executeHooks_HookExecutionFailed() public {
    MockHookTarget mockTarget = new MockHookTarget();
    mockTarget.setShouldFailExecution(true);
    mockTarget.setShouldFailExecution(true);
    MockSuperHook mockHook1 = new MockSuperHook(address(mockTarget));
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook1));
    bytes memory hookArgs = abi.encodePacked(address(mockTarget));
    bytes32 hookLeaf = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook1), hookArgs))));
    bytes32 merkleRoot = hookLeaf;
    address[] memory hooks = new address[](1);
    hooks[0] = address(mockHook1);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](hooks.length);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superRegistry), abi.encodeWithSignature("getVaultBankHookMerkleRoot(address)", address(mockHook1)), abi.encode(merkleRoot));
    vm.startPrank(address(this));
    vm.expectRevert(Bank.HOOK_EXECUTION_FAILED.selector);
    vaultBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **MockHookTarget::setShouldFailExecution(bool)**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::executeHooks(struct IHookExecutionData.HookExecutionData)**
- **Vm::stopPrank()**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_HookExecutionFailed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
