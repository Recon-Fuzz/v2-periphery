# Function: test_MerkleRoot_Revert_ExecuteNoProposal()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 90681:353:659

## Implementation

```solidity
/// @notice Tests reverting when executing without a merkle root proposal
function test_MerkleRoot_Revert_ExecuteNoProposal() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    vm.expectRevert(ISuperGovernor.NO_PROPOSED_MERKLE_ROOT.selector);
    superGovernor.executeSuperBankHookMerkleRootUpdate(hook1);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeSuperBankHookMerkleRootUpdate(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_Revert_ExecuteNoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing without a merkle root proposal
