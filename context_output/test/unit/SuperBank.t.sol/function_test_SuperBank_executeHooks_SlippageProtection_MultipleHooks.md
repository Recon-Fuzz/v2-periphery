# Function: test_SuperBank_executeHooks_SlippageProtection_MultipleHooks()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_SlippageProtection_MultipleHooks()`
- **Visibility**: public
- **Source Range**: 68679:2453:658

## Implementation

```solidity
/// @notice Test that slippage protection works with multiple hooks
function test_SuperBank_executeHooks_SlippageProtection_MultipleHooks() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget1 = new MockHookTarget();
    MockHookTarget mockTarget2 = new MockHookTarget();
    MockHookWithSlippage mockHook1 = new MockHookWithSlippage(address(mockTarget1), 100e18);
    MockHookWithSlippage mockHook2 = new MockHookWithSlippage(address(mockTarget2), 200e18);
    vm.startPrank(governor);
    superGovernor.registerHook(address(mockHook1));
    superGovernor.registerHook(address(mockHook2));
    vm.stopPrank();
    bytes memory hookArgs1 = abi.encodePacked(address(mockTarget1));
    bytes memory hookArgs2 = abi.encodePacked(address(mockTarget2));
    bytes32 hookLeaf1 = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook1), hookArgs1))));
    bytes32 hookLeaf2 = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook2), hookArgs2))));
    address[] memory hooks = new address[](2);
    hooks[0] = address(mockHook1);
    hooks[1] = address(mockHook2);
    bytes[] memory data = new bytes[](2);
    data[0] = "data1";
    data[1] = "data2";
    bytes32[][] memory merkleProofs = new bytes32[][](2);
    merkleProofs[0] = new bytes32[](0);
    merkleProofs[1] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](2);
    expectedOutputs[0] = 100e18;
    expectedOutputs[1] = 150e18;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(mockHook1)), abi.encode(hookLeaf1));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(mockHook2)), abi.encode(hookLeaf2));
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
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_SlippageProtection_MultipleHooks() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test that slippage protection works with multiple hooks
