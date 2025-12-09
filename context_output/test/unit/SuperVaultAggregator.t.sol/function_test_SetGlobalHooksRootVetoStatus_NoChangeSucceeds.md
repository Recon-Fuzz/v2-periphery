# Function: test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds()`
- **Visibility**: public
- **Source Range**: 48518:903:661

## Implementation

```solidity
/// @notice Tests that setGlobalHooksRootVetoStatus succeeds when status doesn't change
function test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds() public {
    bool currentStatus = superVaultAggregator.isGlobalHooksRootVetoed();
    vm.prank(address(superGovernor));
    superVaultAggregator.setGlobalHooksRootVetoStatus(currentStatus);
    assertEq(superVaultAggregator.isGlobalHooksRootVetoed(), currentStatus, "Status should remain unchanged");
    vm.prank(address(superGovernor));
    superVaultAggregator.setGlobalHooksRootVetoStatus(currentStatus);
    assertEq(superVaultAggregator.isGlobalHooksRootVetoed(), currentStatus, "Status should still be unchanged");
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::isGlobalHooksRootVetoed()**
- **Vm::prank(address)**
- **SuperVaultAggregator::setGlobalHooksRootVetoStatus(bool)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.isGlobalHooksRootVetoed(), currentStatus, "Status should remain unchanged"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 2)
      💬 Args: [superVaultAggregator.isGlobalHooksRootVetoed(), currentStatus, "Status should still be unchanged"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that setGlobalHooksRootVetoStatus succeeds when status doesn't change
