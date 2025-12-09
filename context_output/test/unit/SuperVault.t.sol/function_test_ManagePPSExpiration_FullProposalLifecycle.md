# Function: test_ManagePPSExpiration_FullProposalLifecycle()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManagePPSExpiration_FullProposalLifecycle()`
- **Visibility**: public
- **Source Range**: 144950:726:660

## Implementation

```solidity
/// @notice Tests full proposal lifecycle: propose -> cancel -> propose again
///  @dev Covers complete workflow
function test_ManagePPSExpiration_FullProposalLifecycle() public {
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 3 hours);
    vm.warp((block.timestamp + 1 weeks) + 1);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::warp(uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManagePPSExpiration_FullProposalLifecycle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests full proposal lifecycle: propose -> cancel -> propose again
 @dev Covers complete workflow
