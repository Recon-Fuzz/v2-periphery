# Function: test_ProposeGlobalHooksRoot_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ProposeGlobalHooksRoot_Success()`
- **Visibility**: public
- **Source Range**: 37893:354:659

## Implementation

```solidity
/// @notice Tests proposeGlobalHooksRoot success path
///  @dev Covers SuperGovernor.sol:220-225
function test_ProposeGlobalHooksRoot_Success() public {
    bytes32 newRoot = keccak256("new global hooks root");
    vm.prank(governor);
    superGovernor.proposeGlobalHooksRoot(newRoot);
    (bytes32 proposedRoot, ) = aggregator.getProposedGlobalHooksRoot();
    assertEq(proposedRoot, newRoot, "Proposed root should match");
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
- **SuperGovernor::proposeGlobalHooksRoot(bytes32)**
- **SuperVaultAggregator::getProposedGlobalHooksRoot()**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ProposeGlobalHooksRoot_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
      💬 Args: [proposedRoot, newRoot, "Proposed root should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposeGlobalHooksRoot success path
 @dev Covers SuperGovernor.sol:220-225
