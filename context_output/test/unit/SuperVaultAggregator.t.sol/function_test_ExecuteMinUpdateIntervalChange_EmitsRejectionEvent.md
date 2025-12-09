# Function: test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent()`
- **Visibility**: public
- **Source Range**: 216702:941:661

## Implementation

```solidity
/// @notice Test 19: Rejection event emitted when proposal becomes invalid
function test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 100);
    vm.warp((block.timestamp + 3 days) + 1);
    vm.expectEmit(true, false, false, true);
    emit MinUpdateIntervalChanged(strategy, 5, 100);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 100, "Should update to 100");
}
```

## Related Implementations

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
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**
- **SuperVaultAggregator::getMinUpdateInterval(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 100, "Should update to 100"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 19: Rejection event emitted when proposal becomes invalid
