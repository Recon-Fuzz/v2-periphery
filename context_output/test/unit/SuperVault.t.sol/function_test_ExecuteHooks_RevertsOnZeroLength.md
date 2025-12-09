# Function: test_ExecuteHooks_RevertsOnZeroLength()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ExecuteHooks_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 86265:633:660

## Implementation

```solidity
/// @notice Tests executeHooks reverts when hooks array is empty
///  @dev Covers SuperVaultStrategy.sol:275
function test_ExecuteHooks_RevertsOnZeroLength() public {
    ISuperVaultStrategy.ExecuteArgs memory args = ISuperVaultStrategy.ExecuteArgs({hooks: new address[](0), hookCalldata: new bytes[](0), expectedAssetsOrSharesOut: new uint256[](0), globalProofs: new bytes32[][](0), strategyProofs: new bytes32[][](0)});
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_LENGTH.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ExecuteHooks_RevertsOnZeroLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeHooks reverts when hooks array is empty
 @dev Covers SuperVaultStrategy.sol:275
