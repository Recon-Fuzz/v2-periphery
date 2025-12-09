# Function: test_SuperBank_executeHooks_NotBankManager()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_NotBankManager()`
- **Visibility**: public
- **Source Range**: 21633:914:658

## Implementation

```solidity
/// @notice Tests executeHooks reverts when caller is not bank manager
///  @dev Covers SuperBank.sol:36-37 - access control check in executeHooks
function test_SuperBank_executeHooks_NotBankManager() public {
    vm.startPrank(user);
    address[] memory hooks = new address[](1);
    hooks[0] = address(0x1111);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](1);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.expectRevert(ISuperBank.INVALID_BANK_MANAGER.selector);
    superBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_NotBankManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeHooks reverts when caller is not bank manager
 @dev Covers SuperBank.sol:36-37 - access control check in executeHooks
