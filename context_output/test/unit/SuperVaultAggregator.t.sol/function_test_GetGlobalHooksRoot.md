# Function: test_GetGlobalHooksRoot()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetGlobalHooksRoot()`
- **Visibility**: public
- **Source Range**: 67999:1118:661

## Implementation

```solidity
/// @notice Tests getGlobalHooksRoot returns the current global hooks root
function test_GetGlobalHooksRoot() public {
    bytes32 currentRoot = superVaultAggregator.getGlobalHooksRoot();
    assertEq(currentRoot, bytes32(0), "Initial global hooks root should be zero");
    bytes32 newRoot = keccak256("newGlobalRoot");
    vm.prank(address(superGovernor));
    superVaultAggregator.proposeGlobalHooksRoot(newRoot);
    currentRoot = superVaultAggregator.getGlobalHooksRoot();
    assertEq(currentRoot, bytes32(0), "Root should still be zero before execution");
    uint256 timelock = superVaultAggregator.getHooksRootUpdateTimelock();
    vm.warp(block.timestamp + timelock);
    superVaultAggregator.executeGlobalHooksRootUpdate();
    currentRoot = superVaultAggregator.getGlobalHooksRoot();
    assertEq(currentRoot, newRoot, "Global hooks root should be updated");
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

- **SuperVaultAggregator::getGlobalHooksRoot()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeGlobalHooksRoot(bytes32)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetGlobalHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
  │   💬 Args: [currentRoot, bytes32(0), "Initial global hooks root should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 2)
  │   💬 Args: [currentRoot, bytes32(0), "Root should still be zero before execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 3)
      💬 Args: [currentRoot, newRoot, "Global hooks root should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getGlobalHooksRoot returns the current global hooks root
