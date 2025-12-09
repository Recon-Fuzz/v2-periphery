# Function: test_MerkleRoot_Revert_ExecuteHookNotApproved()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_Revert_ExecuteHookNotApproved()`
- **Visibility**: public
- **Source Range**: 90391:206:659

## Implementation

```solidity
/// @notice Tests reverting when executing a merkle root update for an unregistered hook
function test_MerkleRoot_Revert_ExecuteHookNotApproved() public {
    vm.expectRevert(ISuperGovernor.HOOK_NOT_APPROVED.selector);
    superGovernor.executeSuperBankHookMerkleRootUpdate(hook1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeSuperBankHookMerkleRootUpdate(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_Revert_ExecuteHookNotApproved() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing a merkle root update for an unregistered hook
