# Function: test_CancelPPSExpirationProposal_RevertsOnNoProposal()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CancelPPSExpirationProposal_RevertsOnNoProposal()`
- **Visibility**: public
- **Source Range**: 140912:310:660

## Implementation

```solidity
/// @notice Tests cancelPPSExpirationProposalUpdate reverts when no proposal exists
///  @dev Covers SuperVaultStrategy.sol:924
function test_CancelPPSExpirationProposal_RevertsOnNoProposal() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.NO_PROPOSAL.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CancelPPSExpirationProposal_RevertsOnNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests cancelPPSExpirationProposalUpdate reverts when no proposal exists
 @dev Covers SuperVaultStrategy.sol:924
