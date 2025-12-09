# Function: test_SuperBank_executeHooks_SlippageProtection_ZeroExpected()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_SlippageProtection_ZeroExpected()`
- **Visibility**: public
- **Source Range**: 71191:1679:658

## Implementation

```solidity
/// @notice Test edge case: zero expected output
function test_SuperBank_executeHooks_SlippageProtection_ZeroExpected() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget = new MockHookTarget();
    MockHookWithSlippage mockHook = new MockHookWithSlippage(address(mockTarget), 50e18);
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook));
    bytes memory hookArgs = abi.encodePacked(address(mockTarget));
    bytes32 hookLeaf = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook), hookArgs))));
    bytes32 merkleRoot = hookLeaf;
    address[] memory hooks = new address[](1);
    hooks[0] = address(mockHook);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(mockHook)), abi.encode(merkleRoot));
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
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_SlippageProtection_ZeroExpected() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test edge case: zero expected output
