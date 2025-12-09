# Function: test_SuperBank_executeHooks_InvalidArrayLength()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_InvalidArrayLength()`
- **Visibility**: public
- **Source Range**: 23387:1050:658

## Implementation

```solidity
function test_SuperBank_executeHooks_InvalidArrayLength() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    address[] memory hooks = new address[](2);
    hooks[0] = address(0x1111);
    hooks[1] = address(0x2222);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](2);
    merkleProofs[0] = new bytes32[](1);
    merkleProofs[1] = new bytes32[](1);
    uint256[] memory expectedOutputs = new uint256[](2);
    expectedOutputs[0] = 0;
    expectedOutputs[1] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectRevert(Bank.INVALID_ARRAY_LENGTH.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_InvalidArrayLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
