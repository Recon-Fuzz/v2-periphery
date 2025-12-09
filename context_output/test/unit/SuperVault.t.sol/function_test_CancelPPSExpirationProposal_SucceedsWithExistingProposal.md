# Function: test_CancelPPSExpirationProposal_SucceedsWithExistingProposal()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CancelPPSExpirationProposal_SucceedsWithExistingProposal()`
- **Visibility**: public
- **Source Range**: 141359:436:660

## Implementation

```solidity
/// @notice Tests cancelPPSExpirationProposal succeeds when proposal exists
///  @dev Covers SuperVaultStrategy.sol:926-927
function test_CancelPPSExpirationProposal_SucceedsWithExistingProposal() public {
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CancelPPSExpirationProposal_SucceedsWithExistingProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests cancelPPSExpirationProposal succeeds when proposal exists
 @dev Covers SuperVaultStrategy.sol:926-927
