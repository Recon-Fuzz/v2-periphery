# Function: test_MerkleRoot_ExecuteMerkleRootUpdate()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_ExecuteMerkleRootUpdate()`
- **Visibility**: public
- **Source Range**: 89096:791:659

## Implementation

```solidity
/// @notice Tests executing a merkle root update
function test_MerkleRoot_ExecuteMerkleRootUpdate() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    bytes32 proposedRoot = keccak256("test_root");
    vm.prank(governor);
    superGovernor.proposeSuperBankHookMerkleRoot(hook1, proposedRoot);
    vm.warp((block.timestamp + TIMELOCK) + 1);
    vm.expectEmit(true, true, false, false);
    emit ISuperGovernor.SuperBankHookMerkleRootUpdated(hook1, proposedRoot);
    superGovernor.executeSuperBankHookMerkleRootUpdate(hook1);
    assertEq(superGovernor.getSuperBankHookMerkleRoot(hook1), proposedRoot, "Merkle root mismatch");
}
```

## Related Implementations

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 4521:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **SuperGovernor::proposeSuperBankHookMerkleRoot(address,bytes32)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::executeSuperBankHookMerkleRootUpdate(address)**
- **SuperGovernor::getSuperBankHookMerkleRoot(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_ExecuteMerkleRootUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
      💬 Args: [superGovernor.getSuperBankHookMerkleRoot(hook1), proposedRoot, "Merkle root mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executing a merkle root update
