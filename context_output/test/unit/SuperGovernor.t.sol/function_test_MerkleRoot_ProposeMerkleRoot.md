# Function: test_MerkleRoot_ProposeMerkleRoot()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_MerkleRoot_ProposeMerkleRoot()`
- **Visibility**: public
- **Source Range**: 87811:843:659

## Implementation

```solidity
/// @notice Tests proposing a new SuperBank hook merkle root
function test_MerkleRoot_ProposeMerkleRoot() public {
    vm.prank(governor);
    superGovernor.registerHook(hook1);
    bytes32 proposedRoot = keccak256("test_root");
    uint256 expectedTime = block.timestamp + TIMELOCK;
    vm.prank(governor);
    vm.expectEmit(true, true, true, true);
    emit ISuperGovernor.SuperBankHookMerkleRootProposed(hook1, proposedRoot, expectedTime);
    superGovernor.proposeSuperBankHookMerkleRoot(hook1, proposedRoot);
    (bytes32 actualProposedRoot, uint256 effectiveTime) = superGovernor.getProposedSuperBankHookMerkleRoot(hook1);
    assertEq(actualProposedRoot, proposedRoot, "Proposed merkle root mismatch");
    assertEq(effectiveTime, expectedTime, "Effective time mismatch");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::proposeSuperBankHookMerkleRoot(address,bytes32)**
- **SuperGovernor::getProposedSuperBankHookMerkleRoot(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **hook1** (`address`)
- **TIMELOCK** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_MerkleRoot_ProposeMerkleRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
  │   💬 Args: [actualProposedRoot, proposedRoot, "Proposed merkle root mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedTime, "Effective time mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposing a new SuperBank hook merkle root
