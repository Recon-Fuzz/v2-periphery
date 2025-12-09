# Function: test_GetProposedGlobalHooksRoot()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetProposedGlobalHooksRoot()`
- **Visibility**: public
- **Source Range**: 69213:867:661

## Implementation

```solidity
/// @notice Tests getProposedGlobalHooksRoot returns proposed root and effective time
function test_GetProposedGlobalHooksRoot() public {
    (bytes32 proposedRoot, uint256 effectiveTime) = superVaultAggregator.getProposedGlobalHooksRoot();
    assertEq(proposedRoot, bytes32(0), "Initial proposed root should be zero");
    assertEq(effectiveTime, 0, "Initial effective time should be zero");
    bytes32 newRoot = keccak256("proposedRoot");
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    (proposedRoot, effectiveTime) = superVaultAggregator.getProposedGlobalHooksRoot();
    assertEq(proposedRoot, newRoot, "Proposed root should match");
    assertGt(effectiveTime, block.timestamp, "Effective time should be in future");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::getProposedGlobalHooksRoot()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetProposedGlobalHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
  │   💬 Args: [proposedRoot, bytes32(0), "Initial proposed root should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime, 0, "Initial effective time should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 3)
  │   💬 Args: [proposedRoot, newRoot, "Proposed root should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
      💬 Args: [effectiveTime, block.timestamp, "Effective time should be in future"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getProposedGlobalHooksRoot returns proposed root and effective time
