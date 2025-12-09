# Function: test_CancelPPSExpirationProposal_EmitsEvent()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CancelPPSExpirationProposal_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 143165:553:660

## Implementation

```solidity
/// @notice Tests cancelPPSExpirationProposal emits correct event
///  @dev Covers SuperVaultStrategy.sol:929 - event emission
function test_CancelPPSExpirationProposal_EmitsEvent() public {
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultStrategy.PPSExpiryThresholdProposalCanceled();
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CancelPPSExpirationProposal_EmitsEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests cancelPPSExpirationProposal emits correct event
 @dev Covers SuperVaultStrategy.sol:929 - event emission
