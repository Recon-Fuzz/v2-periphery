# Function: test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds()`
- **Visibility**: public
- **Source Range**: 52890:1020:661

## Implementation

```solidity
/// @notice Tests that setStrategyHooksRootVetoStatus succeeds when status doesn't change
function test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds() public {
    bool currentStatus = superVaultAggregator.isStrategyHooksRootVetoed(strategy);
    vm.prank(address(superGovernor));
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, currentStatus);
    assertEq(superVaultAggregator.isStrategyHooksRootVetoed(strategy), currentStatus, "Status should remain unchanged");
    vm.prank(address(superGovernor));
    superVaultAggregator.setStrategyHooksRootVetoStatus(strategy, currentStatus);
    assertEq(superVaultAggregator.isStrategyHooksRootVetoed(strategy), currentStatus, "Status should still be unchanged");
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

- **SuperVaultAggregator::isStrategyHooksRootVetoed(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::setStrategyHooksRootVetoStatus(address,bool)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.isStrategyHooksRootVetoed(strategy), currentStatus, "Status should remain unchanged"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 2)
      💬 Args: [superVaultAggregator.isStrategyHooksRootVetoed(strategy), currentStatus, "Status should still be unchanged"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that setStrategyHooksRootVetoStatus succeeds when status doesn't change
