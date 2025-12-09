# Function: test_SuperBank_executeHooks_ZeroLengthArray()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_ZeroLengthArray()`
- **Visibility**: public
- **Source Range**: 22553:828:658

## Implementation

```solidity
function test_SuperBank_executeHooks_ZeroLengthArray() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    address[] memory hooks = new address[](0);
    bytes[] memory data = new bytes[](0);
    bytes32[][] memory merkleProofs = new bytes32[][](0);
    uint256[] memory expectedOutputs = new uint256[](0);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.startPrank(address(this));
    vm.expectRevert(Bank.ZERO_LENGTH_ARRAY.selector);
    superBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_ZeroLengthArray() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
