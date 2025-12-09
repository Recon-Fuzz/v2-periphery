# Function: test_SuperBank_executeHooks_HookNotRegistered()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_HookNotRegistered()`
- **Visibility**: public
- **Source Range**: 27056:1055:658

## Implementation

```solidity
/// @notice Tests executeHooks reverts when hook is not registered
///  @dev Covers Bank.sol:92 - if (!_isHookRegistered(hookAddress)) revert HOOK_NOT_REGISTERED()
function test_SuperBank_executeHooks_HookNotRegistered() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    address unregisteredHook = address(0x9999);
    address[] memory hooks = new address[](1);
    hooks[0] = unregisteredHook;
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](1);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectRevert(Bank.HOOK_NOT_REGISTERED.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_HookNotRegistered() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeHooks reverts when hook is not registered
 @dev Covers Bank.sol:92 - if (!_isHookRegistered(hookAddress)) revert HOOK_NOT_REGISTERED()
