# Function: test_MerkleRoot_Revert_ExecuteBeforeTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 91131:555:659

## Implementation

```solidity
/// @notice Tests reverting when executing a merkle root update before timelock expiry
function test_MerkleRoot_Revert_ExecuteBeforeTimelock() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    bytes32 proposedRoot = keccak256("test_root");
    vm.prank(governor);
    superGovernor.proposeSuperBankHookMerkleRoot(hook1, proposedRoot);
    vm.expectRevert(ISuperGovernor.TIMELOCK_NOT_EXPIRED.selector);
    superGovernor.executeSuperBankHookMerkleRootUpdate(hook1);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **SuperGovernor::proposeSuperBankHookMerkleRoot(address,bytes32)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeSuperBankHookMerkleRootUpdate(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_Revert_ExecuteBeforeTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when executing a merkle root update before timelock expiry
