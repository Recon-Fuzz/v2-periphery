# Function: test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch()`
- **Visibility**: public
- **Source Range**: 90793:1105:660

## Implementation

```solidity
/// @notice Tests executeHooks reverts when strategyProofs length doesn't match hooks length
///  @dev Covers SuperVaultStrategy.sol:279
function test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch() public {
    address[] memory hooks = new address[](2);
    hooks[0] = address(0x1);
    hooks[1] = address(0x2);
    bytes[] memory hookCalldata = new bytes[](2);
    hookCalldata[0] = "";
    hookCalldata[1] = "";
    uint256[] memory expectedOut = new uint256[](2);
    bytes32[][] memory globalProofs = new bytes32[][](2);
    bytes32[][] memory strategyProofs = new bytes32[][](4);
    ISuperVaultStrategy.ExecuteArgs memory args = ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedOut, globalProofs: globalProofs, strategyProofs: strategyProofs});
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_ARRAY_LENGTH.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeHooks reverts when strategyProofs length doesn't match hooks length
 @dev Covers SuperVaultStrategy.sol:279
