# Function: test_MinUpdateIntervalChange_ImmediatelyEffective()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_MinUpdateIntervalChange_ImmediatelyEffective()`
- **Visibility**: public
- **Source Range**: 210791:1114:661

## Implementation

```solidity
/// @notice Test 14: Changed interval is immediately effective
function test_MinUpdateIntervalChange_ImmediatelyEffective() public {
    uint256 oldInterval = superVaultAggregator.getMinUpdateInterval(strategy);
    assertEq(oldInterval, 5, "Initial interval should be 5");
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 100);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    uint256 newInterval = superVaultAggregator.getMinUpdateInterval(strategy);
    assertEq(newInterval, 100, "New interval should be 100");
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 50);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 50, "Interval should be 50 immediately after execution");
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

- **SuperVaultAggregator::getMinUpdateInterval(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_MinUpdateIntervalChange_ImmediatelyEffective() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [oldInterval, 5, "Initial interval should be 5"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [newInterval, 100, "New interval should be 100"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 50, "Interval should be 50 immediately after execution"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 14: Changed interval is immediately effective
