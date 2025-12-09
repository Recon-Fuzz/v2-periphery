# Function: test_executeHooks_InvalidArrayLength()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_InvalidArrayLength()`
- **Visibility**: public
- **Source Range**: 44732:884:570

## Implementation

```solidity
function test_executeHooks_InvalidArrayLength() public {
    vm.startPrank(address(this));
    address[] memory hooks = new address[](2);
    hooks[0] = address(0x1111);
    hooks[1] = address(0x2222);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](2);
    merkleProofs[0] = new bytes32[](1);
    merkleProofs[1] = new bytes32[](1);
    uint256[] memory expectedOutputs = new uint256[](hooks.length);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectRevert(Bank.INVALID_ARRAY_LENGTH.selector);
    vaultBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::executeHooks(struct IHookExecutionData.HookExecutionData)**
- **Vm::stopPrank()**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_InvalidArrayLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
