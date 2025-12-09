# Function: test_SuperBank_executeHooks_SingleLeafTreeValidation()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_executeHooks_SingleLeafTreeValidation()`
- **Visibility**: public
- **Source Range**: 39597:1978:658

## Implementation

```solidity
/// @notice Tests single-leaf tree validation (empty proof, root equals leaf)
///  @dev Covers Bank.sol:205-206 - single-leaf tree case
function test_SuperBank_executeHooks_SingleLeafTreeValidation() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook mockHook = new MockSuperHook(address(mockTarget));
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook));
    address[] memory hooks = new address[](1);
    hooks[0] = address(mockHook);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](0);
    uint256[] memory expectedOutputs = new uint256[](1);
    expectedOutputs[0] = 0;
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    bytes memory hookArgs = abi.encodePacked(address(mockTarget));
    bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(address(mockHook), hookArgs))));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(mockHook)), abi.encode(leaf));
    vm.expectEmit(true, true, false, false, address(mockTarget));
    emit MockHookTarget.Executed();
    vm.expectEmit(true, true, true, true, address(superBank));
    emit Bank.HooksExecuted(hooks, data);
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
- **Vm::expectEmit(bool,bool,bool,bool,address)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_executeHooks_SingleLeafTreeValidation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests single-leaf tree validation (empty proof, root equals leaf)
 @dev Covers Bank.sol:205-206 - single-leaf tree case
