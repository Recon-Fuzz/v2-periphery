# Function: test_CancelPPSExpirationProposal_ClearsStateVariables()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CancelPPSExpirationProposal_ClearsStateVariables()`
- **Visibility**: public
- **Source Range**: 141978:1047:660

## Implementation

```solidity
/// @notice Tests cancelPPSExpirationProposal properly clears state variables
///  @dev Covers SuperVaultStrategy.sol:926-927 - verifies both state variables are cleared
function test_CancelPPSExpirationProposal_ClearsStateVariables() public {
    uint256 proposalThreshold = 3 hours;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, proposalThreshold);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.NO_PROPOSAL.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CancelPPSExpirationProposal_ClearsStateVariables() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests cancelPPSExpirationProposal properly clears state variables
 @dev Covers SuperVaultStrategy.sol:926-927 - verifies both state variables are cleared
