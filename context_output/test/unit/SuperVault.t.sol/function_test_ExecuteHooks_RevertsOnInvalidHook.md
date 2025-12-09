# Function: test_ExecuteHooks_RevertsOnInvalidHook()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ExecuteHooks_RevertsOnInvalidHook()`
- **Visibility**: public
- **Source Range**: 91977:1174:660

## Implementation

```solidity
/// @notice Tests executeHooks reverts when a hook is not registered
function test_ExecuteHooks_RevertsOnInvalidHook() public {
    address[] memory hooks = new address[](1);
    hooks[0] = address(0x999);
    bytes[] memory hookCalldata = new bytes[](1);
    hookCalldata[0] = "";
    uint256[] memory expectedOut = new uint256[](1);
    expectedOut[0] = 0;
    bytes32[][] memory globalProofs = new bytes32[][](1);
    globalProofs[0] = new bytes32[](0);
    bytes32[][] memory strategyProofs = new bytes32[][](1);
    strategyProofs[0] = new bytes32[](0);
    ISuperVaultStrategy.ExecuteArgs memory args = ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedOut, globalProofs: globalProofs, strategyProofs: strategyProofs});
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_HOOK.selector);
    strategy.executeHooks(args);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::executeHooks(struct ISuperVaultStrategy.ExecuteArgs)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ExecuteHooks_RevertsOnInvalidHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeHooks reverts when a hook is not registered
