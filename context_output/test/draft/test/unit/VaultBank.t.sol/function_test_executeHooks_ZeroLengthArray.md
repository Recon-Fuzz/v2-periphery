# Function: test_executeHooks_ZeroLengthArray()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_ZeroLengthArray()`
- **Visibility**: public
- **Source Range**: 44038:688:570

## Implementation

```solidity
function test_executeHooks_ZeroLengthArray() public {
    address[] memory hooks = new address[](0);
    bytes[] memory data = new bytes[](0);
    bytes32[][] memory merkleProofs = new bytes32[][](0);
    uint256[] memory expectedOutputs = new uint256[](hooks.length);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.startPrank(address(this));
    vm.expectRevert(Bank.ZERO_LENGTH_ARRAY.selector);
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
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_ZeroLengthArray() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
