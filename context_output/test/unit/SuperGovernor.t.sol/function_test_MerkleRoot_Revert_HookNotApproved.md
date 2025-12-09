# Function: test_MerkleRoot_Revert_HookNotApproved()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_Revert_HookNotApproved()`
- **Visibility**: public
- **Source Range**: 88746:291:659

## Implementation

```solidity
/// @notice Tests reverting when proposing a merkle root for an unregistered hook
function test_MerkleRoot_Revert_HookNotApproved() public {
    bytes32 proposedRoot = keccak256("test_root");
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.HOOK_NOT_APPROVED.selector);
    superGovernor.proposeSuperBankHookMerkleRoot(hook1, proposedRoot);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::proposeSuperBankHookMerkleRoot(address,bytes32)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_Revert_HookNotApproved() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing a merkle root for an unregistered hook
