# Function: test_executeHooks_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_Success()`
- **Visibility**: public
- **Source Range**: 48956:1752:570

## Implementation

```solidity
function test_executeHooks_Success() public {
    vm.startPrank(address(this));
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook mockHook1 = new MockSuperHook(address(mockTarget));
    vm.stopPrank();
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook1));
    vm.startPrank(address(this));
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
    vm.expectEmit(true, true, false, false, address(mockTarget));
    emit MockHookTarget.Executed();
    vm.expectEmit(true, true, true, true, address(vaultBank));
    emit Bank.HooksExecuted(hooks, data);
    vaultBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectEmit(bool,bool,bool,bool,address)**
- **TestVaultBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
