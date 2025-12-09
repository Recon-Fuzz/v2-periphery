# Function: test_executeHooks_MultipleHooks()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_MultipleHooks()`
- **Visibility**: public
- **Source Range**: 50714:2297:570

## Implementation

```solidity
function test_executeHooks_MultipleHooks() public {
    vm.startPrank(address(this));
    MockHookTarget mockTarget1 = new MockHookTarget();
    MockHookTarget mockTarget2 = new MockHookTarget();
    MockSuperHook mockHook1 = new MockSuperHook(address(mockTarget1));
    MockSuperHook mockHook2 = new MockSuperHook(address(mockTarget2));
    vm.stopPrank();
    vm.startPrank(governor);
    superGovernor.registerHook(address(mockHook1));
    superGovernor.registerHook(address(mockHook2));
    vm.stopPrank();
    vm.startPrank(address(this));
    bytes memory hookArgs1 = abi.encodePacked(address(mockTarget1));
    bytes memory hookArgs2 = abi.encodePacked(address(mockTarget2));
    bytes32 hookLeaf1 = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook1), hookArgs1))));
    bytes32 hookLeaf2 = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook2), hookArgs2))));
    bytes32 merkleRoot1 = hookLeaf1;
    bytes32 merkleRoot2 = hookLeaf2;
    address[] memory hooks = new address[](2);
    hooks[0] = address(mockHook1);
    hooks[1] = address(mockHook2);
    bytes[] memory data = new bytes[](2);
    data[0] = "data1";
    data[1] = "data2";
    bytes32[][] memory merkleProofs = new bytes32[][](2);
    merkleProofs[0] = new bytes32[](0);
    merkleProofs[1] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](hooks.length);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superRegistry), abi.encodeWithSignature("getVaultBankHookMerkleRoot(address)", address(mockHook1)), abi.encode(merkleRoot1));
    vm.mockCall(address(superRegistry), abi.encodeWithSignature("getVaultBankHookMerkleRoot(address)", address(mockHook2)), abi.encode(merkleRoot2));
    vaultBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **TestVaultBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_MultipleHooks() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
